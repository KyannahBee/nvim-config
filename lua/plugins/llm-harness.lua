return {
    "greggh/claude-code.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local h = require("config.settings").values.harness
        require("claude-code").setup({
            window = {
                split_ratio = h.window.split_ratio,
                position = h.window.position,
                enter_insert = h.window.enter_insert,
                hide_numbers = h.window.hide_numbers,
                hide_signcolumn = h.window.hide_signcolumn,
                float = {
                    width = h.window.float.width,
                    height = h.window.float.height,
                    row = h.window.float.row,
                    col = h.window.float.col,
                    relative = h.window.float.relative,
                    border = h.window.float.border,
                },
            },
            refresh = {
                enable = h.refresh.enable,
                updatetime = h.refresh.updatetime,
                timer_interval = h.refresh.timer_interval,
                show_notifications = h.refresh.show_notifications,
            },
            git = {
                use_git_root = h.git.use_git_root,
            },
            shell = {
                separator = h.shell.separator,
                pushd_cmd = h.shell.pushd_cmd,
                popd_cmd = h.shell.popd_cmd,
            },
            command = h.command,
            command_variants = {
                continue = h.variants.continue,
                resume = h.variants.resume,
                verbose = h.variants.verbose,
            },
            keymaps = {
                toggle = {
                    normal = h.keymaps.toggle_normal,
                    terminal = h.keymaps.toggle_terminal,
                    variants = {
                        continue = h.keymaps.variant_continue,
                        verbose = h.keymaps.variant_verbose,
                    },
                },
                window_navigation = h.keymaps.window_navigation,
                scrolling = h.keymaps.scrolling,
            },
        })
    end,
}
