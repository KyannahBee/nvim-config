return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local t = require("config.settings").values.theme
        require("catppuccin").setup({
            --flavour = 'latte', --latte makes for a light mode
            flavour = t.flavour,
            transparent_background = t.transparent_background,
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

--[[
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
]]
