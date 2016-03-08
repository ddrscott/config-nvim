call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/Shougo/deoplete.nvim'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/kassio/neoterm'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-endwise'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rails'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/vim-ruby/vim-ruby'
call plug#end()

syntax enable
set background=dark
" let g:solarized_termtrans=1
let g:solarized_termcolors=16
colorscheme solarized

" Airline
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']

autocmd FileType ruby set tags=.tags.ruby,.tags.gem,gem.tags,gems.tags,tags
autocmd FileType javascript set tags=.tags.jsx,tags
autocmd! BufWritePost * Neomake

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

" text wrapping
set textwidth=80
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Reset Leader
nnoremap " " <Nop>
let mapleader=" "

" :W same as :w
command! W w

map <Leader>w :set wrap!<CR>
map <Leader>n :NERDTreeToggle<CR>
noremap <silent> <f5> :set paste!<CR>
nnoremap <C-]> g<C-]>
nnoremap ; :
nnoremap <silent> <Leader>h :set hlsearch!<CR>

" Buffer Stuff
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-x> <C-o>:bdelete #<CR>

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

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
