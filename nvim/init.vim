call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/Shougo/deoplete.nvim'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/kassio/neoterm'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-endwise'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-haml'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-sensible'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/vim-ruby/vim-ruby'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/zeekay/vimtips.git'
Plug 'https://github.com/osyo-manga/vim-monster.git'
Plug 'https://github.com/rust-lang/rust.vim.git'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/mxw/vim-jsx'
call plug#end()

filetype indent plugin on
syntax enable

" set term title to current file
autocmd BufEnter * let &titlestring=expand("%:t") | set title

set background=dark
let g:solarized_termtrans=0
let g:solarized_termcolors=16
colorscheme solarized

" Airline
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']

" NeoVim
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  tnoremap <Esc><Esc> <C-\><C-n>
endif

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer','tag']

" Fuzzy Finder
set runtimepath+=~/.fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" JSX highlighting in *.js file
let g:jsx_ext_required = 0

" Custom FileType settings
autocmd FileType ruby set tags=.tags.ruby,.tags.gem,gem.tags,gems.tags,tags;/
autocmd FileType javascript set tags=.tags.jsx,tags
autocmd! BufWritePost * Neomake
autocmd QuickFixCmdPost *grep* cwindow     " open search results immediately
autocmd VimResized * let &previewheight=(winheight(0) * 1/3)

set number
set virtualedit=block
set directory=~/tmp
set showcmd

" allow unsaved buffers to be hidden
set hidden

set incsearch

" more natural window splits
set splitbelow
set splitright
set winheight=10
set winminheight=10
set winwidth=40
set winminwidth=15


" text wrapping
set textwidth=80
set linebreak     " break at whitespace
set nolist        " list disables linebreak
set nowrap
set nolazyredraw
set breakindent
set breakindentopt=sbr 
set showbreak=↪>\  " ↪ space
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

set autoindent smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType java set autoindent smartindent tabstop=4 shiftwidth=4  noexpandtab
autocmd FileType go set autoindent smartindent tabstop=4 shiftwidth=4  noexpandtab
autocmd FileType hs set autoindent smartindent tabstop=4 shiftwidth=4  noexpandtab

" Reset Leader
nnoremap " " <Nop>
let mapleader=" "

" Fix my common typos
command! W w   " write it

inoremap <C-@> <C-n>
inoremap jj <ESC>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

map <Leader>n :NERDTreeToggle<CR>
noremap <silent> <Leader>ff :FZF<CR>
noremap <silent> <Leader>b :Buffers<CR>
noremap <silent> <f5> :set paste!<CR>
nnoremap <C-]> g<C-]>
nnoremap <C-w><C-w> <C-w><C-p>
nnoremap <Leader>] <C-]>
nnoremap <Leader>} <C-w>}
nnoremap ; :
nnoremap <silent> <Leader>5 :let @* = expand("%")<CR>:echo "copied: " . expand("%")<CR>
nnoremap <Up> gk
nnoremap <Down> gj

" Disable annoying key defaults
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
nnoremap Y y$

" Buffer Stuff
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <Leader>bb :b#<CR>
nnoremap <silent> <C-x> <C-o>:bdelete #<CR>

command! FZFMru call fzf#run({'source': v:oldfiles, 'sink': 'e', 'options': '-m -x +s', 'down': '40%'}) 
nnoremap <silent> <Leader>fh :Hist<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>

" Grep Stuff
noremap <silent> <Leader>gw :Ag '\b<CWORD>\b'<CR>

" Multicursor
let g:multi_cursor_start_key='<Leader>m'

" Word index stuff
set wildmode=longest,list:longest
set wildignore+=tmp/ios,tmp/android,app/assets/images,public/assets,vendor/assets,bin/classes
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=tags
set wildignore+=*/tmp/*
set wildignore+=*/vendor/*
set wildignore+=*.class
set wildignore+=*/node_modules/*
set wildignore+=*/*.min.js*
set wildignore+=*/bower_components

" System clipboard
set clipboard+=unnamedplus

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
