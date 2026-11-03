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
        -- pets.nvim hardcodes the popup anchor to the bottom-right; re-anchor it
        -- to the configured side. Percentage anchors scale with the editor width,
        -- and pets.nvim re-mounts from these opts on VimResized, so this follows
        -- any monitor. Must happen before the spawn command creates the pet.
        local pets = require("pets")
        pets.options.popup.position.col = (p.side == "left") and "0%" or "100%"

        -- hologram.nvim bug workaround: utils.filler_above reads the *current*
        -- window's topfill via vim.fn.winsaveview(), so the pet image is placed
        -- at the wrong screen row whenever focus is in a scrolled window (e.g.
        -- after moving focus with <C-w>l) and the pet appears to vanish. Use the
        -- popup window's own topfill instead. buf_screenpos calls filler_above
        -- through the module table, so overriding the field is enough.
        local holo_utils = require("hologram.utils")
        holo_utils.filler_above = function(row, win, buf)
            local top = vim.fn.line("w0", win)
            row = row - 1 -- row exclusive
            if row <= top then
                return 0
            end
            local info = vim.fn.getwininfo(win)[1]
            local filler = info and info.topfill or 0
            local exts = vim.api.nvim_buf_get_extmarks(buf, vim.g.hologram_extmark_ns, { top - 1, 0 }, { row - 1, -1 }, { details = true })
            for i = 1, #exts do
                local opts = exts[i][4]
                if opts.virt_lines then
                    filler = filler + #opts.virt_lines
                end
            end
            return filler
        end

        vim.cmd(p.spawn_command)
    end
}
