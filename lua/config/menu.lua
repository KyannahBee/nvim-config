-- Two-pane settings menu, opened with :ConfigSettings (or <leader>cs if free).
-- Left pane lists plugin groups, right pane lists that group's settings.
-- Every edit auto-saves to lua/config/local.json. Settings in `live_apply`
-- are applied immediately; all others are marked and Neovim restarts on exit
-- to apply them.
local settings = require("config.settings")

local M = {}

-- Groups in first-appearance order, with their entries
local groups = {}
local by_group = {}
for _, e in ipairs(settings.entries) do
    if by_group[e.group] == nil then
        by_group[e.group] = {}
        groups[#groups + 1] = e.group
    end
    table.insert(by_group[e.group], e)
end

local state = {
    group_idx = 1,
    entry_idx = 1,
    restart_keys = {}, -- keys changed this session that need a restart
    status = "",
    wins = {},
    bufs = {},
    ns = vim.api.nvim_create_namespace("config-settings-menu"),
    augroup = vim.api.nvim_create_augroup("ConfigSettingsMenu", { clear = true }),
}

-- Settings that can be applied without a restart
local function apply_theme()
    require("catppuccin").setup({
        flavour = settings.get("theme.flavour"),
        transparent_background = settings.get("theme.transparent_background"),
        custom_highlights = function()
            return {
                SignColumn = { bg = "none" },
                EndOfBuffer = { bg = "none" },
            }
        end,
    })
    vim.cmd.colorscheme("catppuccin")
end

-- Re-running the harness plugin spec re-applies its whole setup from current
-- settings, so any harness.* key can live-apply
local function apply_harness()
    require("plugins.llm-harness").config()
end

local live_apply = {
    ["theme.flavour"] = apply_theme,
    ["theme.transparent_background"] = apply_theme,
}

local function restart_nvim()
    local cwd = vim.fn.getcwd()
    vim.fn.jobstart({ "sh", "-c", "sleep 1; cd " .. vim.fn.shellescape(cwd) .. "; exec nvim" }, { detach = true })
    vim.cmd("qa!")
end

local function current_entries()
    return by_group[groups[state.group_idx]]
end

local function fmt_value(v)
    if type(v) == "string" then
        return v
    end
    return tostring(v)
end

local function update_winbar()
    local e = current_entries()[state.entry_idx]
    if not e then
        return
    end
    local text
    if e.type == "display" then
        text = " " .. e.label .. " — read-only (defined in code)"
    else
        text = string.format(" %s — %s", e.label, e.desc or "")
        if e.type == "enum" then
            text = text .. "  [options: " .. table.concat(e.options, " | ") .. "]"
        end
    end
    local width = vim.api.nvim_win_get_width(state.wins.right)
    if #text > width - 2 then
        text = string.sub(text, 1, width - 2)
    end
    vim.wo[state.wins.right].winbar = text
end

local function set_lines(buf, lines)
    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
end

local function render_left()
    local lines = {}
    for i, g in ipairs(groups) do
        lines[#lines + 1] = string.format(" %s (%d)", g, #by_group[g])
    end
    set_lines(state.bufs.left, lines)
    vim.api.nvim_win_set_cursor(state.wins.left, { state.group_idx, 0 })
end

local function render_right()
    local entries = current_entries()
    state.entry_idx = math.min(state.entry_idx, #entries)
    local lines = {}
    for i, e in ipairs(entries) do
        if e.type == "display" then
            lines[#lines + 1] = string.format(" %s  (%s)", e.label, e.desc)
        else
            lines[#lines + 1] = string.format(" %s = %s", e.label, fmt_value(settings.get(e.key)))
        end
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] = " <CR>/<Tab> change · c custom · r reset · <C-s> save & exit · q quit   " .. state.status
    set_lines(state.bufs.right, lines)
    -- extmarks must be set after set_lines: line indices are validated
    -- against the buffer's current line count
    vim.api.nvim_buf_clear_namespace(state.bufs.right, state.ns, 0, -1)
    for i, e in ipairs(entries) do
        if e.type == "display" then
            vim.api.nvim_buf_set_extmark(state.bufs.right, state.ns, i - 1, 0, { line_hl_group = "Comment" })
        end
    end
    vim.api.nvim_win_set_cursor(state.wins.right, { state.entry_idx, 0 })
    update_winbar()
end

local function apply(entry, value)
    settings.set(entry.key, value)
    local fn = live_apply[entry.key]
    if not fn and entry.key:match("^harness%.") then
        fn = apply_harness
    end
    if fn then
        local ok, err = pcall(fn, value)
        if ok then
            state.restart_keys[entry.key] = nil
            state.status = "✓ saved & applied live"
        else
            state.restart_keys[entry.key] = true
            state.status = "✓ saved — live apply failed, needs restart"
        end
    else
        state.restart_keys[entry.key] = true
        state.status = "✓ saved — some settings need restart (auto-restarts on exit)"
    end
    render_right()
end

local function custom_input(entry)
    local cur = settings.get(entry.key)
    vim.ui.input({
        prompt = string.format("%s (current: %s) ", entry.label, fmt_value(cur)),
        default = tostring(cur),
    }, function(input)
        if input == nil or input == "" then
            return
        end
        local v = input
        if entry.type == "number" then
            v = tonumber(input)
            if v == nil then
                state.status = "not a number — unchanged"
                render_right()
                return
            end
        elseif entry.type == "boolean" then
            if input == "true" then
                v = true
            elseif input == "false" then
                v = false
            else
                state.status = "use true or false — unchanged"
                render_right()
                return
            end
        end
        apply(entry, v)
    end)
end

local function activate()
    local e = current_entries()[state.entry_idx]
    if not e then
        return
    end
    if e.type == "display" then
        state.status = "read-only (defined in code)"
        render_right()
        return
    end
    local cur = settings.get(e.key)
    if e.type == "boolean" then
        apply(e, not cur)
    elseif e.type == "enum" then
        local opts = e.options
        local idx = 0
        for i, o in ipairs(opts) do
            if o == cur then
                idx = i
                break
            end
        end
        apply(e, opts[(idx % #opts) + 1])
    else
        custom_input(e)
    end
end

local function reset()
    local e = current_entries()[state.entry_idx]
    if e and e.type ~= "display" then
        apply(e, e.default)
    end
end

local function close()
    local need_restart = next(state.restart_keys) ~= nil
    vim.api.nvim_clear_autocmds({ group = state.augroup })
    for _, w in pairs(state.wins) do
        if vim.api.nvim_win_is_valid(w) then
            vim.api.nvim_win_close(w, true)
        end
    end
    state.wins = {}
    if need_restart then
        local n = 0
        for _ in pairs(state.restart_keys) do
            n = n + 1
        end
        vim.notify("Settings saved — restarting Neovim to apply " .. n .. " setting(s)", vim.log.levels.INFO)
        restart_nvim()
    end
end
M.close = close

function M.open()
    if state.wins.outer and vim.api.nvim_win_is_valid(state.wins.outer) then
        vim.api.nvim_set_current_win(state.wins.outer)
        return
    end
    state.group_idx = 1
    state.entry_idx = 1
    state.restart_keys = {}
    state.status = ""

    local cols, rows = vim.o.columns, vim.o.lines
    local width = math.floor(cols * 0.9)
    local height = math.floor(rows * 0.85)
    local left_w = 26

    state.bufs.outer = vim.api.nvim_create_buf(false, true)
    state.bufs.left = vim.api.nvim_create_buf(false, true)
    state.bufs.right = vim.api.nvim_create_buf(false, true)
    for _, b in pairs(state.bufs) do
        vim.bo[b].modifiable = false
        vim.bo[b].bufhidden = "wipe"
    end

    state.wins.outer = vim.api.nvim_open_win(state.bufs.outer, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((rows - height - 2) / 2),
        col = math.floor((cols - width - 2) / 2),
        border = "rounded",
        title = " Settings ",
        style = "minimal",
    })
    state.wins.left = vim.api.nvim_open_win(state.bufs.left, false, {
        relative = "win",
        win = state.wins.outer,
        width = left_w,
        height = height,
        row = 1,
        col = 1,
        border = { "", "", "", "│", "", "", "", "" }, -- divider on the right edge
        style = "minimal",
    })
    state.wins.right = vim.api.nvim_open_win(state.bufs.right, false, {
        relative = "win",
        win = state.wins.outer,
        width = width - left_w - 2,
        height = height,
        row = 1,
        col = left_w + 2,
        border = "none",
        style = "minimal",
    })

    vim.wo[state.wins.outer].winhighlight = "Normal:NormalFloat"
    vim.wo[state.wins.left].cursorline = true
    vim.wo[state.wins.right].cursorline = true

    local function map(buf, lhs, rhs)
        vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true })
    end
    local lb, rb, ob = state.bufs.left, state.bufs.right, state.bufs.outer

    local function left_down()
        state.group_idx = math.min(state.group_idx + 1, #groups)
        state.entry_idx = 1
        render_left()
        render_right()
    end
    local function left_up()
        state.group_idx = math.max(state.group_idx - 1, 1)
        state.entry_idx = 1
        render_left()
        render_right()
    end
    local function right_down()
        state.entry_idx = math.min(state.entry_idx + 1, #current_entries())
        render_right()
    end
    local function right_up()
        state.entry_idx = math.max(state.entry_idx - 1, 1)
        render_right()
    end

    map(lb, "j", left_down)
    map(lb, "<Down>", left_down)
    map(lb, "k", left_up)
    map(lb, "<Up>", left_up)
    map(lb, "<CR>", function()
        vim.api.nvim_set_current_win(state.wins.right)
    end)
    map(lb, "l", function()
        vim.api.nvim_set_current_win(state.wins.right)
    end)
    map(lb, "q", close)
    map(lb, "<Esc>", close)
    map(lb, "<C-s>", close)

    map(rb, "j", right_down)
    map(rb, "<Down>", right_down)
    map(rb, "k", right_up)
    map(rb, "<Up>", right_up)
    map(rb, "<CR>", activate)
    map(rb, "<Tab>", activate)
    map(rb, "<Space>", activate)
    map(rb, "c", function()
        local e = current_entries()[state.entry_idx]
        if e and e.type ~= "display" then
            custom_input(e)
        end
    end)
    map(rb, "r", reset)
    map(rb, "h", function()
        vim.api.nvim_set_current_win(state.wins.left)
    end)
    map(rb, "q", close)
    map(rb, "<Esc>", close)
    map(rb, "<C-s>", close)

    map(ob, "q", close)
    map(ob, "<Esc>", close)
    map(ob, "<C-s>", close)

    vim.api.nvim_create_autocmd("CursorMoved", {
        group = state.augroup,
        buffer = lb,
        callback = function()
            local row = vim.api.nvim_win_get_cursor(state.wins.left)[1]
            if row ~= state.group_idx and row >= 1 and row <= #groups then
                state.group_idx = row
                state.entry_idx = 1
                render_right()
            end
        end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = state.augroup,
        buffer = rb,
        callback = function()
            local row = vim.api.nvim_win_get_cursor(state.wins.right)[1]
            if row ~= state.entry_idx and row >= 1 and row <= #current_entries() then
                state.entry_idx = row
                render_right()
            end
        end,
    })

    render_left()
    render_right()
    vim.api.nvim_set_current_win(state.wins.left)
end

vim.api.nvim_create_user_command("ConfigSettings", function()
    M.open()
end, { desc = "Open the settings menu" })

-- Keymap only if <leader>cs is not already taken
if vim.fn.maparg((vim.g.mapleader or "\\") .. "cs", "n") == "" then
    vim.keymap.set("n", "<leader>cs", "<cmd>ConfigSettings<cr>", { desc = "Settings menu" })
end

return M
