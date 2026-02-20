# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (`~/.config/nvim`) using vim-plug for plugin management. The config is macOS-focused and uses Base16 color theming with xterm-256color terminal support.

## Commands

```sh
# Install plugins (run inside Neovim after cloning)
:PlugInstall

# Update plugins
:PlugUpdate

# Generate ctags for a project
:Ctag
:CtagBundle

# Ruby support requires the neovim gem
gem install neovim
```

## Architecture

### Entry Point
- `init.vim` - Main config that sources `plugins.vim` and sets core options
- `plugins.vim` - All vim-plug declarations

### Configuration Layers
- `after/plugin/*.vim` and `after/plugin/*.lua` - Plugin-specific configurations loaded after plugins
- `ftplugin/*.vim` - Filetype-specific settings (ruby, go, rust, markdown, etc.)
- `ftdetect/*.vim` - Custom filetype detection rules
- `autoload/*.vim` - Lazy-loaded helper functions

### Key Plugin Configurations
| File | Purpose |
|------|---------|
| `after/plugin/lsp_config.lua` | LSP setup for pyright, rust_analyzer, tsserver, jdtls, solargraph, intelephense |
| `after/plugin/fzf.vim` | FZF fuzzy finder bindings |
| `after/plugin/git.vim` | Fugitive and GitGutter mappings |
| `after/plugin/submode.vim` | Window and Z submodes for repeated commands |
| `after/plugin/side_search.vim` | Ripgrep-based side search |
| `after/plugin/terminal.vim` | Terminal mode customizations |
| `after/plugin/statusline.vim` | Custom statusline with buffer navigation |
| `after/plugin/llm*.lua` | Copilot and LLM integrations |

## Important Keybindings

Leader key is `<Space>`.

### Warnings (Non-Standard Overrides)
These are intentionally different from Vim defaults:
- `0` - Goes to first non-blank char (^) first, then column 0
- `j/k` - Move by display lines (gj/gk), originals on gj/gk
- `<C-r><C-r>` - Accesses unnamed register "" instead of literal insert
- `<S-u>` - Redo (instead of undo line)
- `<C-n>/<C-p>` - Next/previous buffer (not line movement)
- `s/S` - Sneak plugin (overrides substitute)
- `<C-]>` - Goes to tag with list (g<C-]) swapped with original

### Navigation
- `<Leader><Leader>` - FZF file finder
- `<Leader>ff` - FZF files (full path)
- `<Leader>fb` / `:Buffers` - FZF buffers
- `<Leader>fh` - FZF file history
- `-` - NERDTreeFind (reveal current file)
- `<Leader>n` - NERDTree toggle

### Git (Fugitive/GitGutter)
- `<Leader>gs` - Git status
- `<Leader>gd` - Gvdiff
- `<Leader>gb` - Git blame
- `[h / ]h` - Previous/next hunk
- `<Leader>hs` - Stage hunk
- `<Leader>hr` - Revert hunk

### LSP (when attached)
- `gd` / `<C-]>` - Go to definition
- `gD` - Go to declaration
- `K` - Hover documentation
- `gr` - Find references
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code action
- `<Space>f` - Format

### Submodes
- `<Leader>w` - Enter window submode (then h/j/k/l to navigate, +/- to resize, q to close)
- `<Leader>zz` - Enter Z submode (then t/b for top/bottom, j/k for folds)
- `g;` / `g,` - Enter change navigation submode

### Search
- `<Leader>ss` - SideSearch current word with ripgrep
- `:SS <query>` - SideSearch custom query
- `c*` / `c#` - Change word under cursor, then `.` to repeat

### Terminal
- `<Esc><Esc>` - Exit terminal insert mode
- `<Leader>tv` - Open vertical terminal
- `<Leader>ts` - Open horizontal terminal

### Buffer Management
- `<C-x>` - Close current buffer and jump back
- `<Leader>bo` - Close all buffers except current
- `<Leader>bb` - Switch to alternate buffer
