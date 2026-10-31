return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = function()
        local t = require("config.settings").values.toggleterm
        return {
            open_mapping = t.open_mapping,
            insert_mappings = t.insert_mappings, -- only bind in normal/terminal mode, not insert (was delaying every <space> while typing)
            direction = t.direction, -- "float", "horizontal", "vertical" or "tab"
        }
    end,
}
