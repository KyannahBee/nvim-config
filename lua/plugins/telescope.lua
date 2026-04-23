return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Git Files" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
            {
                "<leader>fs",
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
            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown()
                    },
                },
            })
            telescope.load_extension("ui-select")
        end,
    },
}
