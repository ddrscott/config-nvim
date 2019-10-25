" Plugin manager provided by: https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'https://github.com/rking/ag.vim'
Plug 'https://github.com/chriskempson/base16-vim.git'
Plug 'https://github.com/AndrewRadev/sideways.vim'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
" Plug 'https://github.com/AndrewRadev/switch.vim'
" Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/alampros/vim-styled-jsx'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/ecomba/vim-ruby-refactoring'
Plug 'https://github.com/vim-scripts/dbext.vim'
Plug 'https://github.com/gcavallanti/vim-noscrollbar'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax.git'
Plug 'https://github.com/haya14busa/incsearch.vim'
Plug 'https://github.com/jeetsukumaran/vim-indentwise'
Plug 'https://github.com/joker1007/vim-ruby-heredoc-syntax'
" Plug 'https://github.com/junegunn/vim-peekaboo.git'
Plug 'https://github.com/justinmk/vim-sneak'
Plug 'https://github.com/kana/vim-smartword'
Plug 'https://github.com/kana/vim-submode'
Plug 'https://github.com/kana/vim-textobj-function.git'
Plug 'https://github.com/kana/vim-textobj-indent'
Plug 'https://github.com/kana/vim-textobj-line'
Plug 'https://github.com/kana/vim-textobj-syntax'
Plug 'https://github.com/kana/vim-textobj-underscore'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/kchmck/vim-coffee-script'
Plug 'https://github.com/leafgarland/typescript-vim'
Plug 'https://github.com/tek/vim-textobj-ruby.git'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/styled-components/vim-styled-components.git', { 'branch': 'main' }
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/Quramy/vim-js-pretty-template'
Plug 'https://github.com/rhysd/vim-crystal'
Plug 'https://github.com/rust-lang/rust.vim.git'
Plug 'https://github.com/racer-rust/vim-racer'
Plug 'https://github.com/roxma/vim-tmux-clipboard'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/timcharper/wordnet.vim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-endwise'
" Use my personal version until changes are accepted by @tpope
Plug 'https://github.com/ddrscott/vim-fugitive'
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

" Plug 'https://github.com/vim-airline/vim-airline'
" Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/vim-ruby/vim-ruby'
Plug 'https://github.com/wellle/targets.vim.git'
Plug 'https://github.com/whatyouhide/vim-textobj-xmlattr.git'
Plug 'https://github.com/zeekay/vimtips.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tek/vim-fieldtrip'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'https://github.com/mhinz/vim-startify'
Plug 'https://github.com/vito-c/jq.vim.git'


Plug 'https://github.com/ddrscott/vim-side-search'
Plug 'https://github.com/ddrscott/vim-sendtext'
Plug 'https://github.com/ddrscott/vim-window'
Plug 'https://github.com/ddrscott/vim-textobj-anyblock'

" Code Completion
Plug 'https://github.com/neoclide/coc.nvim', {'tag': '*', 'branch': 'release', 'do': { -> coc#util#install()}}
" Linting
Plug 'https://github.com/w0rp/ale'

" Python text objects
Plug 'https://github.com/jeetsukumaran/vim-pythonsense.git'
Plug 'https://github.com/vim-python/python-syntax.git'

" Keep this at the end!
call plug#end()
