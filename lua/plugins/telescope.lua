local keys = require("config.settings").values.keys

return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            { keys.telescope_find_files,  "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { keys.telescope_git_files,   "<cmd>Telescope git_files<cr>",  desc = "Git Files" },
            { keys.telescope_buffers,     "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { keys.telescope_help_tags,   "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
            { keys.telescope_live_grep,   "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
            {
                keys.telescope_grep_string,
                function()
                    if vim.fn.executable("rg") == 0 then
                        vim.notify("ripgrep not found — install it for grep search", vim.log.levels.WARN)
                        return
                    end
                    require("telescope.builtin").grep_string({
                        search = vim.fn.input("Grep > ")
                    })
                end,
                desc = "Search String",
            },
        },
        config = function()
            local telescope = require("telescope")
            local theme_name = require("config.settings").values.telescope.ui_select_theme
            local themes = require("telescope.themes")
            local theme_fn = ({
                dropdown = themes.get_dropdown,
                ivy = themes.get_ivy,
                cursor = themes.get_cursor,
            })[theme_name] or themes.get_dropdown
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        theme_fn()
                    },
                },
            })
            telescope.load_extension("ui-select")
        end,
    },
}
