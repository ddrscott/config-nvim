" Plugins {{{
" Plugin manager provided by: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/Raimondi/delimitMate'
" Don't use deoplete. It was interupting typing too much
" Plug 'https://github.com/Shougo/deoplete.nvim'
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
" Case sensitivity
set ignorecase
set smartcase

" System clipboard
set clipboard+=unnamedplus

" allow unsaved buffers to be hidden
set hidden
" }}}

" Look and Feel {{{
set background=dark
" Make sure to set iTerm to xterm-256color
let g:solarized_termcolors=16
let g:solarized_termtrans=0
colorscheme solarized

" set fillchars=diff:⣿,vert:\│
set fillchars=diff:-,vert:\│
set listchars=nbsp:⌴,trail:⌴,precedes:…,extends:…,tab:⇥\
set splitbelow
set splitright
" Don't try to highlight lines longer than X
set synmaxcol=1000
set winheight=10
set winminheight=5
set winwidth=80
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
let g:airline_section_x=''
let g:airline_section_y=''
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']
" }}}

" NeoVim {{{
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  tnoremap <Esc><Esc> <C-\><C-n>
  augroup neovim_stuff
    au!
    autocmd BufWinEnter,WinEnter term://*
      \ setlocal nonumber norelativenumber |
      \ startinsert
  augroup END
endif
" }}}

" Deoplete - disabled {{{
" This was messing slowing down each keystroke.
"let g:deoplete#sources = {}
"let g:deoplete#sources._ = ['buffer']
"let g:deoplete#sources.rb = ['buffer','tag']
"let g:deoplete#enable_camel_case = 1
"let g:deoplete#auto_complete_delay = 100
"let g:deoplete#enable_at_startup = 1
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
" CTRL-G u  break undo sequence, start new change      *i_CTRL-G_u*
inoremap <CR> <C-g>u<CR>

" Make <C-r> more consisten with 'Register' access in insert and cmd mode.
nnoremap <C-r> :echo 'which regster? (access Redo with <S-u>)'<cr>"
nnoremap <C-r><C-r> "0
cnoremap <C-r><C-r> <C-r>0
vnoremap <C-r><C-r> "0
" ***** This pastes the last thing yanked!
inoremap <C-r><C-r> <C-r>0
" provide reverse mapping for original <C-r><C-r> behavior.
inoremap <C-r>r <C-r><C-r>

" Make capital U perform a Redo
nnoremap <S-u> <C-r>

" Scroll 1 line at a time instead of default 3
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>tb :Tagbar<CR>
nnoremap <Leader>ta :TagbarOpenAutoClose<CR>

" Neoterm mappings {{{
nnoremap <Leader>tt :Topen<CR>
nnoremap <Leader>tr :TREPLSend<CR>
" }}}

" Pager like Less/More
nnoremap <Leader><Space> <C-d>

" Paste mode, NVIM might not need this.
nnoremap <silent> <f5> :set paste!<CR>

" Better use :tjump instead of :tag
nnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>

" Alternate windows. Easier than 2 handed default.
nnoremap <C-w><C-w> <C-w><C-p>
nnoremap <C-w><C-p> <C-w><C-w>

" Make window exactly 80 columns wide
" note: <C-w>| is normally maximize.
nnoremap <C-w>\ :vertical resize 80<CR>

" Strip whitespace
" Zap-Whitespace
nnoremap <silent> <Leader>zw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Visual Selection Helpers {{{
" reselect last change
nnoremap <Leader>vV V`]
nnoremap <Leader>vv v`]
" Select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_
" }}}

nnoremap <silent> <Leader>5 :let @* = expand("%")<CR>:echom "copied: " . expand("%")<CR>
" Move through wrapped lines as default, with reverse mappings
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Defaults to w, but should be e like the rest all other basic editors.
nnoremap <S-RIGHT> e

" Center screen after common jumps.
nnoremap } }zz
nnoremap { {zz
nnoremap zj zjzz
nnoremap zk zkzz

" Disable annoying key defaults
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Faster :ex commands
nnoremap <C-s> :write<CR>
inoremap <C-s> <ESC>:write<CR>
nnoremap <C-q> :quit<CR>

" Buffer Stuff
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-x> <C-o>:bdelete #<CR>
nnoremap <silent> <Leader>bb :b#<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Hist<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>

" Delete to "x register
vnoremap x "xx
vnoremap X "xX

" Delete to "d register
" I use dd too much expecting to cut.
"nnoremap d "dd
"nnoremap D "dD

" ***** Yank without moving cursor!
" exit visual mode, my=mark y, last visual selection, y, go to mark
vnoremap y <ESC>mygvy`y
vnoremap Y <ESC>mygvY`y
" Use `y and 'y for last yank position.
nnoremap y myy
" Same with Y and make Y yank to end of line.
nnoremap Y myy$

" Swap p/P for gp/gP. Paste should moves to end of change.
" This paste also maintains indent level with line above it.
nnoremap p ]p`]mp
nnoremap P ]P`]mp

" Messes up too many other plugins :(
" nnoremap c mcc
" vnoremap c <ESC>mcgvc
" vnoremap C <ESC>mcgvC

" Grep Stuff
nnoremap <silent> <Leader>gw :execute "grep! " . shellescape(expand("<cWORD>"))<CR>:copen<CR>
" }}}

" Quick Editing {{{
command! Evimrc vsplit $MYVIMRC
command! Source source $MYVIMRC
command! Notes Files ~/notes
" }}}

" Substitutions {{{
command! DoubleToSingle %s/\"\([^"]*\)\"/'\1'/g
command! SymbolizeHash  %s/\v('|")([^\1]+)\1\s*\=\>\s*/\2: /g
" }}}

" Emac Editing {{{
cnoremap <C-e> <End>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
" }}}

" Multicursor {{{
let g:multi_cursor_start_key='<Leader>m'
" Use <C-n> and <C-p> to add or remove candidates
" Use action when done. Probably want c, a, or i.
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
        \     execute 'normal! g''"zvzz' |
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
  autocmd BufEnter fugitive://* setlocal nofoldenable
augroup END
" }}}

" Git Mappings {{{
nnoremap <Leader>gd :Gvdiff<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>ga :Gadd<cr>
nnoremap <Leader>gb :Gblame<cr>
nnoremap <Leader>gco :Gcheckout<cr>
nnoremap <Leader>gci :Gcommit<cr>
"nnoremap <Leader>gm :Gmove<cr>
"nnoremap <Leader>gw :Gwrite<cr>
"nnoremap <Leader>gr :Gremove<cr>
"nnoremap <Leader>gl :Shell git gl -18<cr>:wincmd \|<cr>
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
