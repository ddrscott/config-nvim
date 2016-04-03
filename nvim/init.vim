" Plugins {{{
" Plugin manager provided by: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/Shougo/deoplete.nvim'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/jeetsukumaran/vim-indentwise'
Plug 'https://github.com/kana/vim-textobj-user.git'
Plug 'https://github.com/kassio/neoterm'
Plug 'https://github.com/kshenoy/vim-signature.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/nelstrom/vim-textobj-rubyblock.git'
Plug 'https://github.com/osyo-manga/vim-monster.git'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/plasticboy/vim-markdown'
Plug 'https://github.com/rust-lang/rust.vim.git'
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
Plug 'https://github.com/zeekay/vimtips.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'https://github.com/haya14busa/incsearch.vim'
call plug#end()
" }}}

" Basics Settings {{{
scriptencoding utf-8

filetype indent plugin on
syntax sync fromstart

set directory=~/tmp
set foldmethod=syntax
set foldlevelstart=99
set incsearch
set nonumber
set relativenumber
set showcmd
set virtualedit=block

" System clipboard
set clipboard+=unnamedplus

" allow unsaved buffers to be hidden
set hidden
" }}}

" Look and Feel {{{
set background=dark
let g:solarized_termtrans=0
let g:solarized_termcolors=16
colorscheme solarized

" set fillchars=diff:⣿,vert:\│
set fillchars=diff:-,vert:\│
set listchars=nbsp:⌴,trail:⌴,precedes:…,extends:…,tab:⇥\
set splitbelow
set splitright
" Don't try to highlight lines longer than X
set synmaxcol=1000
set winheight=10
set winminheight=10
set winwidth=78
set winminwidth=15

" no background on vertical split
highlight VertSplit cterm=bold ctermfg=11 ctermbg=NONE

" text wrapping
set textwidth=80
set linebreak     " break at whitespace
set nolist        " list disables linebreak
set nowrap
set nolazyredraw
set breakindent
set breakindentopt=sbr
set showbreak=↪>\  " ↪ space
set autoindent smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
" }}}

" Airline {{{
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_theme='solarized'
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']
" }}}

" NeoVim {{{
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  tnoremap <Esc><Esc> <C-\><C-n>
endif
" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer','tag']
" }}}

" Fuzzy Finder {{{
set runtimepath+=~/.fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" }}}

" Autocmds Settings  {{{
augroup basics_autocmd
  au!
  autocmd FileType ruby set tags=.tags.ruby,.tags.gem,gem.tags,gems.tags,tags;/
  autocmd FileType javascript set tags=.tags.jsx,tags
  autocmd FileType markdown,vim setlocal textwidth=80
  autocmd FileType java,go,hs set autoindent smartindent tabstop=4 shiftwidth=4  noexpandtab

  " set term title to current file
  autocmd BufEnter * let &titlestring=expand("%:t") | set title

  " Use Neomake for syntax checking
  autocmd BufWritePost * Neomake

  " open search results immediately
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd VimResized * let &previewheight=(winheight(0) * 1/3)
  autocmd BufEnter init.vim setlocal foldmethod=marker
augroup END
" }}}

" Key Mappings {{{
" Reset Leader
nnoremap <Space> <Nop>
let mapleader=" "

" Fix my common typos
command! W w   " write it
nnoremap ; :
nnoremap <C-;> ;

inoremap <C-@> <C-n>
inoremap kj <ESC>
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
map <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>tt :Tagbar<CR>
nnoremap <Leader>ta :TagbarOpenAutoClose<CR>
nnoremap <Leader><Space> <C-d>
nnoremap <silent> <f5> :set paste!<CR>
nnoremap <C-]> g<C-]>
nnoremap <C-w><C-w> <C-w><C-p>
nnoremap <C-w>\ :vertical resize 80<CR>

" Visual Selection Helpers {{{
" reselect last change
nnoremap <Leader>V V`]
nnoremap <Leader>v v`]
" Select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_
nnoremap VV V`]
" }}}

nnoremap <silent> <Leader>5 :let @* = expand("%")<CR>:echom "copied: " . expand("%")<CR>
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap } }zz
nnoremap { {zz
nnoremap zj zjzz
nnoremap zk zkzz

" Disable annoying key defaults
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
nnoremap Y y$

" Faster :ex commands
nnoremap <C-s> :write<CR>
inoremap <C-s> <ESC>:write<CR>
nnoremap <C-q> :quit<CR>

" Buffer Stuff
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <Leader>bb :b#<CR>
nnoremap <silent> <C-x> <C-o>:bdelete #<CR>

nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Hist<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>

" Grep Stuff
nnoremap <silent> <Leader>gw :execute "grep! " . shellescape(expand("<cWORD>"))<CR>:copen<CR>
" }}}

" Quick Editing {{{
command! Evimrc vsplit $MYVIMRC
command! Source source $MYVIMRC
command! Notes Files ~/notes
" }}}

" Emac Editing {{{
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" }}}

" Multicursor {{{
let g:multi_cursor_start_key='<Leader>m'
" }}}

" Wildmenu completion {{{
set wildmenu
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
" }}}

" The Silver Searcher {{{
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep
        \\ --ignore='*.js.map'
        \\ --ignore='*.csv'
        \\ --ignore='ui/public/client'
        \\ --ignore='cassettes/'
endif
" }}}

" Abbreviations {{{
iab deb debugger; // eslint-disable-line
" }}}

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END
" }}}

" Line Return {{{
" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}

" Expand Region {{{
" The plugin defaults to '_' and '+'
" vnoremap _ <Plug>(expand_region_shrink)
" vnoremap + <Plug>(expand_region_expand)
" }}}

" Inc Search {{{
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}

" Foldtext and Mappings {{{
" Fold mappings
nmap <Leader>zi :set foldmethod=indent<CR>
nmap <Leader>zs :set foldmethod=syntax<CR>
nmap <Leader>zk :set foldmethod=marker<CR>
nmap <Leader>zm :set foldmethod=manual<CR>
for i in [0,1,2,3,4,5,6,7,8,9]
  execute 'nmap <Leader>z' . i . ' :set foldlevel=' . i . '<CR>'
endfor

" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  let w = winwidth(0) - &foldcolumn - (&number || &relativenumber ? 4 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  " let foldLevelStr = repeat(">", v:foldlevel)
  let foldLevelStr = "" . v:foldlevel
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction
set foldtext=CustomFoldText()
set foldcolumn=1
highlight Folded  cterm=underline ctermfg=10 ctermbg=0
" }}}

" Quickfix Stuff {{{
augroup quickfix_stuff
  au!
  autocmd BufReadPost quickfix  setlocal norelativenumber number
augroup END
" }}}

" Fugitive Stuff {{{
augroup fugitive_stuff
  au!
  autocmd BufEnter fugitive* setlocal nofoldenable
augroup END
" }}}

" Neomake Stuff {{{
augroup neomake_stuff
  au!
  " It must be required or filetype gets set to javascript.jxs
  " which breaks how neomake detects the linter.
  let g:jsx_ext_required = 1
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_jsx_enabled_makers = ['eslint']
augroup END

" Git Gutter {{{
augroup gitgutter_stuff
  nmap [h <Plug>GitGutterPrevHunk
  nmap ]h <Plug>GitGutterNextHunk
  nmap <Leader>hs <Plug>GitGutterStageHunk
  nmap <Leader>hr <Plug>GitGutterRevertHunk
  nmap <Leader>hp <Plug>GitGutterPreviewHunk
augroup END
" }}}
