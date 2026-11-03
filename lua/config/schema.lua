-- Schema: declarative list of every user-changeable setting in this config.
-- Consumed by lua/config/settings.lua (to build the values table) and later by
-- the Telescope settings menu (to render groups and editors).
--
-- Entry shape:
--   group   = plugin/area name, used to group entries in the menu
--   key     = dot-path into the values table, e.g. "harness.command"
--   label   = human-readable name shown in the menu
--   type    = "string" | "number" | "boolean" | "enum" | "display"
--   default = default value (omitted for "display")
--   desc    = short explanation
--   options = allowed values (enum only)
--   min/max = range hint (number only)
-- "display" entries are read-only: they document settings that are functions
-- or big data tables in code and cannot be edited as plain values.
return {
    -- ── Core vim options (vim-options.lua, init.lua) ──────────────────────
    { group = "core", key = "vim.expandtab",        label = "Expand tabs to spaces", type = "boolean", default = true,    desc = "Use spaces instead of tab characters" },
    { group = "core", key = "vim.tabstop",          label = "Tab width",             type = "number",  default = 4, min = 1, max = 16, desc = "Width of a tab character" },
    { group = "core", key = "vim.softtabstop",      label = "Soft tab width",        type = "number",  default = 4, min = 1, max = 16, desc = "Spaces inserted per Tab/Backspace in insert mode" },
    { group = "core", key = "vim.shiftwidth",       label = "Indent width",          type = "number",  default = 4, min = 1, max = 16, desc = "Spaces per auto-indent step" },
    { group = "core", key = "vim.mapleader",        label = "Leader key",            type = "string",  default = " ",   desc = "Leader key for <leader> mappings" },
    { group = "core", key = "vim.relativenumber",   label = "Relative line numbers", type = "boolean", default = true,  desc = "Show relative line numbers" },
    { group = "core", key = "vim.spell",            label = "Spell check",           type = "boolean", default = false, desc = "Enable spell checking" },
    { group = "core", key = "vim.clipboard",        label = "Clipboard register",    type = "enum",    default = "unnamedplus", options = { "unnamedplus", "unnamed", "" }, desc = "Sync system clipboard with the unnamed register" },
    { group = "core", key = "vim.termguicolors",    label = "True color support",    type = "boolean", default = true,  desc = "Enable 24-bit RGB colors in the terminal" },
    { group = "core", key = "vim.splitright",       label = "Split to the right",    type = "boolean", default = true,  desc = "Open vertical splits on the right side" },

    -- ── llm-harness (greggh/claude-code.nvim) ─────────────────────────────
    { group = "llm-harness", key = "harness.command",                 label = "AI command",            type = "string",  default = "vibe",          desc = "CLI launched by the harness toggle, e.g. vibe, claude, aider" },
    { group = "llm-harness", key = "harness.variants.continue",       label = "Continue flag",         type = "string",  default = "--continue",    desc = "Flag for the continue variant" },
    { group = "llm-harness", key = "harness.variants.resume",         label = "Resume flag",           type = "string",  default = "--resume",      desc = "Flag for the resume variant" },
    { group = "llm-harness", key = "harness.variants.verbose",        label = "Verbose flag",          type = "string",  default = "--verbose",     desc = "Flag for the verbose variant" },
    { group = "llm-harness", key = "harness.window.split_ratio",      label = "Split ratio",           type = "number",  default = 0.4, min = 0.1, max = 0.9, desc = "Fraction of the screen the harness split takes" },
    { group = "llm-harness", key = "harness.window.position",         label = "Window position",       type = "enum",    default = "botright vsplit", options = { "botright vsplit", "botright split", "topleft vsplit", "topleft split", "float" }, desc = "Where the harness terminal opens" },
    { group = "llm-harness", key = "harness.window.enter_insert",     label = "Enter insert mode",     type = "boolean", default = true,  desc = "Start in insert mode when the harness opens" },
    { group = "llm-harness", key = "harness.window.hide_numbers",     label = "Hide line numbers",     type = "boolean", default = true,  desc = "Hide line numbers in the harness window" },
    { group = "llm-harness", key = "harness.window.hide_signcolumn",  label = "Hide sign column",      type = "boolean", default = true,  desc = "Hide the sign column in the harness window" },
    { group = "llm-harness", key = "harness.window.float.width",      label = "Float width",           type = "string",  default = "80%", desc = "Width of the float window (percent or columns)" },
    { group = "llm-harness", key = "harness.window.float.height",     label = "Float height",          type = "string",  default = "80%", desc = "Height of the float window (percent or rows)" },
    { group = "llm-harness", key = "harness.window.float.row",        label = "Float row",             type = "string",  default = "center", desc = "Vertical anchor of the float ('center' or a number)" },
    { group = "llm-harness", key = "harness.window.float.col",        label = "Float column",          type = "string",  default = "center", desc = "Horizontal anchor of the float ('center' or a number)" },
    { group = "llm-harness", key = "harness.window.float.relative",   label = "Float relative to",     type = "enum",    default = "editor", options = { "editor", "win", "cursor", "mouse" }, desc = "What the float is positioned relative to" },
    { group = "llm-harness", key = "harness.window.float.border",     label = "Float border",          type = "enum",    default = "rounded", options = { "none", "single", "double", "rounded", "solid", "shadow" }, desc = "Border style of the float window" },
    { group = "llm-harness", key = "harness.refresh.enable",          label = "Auto refresh",          type = "boolean", default = true,  desc = "Refresh the harness view automatically" },
    { group = "llm-harness", key = "harness.refresh.updatetime",      label = "Refresh updatetime",    type = "number",  default = 100, min = 10, desc = "CursorHold updatetime in the harness buffer (ms)" },
    { group = "llm-harness", key = "harness.refresh.timer_interval",  label = "Refresh timer",         type = "number",  default = 1000, min = 100, desc = "Refresh timer interval (ms)" },
    { group = "llm-harness", key = "harness.refresh.show_notifications", label = "Refresh notifications", type = "boolean", default = true, desc = "Show notifications when the harness refreshes" },
    { group = "llm-harness", key = "harness.git.use_git_root",        label = "Use git root",          type = "boolean", default = true,  desc = "Run the harness from the git root of the project" },
    { group = "llm-harness", key = "harness.shell.separator",         label = "Shell separator",       type = "string",  default = "&&",  desc = "Command separator used to chain shell commands" },
    { group = "llm-harness", key = "harness.shell.pushd_cmd",         label = "Pushd command",         type = "string",  default = "pushd", desc = "Command used to change directory" },
    { group = "llm-harness", key = "harness.shell.popd_cmd",          label = "Popd command",          type = "string",  default = "popd",  desc = "Command used to restore directory" },
    { group = "llm-harness", key = "harness.keymaps.toggle_normal",   label = "Toggle (normal mode)",  type = "string",  default = "<C-,>",  desc = "Keymap to toggle the harness in normal mode" },
    { group = "llm-harness", key = "harness.keymaps.toggle_terminal", label = "Toggle (terminal mode)", type = "string", default = "<C-,>",  desc = "Keymap to toggle the harness in terminal mode" },
    { group = "llm-harness", key = "harness.keymaps.variant_continue", label = "Continue variant key", type = "string", default = "<leader>cC", desc = "Keymap for the continue variant" },
    { group = "llm-harness", key = "harness.keymaps.variant_verbose", label = "Verbose variant key",  type = "string",  default = "<leader>cV", desc = "Keymap for the verbose variant" },
    { group = "llm-harness", key = "harness.keymaps.window_navigation", label = "Window navigation keys", type = "boolean", default = true, desc = "Bind <C-h>/<C-l> to move between windows" },
    { group = "llm-harness", key = "harness.keymaps.scrolling",       label = "Scrolling keys",        type = "boolean", default = true,  desc = "Bind scroll keys in the harness terminal" },

    -- ── theme (catppuccin) ────────────────────────────────────────────────
    { group = "theme", key = "theme.flavour",              label = "Flavour",            type = "enum",    default = "mocha", options = { "latte", "frappe", "macchiato", "mocha" }, desc = "Catppuccin flavour (latte is light mode)" },
    { group = "theme", key = "theme.transparent_background", label = "Transparent background", type = "boolean", default = true, desc = "Make the background transparent" },
    { group = "theme", key = "theme.custom_highlights",    label = "Custom highlights",  type = "display", desc = "Function in theme.lua returning extra highlight groups (SignColumn/EndOfBuffer bg none)" },

    -- ── lualine ───────────────────────────────────────────────────────────
    { group = "lualine", key = "lualine.theme",            label = "Statusline theme",   type = "string",  default = "everforest", desc = "Lualine theme name" },
    { group = "lualine", key = "lualine.show_clock",       label = "Show clock",         type = "boolean", default = true,  desc = "Show the current time in lualine_y" },
    { group = "lualine", key = "lualine.show_session_time", label = "Show session time", type = "boolean", default = true, desc = "Show elapsed session time in lualine_y" },

    -- ── alpha (dashboard) ─────────────────────────────────────────────────
    { group = "alpha", key = "alpha.header", label = "Dashboard header", type = "display", desc = "ASCII art header in alpha.lua (table of strings)" },

    -- ── pets ──────────────────────────────────────────────────────────────
    { group = "pets", key = "pet.side",                   label = "Pet side",           type = "enum",    default = "left", options = { "left", "right" }, desc = "Screen edge the pet popup is anchored to (percentage-based, follows any monitor width)" },
    { group = "pets", key = "pet.row",                    label = "Pet row",            type = "number",  default = 5, min = 1, max = 10, desc = "Row (height) the pet is displayed at, 1-10" },
    { group = "pets", key = "pet.col",                    label = "Pet column",         type = "number",  default = 0, min = 0, desc = "Leftmost column inside the pet popup the pet can wander to; higher pins it toward the popup's right edge" },
    { group = "pets", key = "pet.speed_multiplier",       label = "Pet speed",          type = "number",  default = 1, min = 0.1, max = 10, desc = "Animation speed multiplier (lower = choppier but slower)" },
    { group = "pets", key = "pet.default_pet",            label = "Default pet",        type = "string",  default = "dog",   desc = "Pet spawned by the PetNew command, e.g. dog, cat" },
    { group = "pets", key = "pet.default_style",          label = "Default pet style",  type = "string",  default = "beige", desc = "Style of the default pet, e.g. beige" },
    { group = "pets", key = "pet.random",                 label = "Random pet",         type = "boolean", default = false, desc = "Spawn a random pet, overriding default_pet/default_style" },
    { group = "pets", key = "pet.death_animation",        label = "Death animation",    type = "boolean", default = false, desc = "Animate the pet's death" },
    { group = "pets", key = "pet.popup_width",            label = "Popup width",        type = "string",  default = "20%", desc = "Pet popup width; use a percent string like \"20%\" so it scales with any monitor width" },
    { group = "pets", key = "pet.popup_winblend",         label = "Popup winblend",     type = "number",  default = 100, min = 0, max = 100, desc = "Transparency of the pet popup (100 = invisible)" },
    { group = "pets", key = "pet.popup_avoid_statusline", label = "Avoid statusline",   type = "boolean", default = false, desc = "Spawn the popup above the statusline instead of blending over it" },
    { group = "pets", key = "pet.spawn_command",          label = "Spawn command",      type = "string",  default = "PetsNew {Sudo}", desc = "Command run on VimEnter to spawn the pet" },
    { group = "pets", key = "pet.popup_hl",               label = "Popup highlight",    type = "display", desc = "Highlight group table for the popup (hl = { Normal = 'Normal' })" },

    -- ── toggleterm ────────────────────────────────────────────────────────
    { group = "toggleterm", key = "toggleterm.open_mapping",    label = "Open mapping",   type = "string",  default = "<leader>tt", desc = "Keymap to open the floating terminal" },
    { group = "toggleterm", key = "toggleterm.insert_mappings", label = "Insert mappings", type = "boolean", default = false, desc = "Also bind the open mapping in insert mode" },
    { group = "toggleterm", key = "toggleterm.direction",       label = "Direction",      type = "enum",    default = "float", options = { "float", "horizontal", "vertical", "tab" }, desc = "How the terminal opens" },

    -- ── telescope ─────────────────────────────────────────────────────────
    { group = "telescope", key = "keys.telescope_find_files",  label = "Find files",     type = "string", default = "<leader>ff", desc = "Telescope find_files keymap" },
    { group = "telescope", key = "keys.telescope_git_files",   label = "Git files",      type = "string", default = "<C-p>",      desc = "Telescope git_files keymap" },
    { group = "telescope", key = "keys.telescope_buffers",     label = "Buffers",        type = "string", default = "<leader>fb", desc = "Telescope buffers keymap" },
    { group = "telescope", key = "keys.telescope_help_tags",   label = "Help tags",      type = "string", default = "<leader>fh", desc = "Telescope help_tags keymap" },
    { group = "telescope", key = "keys.telescope_live_grep",   label = "Live grep",      type = "string", default = "<leader>fg", desc = "Telescope live_grep keymap" },
    { group = "telescope", key = "keys.telescope_grep_string", label = "Grep string",    type = "string", default = "<leader>fs", desc = "Telescope grep_string (prompted) keymap" },
    { group = "telescope", key = "telescope.ui_select_theme",   label = "UI select theme", type = "enum",   default = "dropdown", options = { "dropdown", "ivy", "cursor" }, desc = "Theme for vim.ui.select popups (telescope ui-select extension)" },

    -- ── neotree ───────────────────────────────────────────────────────────
    { group = "neotree", key = "keys.neotree_toggle",        label = "Toggle key",        type = "string",  default = "<C-n>",  desc = "Keymap to open neo-tree (filesystem reveal left)" },
    { group = "neotree", key = "neotree.filtered_visible",   label = "Show filtered items", type = "boolean", default = true,  desc = "Show hidden/ignored files, just dimmed" },
    { group = "neotree", key = "neotree.hide_dotfiles",      label = "Hide dotfiles",     type = "boolean", default = false, desc = "Hide dotfiles in neo-tree" },
    { group = "neotree", key = "neotree.hide_gitignored",    label = "Hide gitignored",   type = "boolean", default = false, desc = "Hide gitignored files in neo-tree" },
    { group = "neotree", key = "neotree.window_width",       label = "Window width",      type = "number",  default = 25, min = 10, max = 80, desc = "Width of the neo-tree window in columns" },

    -- ── debugging (nvim-dap + dapui) ─────────────────────────────────────
    { group = "debugging", key = "keys.dap_toggle_breakpoint", label = "Toggle breakpoint", type = "string",  default = "<leader>db", desc = "DAP toggle breakpoint keymap" },
    { group = "debugging", key = "keys.dap_continue",          label = "Continue",          type = "string",  default = "<leader>dc", desc = "DAP continue keymap" },
    { group = "debugging", key = "dapui.auto_open",            label = "Auto-open UI",      type = "boolean", default = true,  desc = "Open dapui automatically on attach/launch" },
    { group = "debugging", key = "dapui.auto_close",           label = "Auto-close UI",     type = "boolean", default = true,  desc = "Close dapui automatically on terminated/exited" },

    -- ── formatting (conform) ──────────────────────────────────────────────
    { group = "formatting", key = "conform.format_on_save", label = "Format on save",   type = "boolean", default = true,  desc = "Format the buffer automatically on write" },
    { group = "formatting", key = "conform.timeout_ms",    label = "Format timeout",   type = "number",  default = 500, min = 100, desc = "Format-on-save timeout in ms" },
    { group = "formatting", key = "conform.lsp_fallback",  label = "LSP fallback",     type = "boolean", default = true,  desc = "Fall back to LSP formatting when no formatter is configured" },
    { group = "formatting", key = "conform.formatters_by_ft", label = "Formatters per filetype", type = "display", desc = "formatters_by_ft table in formatting.lua (lua=stylua, python=black, ...)" },

    -- ── treesitter ────────────────────────────────────────────────────────
    { group = "treesitter", key = "treesitter.auto_install",  label = "Auto install parsers", type = "boolean", default = true, desc = "Install missing parsers automatically" },
    { group = "treesitter", key = "treesitter.highlight",     label = "Highlight",           type = "boolean", default = true, desc = "Enable treesitter syntax highlighting" },
    { group = "treesitter", key = "treesitter.indent",        label = "Indent",              type = "boolean", default = true, desc = "Enable treesitter-based indentation" },
    { group = "treesitter", key = "treesitter.ensure_installed", label = "Installed parsers", type = "display", desc = "ensure_installed parser list in treesitter.lua" },

    -- ── lsp / mason / cmp ─────────────────────────────────────────────────
    { group = "lsp", key = "keys.lsp_definition",       label = "Go to definition", type = "string", default = "gd",          desc = "LSP definition keymap" },
    { group = "lsp", key = "keys.lsp_hover",            label = "Hover docs",       type = "string", default = "K",           desc = "LSP hover keymap" },
    { group = "lsp", key = "keys.lsp_rename",           label = "Rename",           type = "string", default = "<leader>rn",  desc = "LSP rename keymap" },
    { group = "lsp", key = "keys.lsp_code_action",      label = "Code action",      type = "string", default = "<leader>ca",  desc = "LSP code action keymap" },
    { group = "lsp", key = "keys.lsp_diagnostic_float", label = "Diagnostic float", type = "string", default = "<leader>vd",  desc = "Open diagnostic float keymap" },
    { group = "lsp", key = "keys.lsp_references",       label = "References",       type = "string", default = "gr",          desc = "LSP references keymap" },
    { group = "lsp", key = "keys.lsp_format",           label = "Format buffer",    type = "string", default = "<leader>f",   desc = "LSP format keymap" },
    { group = "lsp", key = "mason.ensure_installed",    label = "Mason servers",    type = "display", desc = "ensure_installed LSP server list in lsp.lua" },
    { group = "lsp", key = "cmp.sources",               label = "Completion sources", type = "display", desc = "cmp source list in lsp.lua (nvim_lsp, luasnip, buffer, path)" },
    { group = "lsp", key = "keys.cmp_complete",         label = "Complete",         type = "string", default = "<C-Space>", desc = "CMP manual complete keymap" },
    { group = "lsp", key = "keys.cmp_confirm",          label = "Confirm selection", type = "string", default = "<CR>",     desc = "CMP confirm keymap" },
    { group = "lsp", key = "keys.cmp_tab",              label = "Next/jump",        type = "string", default = "<Tab>",      desc = "CMP select-next / snippet-jump keymap" },

    -- ── indent-blankline ──────────────────────────────────────────────────
    { group = "indent", key = "indent.char",          label = "Indent char",   type = "string",  default = "│",    desc = "Character used for indent guides" },
    { group = "indent", key = "indent.scope_enabled", label = "Scope highlight", type = "boolean", default = true, desc = "Highlight the current block scope" },

    -- ── lazydev ───────────────────────────────────────────────────────────
    { group = "lazydev", key = "lazydev.library", label = "Extra library", type = "display", desc = "luvit-meta library path loaded for vim.uv words in lazydev.lua" },
}
