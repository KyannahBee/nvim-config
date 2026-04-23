return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local dashboard = require("alpha.themes.startify")
        -- Customize the header if you want
        dashboard.section.header.val = {
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        }
        require("alpha").setup(dashboard.opts)
    end
}
