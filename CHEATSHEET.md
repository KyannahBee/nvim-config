# 🚀 Neovim IDE Cheatsheet

A professional-grade, future-proof Neovim setup optimized for **C/C++, Python, Java, Rust, and Web Development**.

---

## ⌨️ Leader Key
The **Leader** key is set to: `Space`  
*Example: `<leader>ff` means press `Space` then `f` then `f`.*

---

## Claude-code
| `C-,` | open claude terminal on the right side of the screen |
| `C-h` | move to the window on the left (aka return to editor from claude) |
| `C-l` | move to the window on the right (aka return to claude from editor) |
| `<leader>cC` | Claude Continue | Resume the previous claude-code session |
| `<leader>cV` | Claude Verbose | Open claude-code with verbose output |

## 🔍 Navigation & Search (Telescope)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | **F**ind **F**iles | Find any file in the current directory |
| `<C-p>` | Git Files | Quick search for files tracked by Git |
| `<leader>fs` | **F**ind **S**tring | Search for text inside all files (prompted) |
| `<leader>fb` | **F**ind **B**uffers | List and switch between open files |
| `<leader>fg` | **F**ind **G**rep | Live grep across project |
| `<leader>fh` | **F**ind **H**elp | Search Neovim help documentation |

---

## 🛠️ LSP: Code Intelligence
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to where the symbol is defined |
| `gr` | Show References | List all places this symbol is used |
| `K`  | Hover Doc | Show documentation for symbol under cursor |
| `<leader>rn` | **R**e**n**ame | Rename symbol across the entire project |
| `<leader>ca` | **C**ode **A**ction | Show available LSP fixes (import, etc.) |

---

## ⚠️ Diagnostics & Errors
| Key | Action | Description |
|-----|--------|-------------|
| `[d` | Previous Error | Jump to previous diagnostic |
| `]d` | Next Error | Jump to next diagnostic |
| `<leader>vd` | **V**iew **D**iagnostic | Open error message in a floating window |

---

## ✍️ Editing & Formatting
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>f` | Format | Auto-format current buffer (LSP fallback) |
| `Save File` | Auto Format | Automatically cleans code on every `:w` (C/C++ indent style comes from `~/.clang-format`: 4 spaces, no tabs) |
| `u` / `<C-r>` | Undo / Redo | Standard Neovim history |
| `"+y` / `"+p` | Clipboard | Copy/Paste to/from System Clipboard |

---

## 🧊 Completion & Snippets (CMP)
| Key | Action | Description |
|-----|--------|-------------|
| `<C-Space>` | Trigger | Open the autocomplete menu |
| `<CR>` | Confirm | Select the highlighted item |
| `<Tab>` | Next / Jump | Cycle menu or jump forward in snippet |
| `<S-Tab>` | Prev / Jump | Cycle back or jump backward in snippet |

---

## 📂 UI & Utility
| Key | Action | Description |
|-----|--------|-------------|
| `<C-n>` | File Tree | Toggle Neo-tree sidebar |
| `:Alpha` | Dashboard | Return to the startup screen |
| `Ctrl + h/j/k/l` | Navigation | Move between split windows |
| `:Lazy` | Plugins | Manage and update your plugins |
| `:Mason` | Binaries | Manage LSPs, Formatters, and Debuggers |
| `<leader>tt` | Toggle Terminal | Open/close a floating terminal (toggleterm) |

---

## 🐞 Debugging (DAP)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | **D**ebug **B**reakpoint | Toggle a line breakpoint |
| `<leader>dc` | **D**ebug **C**ontinue | Start session or jump to next breakpoint |

---

## 💡 Pro Workflow
1. **Startup:** Use the Alpha dashboard to quickly jump into recent projects.
2. **Finding Code:** Use `<leader>ff` for files and `gd` to understand logic.
3. **Refactoring:** Use `<leader>rn` to rename variables safely across files.
4. **Maintenance:** Run `:Lazy update` and `:MasonUpdate` weekly to keep your "Main Editor" at peak performance.
