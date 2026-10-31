return {
    "giusgad/pets.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
    event = "VimEnter", --load eagerly
    config = function()
        local p = require("config.settings").values.pet
        require("pets").setup({
            -- your options here

            row = p.row,                        -- the row (height) to display the pet at (must be at least 1 and at most 10)
            col = p.col,                        -- the column to display the pet at (set to high number to have it stay still on the right side)
            speed_multiplier = p.speed_multiplier, -- you can make your pet move faster/slower. If slower the animation will have lower fps.
            default_pet = p.default_pet,        -- the pet to use for the PetNew command
            default_style = p.default_style,    -- the style of the pet to use for the PetNew command
            random = p.random,                  -- wether to use a random pet for the PetNew command, ovverides default_pet and default_style
            death_animation = p.death_animation, -- animate the pet's death, set to false to feel less guilt
            popup = {                           -- popup options, try changing these if you see a rectangle around the pets
                width = p.popup_width,          -- can be a string with percentage like "45%" or a number of columns like 45
                winblend = p.popup_winblend,    -- winblend value - see :h 'winblend' - only used if avoid_statusline is false
                hl = { Normal = "Normal" },     -- hl is only set if avoid_statusline is true, you can put any hl group instead of "Normal"
                avoid_statusline = p.popup_avoid_statusline, -- if winblend is 100 then the popup is invisible and covers the statusline, if that
                -- doesn't work for you then set this to true and the popup will use hl and will be spawned above the statusline (hopefully)
            }

        })
        vim.cmd(p.spawn_command)
    end
}
