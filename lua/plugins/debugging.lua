return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        local d = require("config.settings").values
        local dap = require("dap")
        local dapui = require("dapui")

        if d.dapui.auto_open then
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
        end
        if d.dapui.auto_close then
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end

        vim.keymap.set('n', d.keys.dap_toggle_breakpoint, dap.toggle_breakpoint, {})
        vim.keymap.set('n', d.keys.dap_continue, dap.continue, {})
    end,
}
