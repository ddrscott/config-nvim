" Plugin manager provided by: https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')
" Removed: ag.vim (using ripgrep via Telescope)
Plug 'https://github.com/tinted-theming/tinted-vim.git'
Plug 'https://github.com/AndrewRadev/sideways.vim'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
" Replaced: vim-gitgutter -> gitsigns.nvim (see below)
Plug 'https://github.com/alampros/vim-styled-jsx'
" Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/vim-scripts/dbext.vim'
Plug 'https://github.com/gcavallanti/vim-noscrollbar'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax.git'
" Removed: incsearch.vim (using built-in incsearch + inccommand)
Plug 'https://github.com/jeetsukumaran/vim-indentwise'
Plug 'https://github.com/joker1007/vim-ruby-heredoc-syntax'
Plug 'https://github.com/justinmk/vim-sneak'
Plug 'https://github.com/kana/vim-smartword'
Plug 'https://github.com/kana/vim-submode'
"Plug 'https://github.com/kana/vim-textobj-function.git'
"Plug 'https://github.com/kana/vim-textobj-indent'
"Plug 'https://github.com/kana/vim-textobj-line'
"Plug 'https://github.com/kana/vim-textobj-syntax'
"Plug 'https://github.com/kana/vim-textobj-underscore'
"Plug 'https://github.com/kana/vim-textobj-user.git'
"Plug 'https://github.com/tek/vim-textobj-ruby.git'
Plug 'https://github.com/kshenoy/vim-signature.git'
" Removed: tagbar (using LSP symbols via Telescope)
"Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
"Plug 'https://github.com/whatyouhide/vim-textobj-xmlattr.git'
Plug 'https://github.com/styled-components/vim-styled-components.git', { 'branch': 'main' }
Plug 'https://github.com/roxma/vim-tmux-clipboard'
" Replaced: nerdtree -> nvim-tree.lua (see below)
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'mg979/vim-visual-multi'  " Replaced: vim-multiple-cursors (deprecated)
Plug 'https://github.com/timcharper/wordnet.vim'
" Removed: vim-commentary (using built-in gc commenting)
Plug 'https://github.com/tpope/vim-endwise'
" Use my personal version until changes are accepted by @tpope
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-haml'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/tpope/vim-projectionist'
Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-ragtag'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-scriptease.git'
if has('nvim') == 0
  Plug 'https://github.com/tpope/vim-sensible'
endif
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tommcdo/vim-exchange'

Plug 'https://github.com/wellle/targets.vim.git'
Plug 'https://github.com/zeekay/vimtips.git'
" Removed: fzf, fzf.vim (using Telescope instead)
" Plug 'tek/vim-fieldtrip'
Plug 'https://github.com/mhinz/vim-startify'
" Plug 'https://github.com/vito-c/jq.vim.git'
Plug 'https://github.com/rubixninja314/vim-mcfunction'

Plug 'https://github.com/ddrscott/vim-side-search'
"Plug '~/code/vim-side-search'
Plug 'https://github.com/ddrscott/vim-sendtext'
Plug 'https://github.com/ddrscott/vim-window'
Plug 'https://github.com/ddrscott/vim-textobj-anyblock'

" The new world of IDE features
" Code Completion
Plug 'neovim/nvim-lspconfig'
"Plug 'anott03/nvim-lspinstall'
Plug 'williamboman/mason.nvim'
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/wuelnerdotexe/vim-astro'

" LLM GPT Stuff
Plug 'https://github.com/github/copilot.vim', {'branch': 'release'}
" Plug 'https://github.com/huggingface/llm.nvim'
"
Plug 'MunifTanjim/nui.nvim',
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope.nvim'

" Modern Lua replacements
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-tree/nvim-tree.lua'
"Plug 'https://github.com/jackMort/ChatGPT.nvim'
Plug 'https://github.com/CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }

"Plug 'https://github.com/David-Kunz/gen.nvim'
"Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'earthly/earthly.vim', { 'branch': 'main' }

" Keep this at the end!
call plug#end()
