return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = function()
        local c = require("config.settings").values.conform
        local opts = {
            formatters_by_ft = {
                lua        = { "stylua" },
                python     = { "black" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                java       = { "google-java-format" },
                c          = { "clang-format" },
                cpp        = { "clang-format" },
                rust       = { "rustfmt" },
            },
        }
        if c.format_on_save then
            opts.format_on_save = {
                timeout_ms = c.timeout_ms,
                lsp_fallback = c.lsp_fallback,
            }
        end
        return opts
    end,
}
