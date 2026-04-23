return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
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
        format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
        },
    },
}
