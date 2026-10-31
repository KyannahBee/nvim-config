-- Core vim options, driven by lua/config/schema.lua via lua/config/settings.lua
local v = require("config.settings").values.vim

vim.opt.expandtab = v.expandtab
vim.opt.tabstop = v.tabstop
vim.opt.softtabstop = v.softtabstop
vim.opt.shiftwidth = v.shiftwidth
vim.g.mapleader = v.mapleader
vim.opt.relativenumber = v.relativenumber
vim.opt.spell = v.spell
vim.opt.clipboard = v.clipboard
vim.opt.termguicolors = v.termguicolors
vim.opt.splitright = v.splitright -- always open vsplit on the right; this way the harness opens on the right side
