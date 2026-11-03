-- Core vim options, driven by lua/config/schema.lua via lua/config/settings.lua
local v = require("config.settings").values.vim

vim.opt.expandtab = v.expandtab
vim.opt.tabstop = v.tabstop
vim.opt.softtabstop = v.softtabstop
vim.opt.shiftwidth = v.shiftwidth
vim.g.mapleader = v.mapleader
vim.opt.relativenumber = v.relativenumber
vim.opt.spell = v.spell
vim.opt.clipboard = v.clipboard
vim.opt.termguicolors = v.termguicolors
vim.opt.splitright = v.splitright -- always open vsplit on the right; this way the harness opens on the right side

-- Window navigation: cycle left/right through the normal windows (neo-tree,
-- editor, harness) with wraparound. Floats (pet popup, menus) are ignored.
local keys = require("config.settings").values.keys
local function window_nav(dir)
    local wins = {}
    for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.fn.win_gettype(w) == "" then
            wins[#wins + 1] = w
        end
    end
    table.sort(wins, function(a, b)
        return vim.fn.getwininfo(a)[1].wincol < vim.fn.getwininfo(b)[1].wincol
    end)
    local cur = vim.api.nvim_get_current_win()
    local idx
    for i, w in ipairs(wins) do
        if w == cur then
            idx = i
            break
        end
    end
    if not idx or #wins < 2 then
        return
    end
    local target = wins[((idx - 1 + dir) % #wins) + 1]
    vim.api.nvim_set_current_win(target)
    -- land in insert mode when moving into a terminal window (the harness)
    if vim.bo[vim.api.nvim_win_get_buf(target)].buftype == "terminal" then
        vim.cmd("startinsert")
    end
end

if keys.window_nav_left and keys.window_nav_left ~= "" then
    vim.keymap.set({ "n", "t" }, keys.window_nav_left, function() window_nav(-1) end, { desc = "Window: move left (cycles)" })
end
if keys.window_nav_right and keys.window_nav_right ~= "" then
    vim.keymap.set({ "n", "t" }, keys.window_nav_right, function() window_nav(1) end, { desc = "Window: move right (cycles)" })
end
