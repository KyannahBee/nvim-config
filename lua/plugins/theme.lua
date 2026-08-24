--[[
return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            --flavour = 'latte', --latte makes for a light mode
            flavour = 'mocha',
            transparent_background = false,
            custom_highlights = function()
                return {
                    --Normal = { bg = "none" },
                    --NormalFloat = { bg = "none" },
                    SignColumn = { bg = "none" },
                    EndOfBuffer = { bg = "none" },
                }
            end,
        })

        vim.cmd.colorscheme "catppuccin"
    end
}
]]

return {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('onedark').setup {
            style = 'warmer'
        }
        require('onedark').load()
    end
}
