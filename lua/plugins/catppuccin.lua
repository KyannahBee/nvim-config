return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, 
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            custom_highlights = function()
                return {
                    Normal = { bg = "none" },
                    NormalFloat = { bg = "none" },
                    SignColumn = { bg = "none" },
                    EndOfBuffer = { bg = "none" },
                }
            end,
        })

        vim.cmd.colorscheme "catppuccin"
    end
}
