return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local n = require("config.settings").values.neotree
        vim.keymap.set('n', require("config.settings").values.keys.neotree_toggle, ':Neotree filesystem reveal left<CR>')
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = n.filtered_visible,   -- show hidden files, just dimmed
                    hide_dotfiles = n.hide_dotfiles, -- don't hide dotfiles
                    hide_gitignored = n.hide_gitignored, -- don't hide gitignored files
                },
            },
            window = {
                width = n.window_width, -- default is 40, adjust to taste
            },
        })
    end
}
