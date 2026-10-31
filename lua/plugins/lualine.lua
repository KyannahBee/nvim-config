return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
        local l = require("config.settings").values.lualine
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

        local y = {}
        if l.show_clock then
            y[#y + 1] = clock
        end
        if l.show_session_time then
            y[#y + 1] = session_time
        end

        return {
            options = {
                theme = l.theme,
            },
            sections = {
                lualine_y = y,
            },
        }
    end,
}
