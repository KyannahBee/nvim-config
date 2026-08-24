return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- This ensures the plugin is loaded before the config runs
    lazy = false,
    config = function()
        -- Use pcall (protected call) to prevent the error from freezing Neovim
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end

        configs.setup({
            ensure_installed = {
                "lua", "python", "javascript", "typescript",
                "c", "cpp", "java", "rust", "html", "css", "bash",
                "vim", "vimdoc", --"query",
            },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
