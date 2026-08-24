return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        open_mapping = "<leader>tt",
        insert_mappings = false, -- only bind in normal/terminal mode, not insert (was delaying every <space> while typing)
        direction = "float", -- or "horizontal"/"vertical"
    },
}
