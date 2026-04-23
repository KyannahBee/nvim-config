# nvim-config

A modern Neovim IDE setup optimized for C/C++, Python, Java, Rust, and Web Development.

---

## System Requirements

### Required

These must be installed before launching Neovim or plugins will silently fail.

| Package | Why |
|---------|-----|
| `neovim >= 0.10` | Obviously |
| `git` | Lazy.nvim needs it to clone plugins |
| `gcc` or `clang` | Treesitter compiles parsers from source |
| `node` + `npm` | Required by many LSP servers (pyright, ts_ls, etc.) |
| `python3` + `pip` | Python LSP and DAP support |
| `ripgrep` | Telescope live_grep and grep_string — silently broken without it |
| `fd` | Telescope find_files performance — optional but recommended |

### EndeavourOS / Arch

```bash
sudo pacman -S neovim git gcc nodejs npm python ripgrep fd
```

### Ubuntu / Debian

```bash
sudo apt install neovim git gcc nodejs npm python3 python3-pip ripgrep fd-find
```

> **Note:** On Ubuntu, `fd` is installed as `fdfind`. Either alias it or symlink: `ln -s $(which fdfind) ~/.local/bin/fd`

### Fedora

```bash
sudo dnf install neovim git gcc nodejs npm python3 ripgrep fd-find
```

---

## Plugin List

Managed automatically by [lazy.nvim](https://github.com/folke/lazy.nvim). All plugins install on first launch — no manual steps needed.

### UI
- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim) — Dashboard / start screen
- [catppuccin/nvim](https://github.com/catppuccin/nvim) — Colorscheme
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — Statusline
- [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) — File tree sidebar
- [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) — Indent guides
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) — File icons

### Navigation
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — Fuzzy finder
- [nvim-telescope/telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) — Telescope-powered vim.ui.select

### LSP & Completion
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — LSP client configs
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) — LSP/formatter/linter installer
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) — Bridge between mason and lspconfig
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) — Completion engine
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) — LSP completion source
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) — Buffer completion source
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) — Path completion source
- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) — Snippet engine
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) — LuaSnip completion source
- [folke/lazydev.nvim](https://github.com/folke/lazydev.nvim) — Neovim Lua API completions for config editing

### Editing
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) — Auto close brackets/quotes
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) — Formatter (Prettier, Black, etc.)
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) — Syntax highlighting and indentation

### Debugging
- [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) — Debug Adapter Protocol client
- [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) — UI for nvim-dap
- [nvim-neotest/nvim-nio](https://github.com/nvim-neotest/nvim-nio) — Async IO library (dap-ui dependency)

### AI
- [greggh/claude-code.nvim](https://github.com/greggh/claude-code.nvim) — Claude Code terminal integration

### Dependencies
- [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) — Lua utility library (required by telescope, neo-tree, claude-code)
- [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) — UI component library (required by neo-tree)

---

## Installation

```bash
# Back up existing config if you have one
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this repo
git clone https://github.com/KyannahBee/nvim-config ~/.config/nvim

# Launch Neovim — lazy.nvim will bootstrap and install everything
nvim
```

On first launch:
1. Lazy.nvim installs all plugins automatically
2. Run `:MasonUpdate` to install LSP servers and formatters
3. Run `:TSUpdate` to install treesitter parsers

---

## Keeping Things in Sync

On a rolling release (Arch/EndeavourOS) things drift — run these after system updates:

```vim
:Lazy sync
:MasonUpdate
:TSUpdate
```

---

## Nerd Font

Icons require a [Nerd Font](https://www.nerdfonts.com/). Install one and set it in your terminal emulator. Recommended: **JetBrainsMono Nerd Font** or **FiraCode Nerd Font**.

```bash
# Arch/EndeavourOS
sudo pacman -S ttf-jetbrains-mono-nerd
```
