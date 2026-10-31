return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function()
        local i = require("config.settings").values.indent
        return {
            indent = { char = i.char },
            scope = { enabled = i.scope_enabled }, -- Highlights the current block scope
        }
    end,
}
