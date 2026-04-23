return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,          -- show hidden files, just dimmed
                    hide_dotfiles = false,   -- don't hide dotfiles
                    hide_gitignored = false, -- don't hide gitignored files
                },
            },
            window = {
                width = 25, -- default is 40, adjust to taste
            },
        })
    end
}
