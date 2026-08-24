return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        local session_start = os.time()

        local function clock()
            return os.date("%H:%M")
        end

        local function session_time()
            local elapsed = os.time() - session_start
            local h = math.floor(elapsed / 3600)
            local m = math.floor((elapsed % 3600) / 60)
            local s = elapsed % 60
            return string.format("⏱ %02d:%02d:%02d", h, m, s)
        end

        return {
            options = {
                theme = 'everforest',
            },
            sections = {
                lualine_y = { clock, session_time },
            },
        }
    end,
}
