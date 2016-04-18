" Plugins {{{
" Plugin manager provided by: https://github.com/junegunn/vim-plug
call plug#begin('~/.config/nvim/plugged')
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
" Plug 'https://github.com/scrooloose/nerdtree'
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
Plug 'https://github.com/ecomba/vim-ruby-refactoring'
Plug 'https://github.com/tommcdo/vim-exchange.git'
Plug 'https://github.com/AndrewRadev/switch.vim.git'
Plug 'AndrewRadev/sideways.vim'
Plug 'kana/vim-submode'
Plug 'tek/vim-fieldtrip'
call plug#end()
" }}}

runtime macros/matchit.vim

" Basics Settings {{{
scriptencoding utf-8

filetype indent plugin on
syntax sync fromstart

set directory=~/tmp
" tree style listing
let g:netrw_liststyle=3
set foldmethod=syntax
set foldlevelstart=99
set incsearch
set nonumber
set relativenumber
set showcmd
set virtualedit=all
" Case sensitivity
" I tried this while ignoring case and it was driving me crazy
set noignorecase
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
set listchars=nbsp:+,trail:*,precedes:<,extends:>,tab:>\
set splitbelow
set splitright

" Don't try to highlight lines longer than X
set synmaxcol=1000

" Sensible window sizes
set winheight=10
set winwidth=80
set winminheight=5
set winminwidth=15

" no background on vertical split
highlight VertSplit cterm=bold ctermfg=11 ctermbg=NONE

" text wrapping
set textwidth=80
set linebreak     " break at whitespace
set nolist        " list disables linebreak
set nowrap
set lazyredraw
set breakindent
set breakindentopt=sbr
set showbreak=↪>\  " ↪ space
set autoindent smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" Completion options
"   current buffer, windowed buffers, other loaded bufferes, and tags.
"   different from default by NOT considering unloaded buffers.
set complete=.,w,b,t
set completeopt=menuone,preview
" }}}

" Airline {{{
let g:airline#extensions#tabline#left_alt_sep = '|'
" no more top bar. lets see if we can live without it.
let g:airline#extensions#tabline#enabled = 0
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
      \ setlocal nonumber norelativenumber
    autocmd WinEnter term://*
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
  " sets special tag files to include gem.tagsand look at parent dirs
  " remove '_' from ruby keyword so `w` stops at underscore
  autocmd FileType ruby set tags=gem.tags,tags;/
    \ | setlocal makeprg=rubocop\ \-\-format\ emacs\ %
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

" <C-@> is same as <S-Space>
inoremap <C-@> <C-n>

" After trying this for some time. It's too disruptive of insert mode
" to NOT see 'k' come out as soon as I press it. Oh well. Back to using
" <C-c>, <ESC>, <C-[>
" inoremap kj <ESC>

" Toggle Movements {{{
" Helper function to use an alternate movement if the first
" movement doesn't move the cursor.
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" Warning: 0 uses ^ first, then 0
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>
nnoremap <silent> ^ :call ToggleMovement('0', '^')<CR>

nnoremap <silent> $ :call ToggleMovement('$', '^')<CR>

nnoremap <silent> ; :call ToggleMovement(';', ',')<CR>
nnoremap <silent> , :call ToggleMovement(',', ';')<CR>

nnoremap <silent> H :call ToggleMovement('H', 'L')<CR>
nnoremap <silent> L :call ToggleMovement('L', 'H')<CR>

nnoremap <silent> G :call ToggleMovement('G', 'gg')<CR>
nnoremap <silent> gg :call ToggleMovement('gg', 'G')<CR>
" }}}

" Other Toggles {{{
" stop the insanity! nnoremap <silent> <C-[> a
"}}}

" Warning: CTRL-G u  break undo sequence, start new change      *i_CTRL-G_u*
" This is an awesome feature. Especially for those that stay in insert mode a
" little too long. Old habits due hard. But at least now the undo isn't so
" drastic.
inoremap <CR> <C-g>u<CR>
" Warning: breaks undo sequence when space is used.
inoremap <Space> <C-g>u<Space>

" Warning: I'm killing the 2nd <C-r> in these modes because '"' is too hard to
" reach. This makes <C-r> more consistent with Register access in insert and
" command mode.
nnoremap <C-r> :echo 'which regster? (access Redo with <S-u>)'<cr>"
nnoremap <C-r><C-r> ""
cnoremap <C-r><C-r> <C-r>"
vnoremap <C-r><C-r> ""

" Warning: This pastes the last thing yanked! Awesome sauce!
inoremap <C-r><C-r> <C-r>"
" Warning: provide reverse mapping for original <C-r><C-r> behavior at the
" expense of accessing the 'r' register. Poor 'r' register no one loves you.
inoremap <C-r>r <C-r><C-r>

" Warning: Make capital U perform a Redo
" Because of the <C-r> hacks above, I break <S-u> and make it redo. The default
" because of <S-u> is undo the whole line. Sorry if you used it.
nnoremap <S-u> <C-r>

" Warning: Scroll 1 line at a time instead of default 3
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Warning: Faster schooling with C-e/y and keeps cursor in place.
nnoremap <C-e> 3<C-e>3j
nnoremap <C-y> 3<C-y>3k

" Nerd Tree {{{
" nnoremap <Leader>n :NERDTreeToggle<CR>
" }}}

" Tagbar {{{
nnoremap <Leader>tb :Tagbar<CR>
nnoremap <Leader>ta :TagbarOpenAutoClose<CR>
" }}}

" Neoterm mappings {{{
nnoremap <Leader>tt :Topen<CR>
nnoremap <Leader>tr :TREPLSend<CR>
" }}}

" Pager like Less/More
nnoremap <Leader><Space> <C-d>

" Paste mode, NeoVim might not need this.
nnoremap <silent> <f5> :set paste!<CR>

" Better use :tjump instead of :tag
" Warning: swapping <C-]> and g<C-]>
nnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>

" Alternate windows. Easier than 2 handed default.
" Warning: swapping <C-w><C-w> and <C-w><C-p>
nnoremap <C-w><C-w> <C-w><C-p>
nnoremap <C-w><C-p> <C-w><C-w>

" Make window exactly 80 columns wide
" note: <C-w>| is normally maximize.
nnoremap <C-w>\ :vertical resize 80<CR>

" [z]ap [w]hitespace
nnoremap <silent> <Leader>zw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<Bar>:write<CR>

" Copy current buffer path to system clipboard
" I picked 5 because it's also the '%' key.
nnoremap <silent> <Leader>5 :let @* = expand("%")<CR>:echom "copied: " . expand("%")<CR>

" Visual Selection Helpers {{{
" reselect last change
nnoremap <Leader>vv mv`[V`]`v
" Select (charwise) the contents of the current line, excluding indentation.
nnoremap vv ^vg_

" Ctrl Left and Right (h, l) starts visual selection
" then continues it simlar to Shift-Option-Left/Right
nnoremap <S-A-l> ve
vnoremap <S-A-l> e
nnoremap <S-A-h> vb
vnoremap <S-A-h> b
nnoremap <A-l> e
nnoremap <A-h> b
" }}}

" Move through wrapped lines as default, with reverse mappings
" Warning: swapping k with gk and j with gj
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Defaults to w, but should be e like the rest all other basic editors.
" Warning: make S-RIGHT because like the rest of the OS.
nnoremap <S-RIGHT> e

" Center screen after common jumps.
" Warning: This might make you mad, but makes my happy. I'm so selfish.
nnoremap } }zz
nnoremap { {zz
nnoremap zj zjzz
nnoremap zk zkzz

" Warning: Disable annoying key defaults
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Faster :ex commands
nnoremap <C-s> :write<CR>
inoremap <C-s> <ESC>:write<CR>
nnoremap <C-q> :quit<CR>

" Buffer Stuff
" Warning: C-n/C-p to move to next/previous buffer. Instead of down/up lines.
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
" [x]-out the current buffer and jump out.
nnoremap <silent> <C-x> <C-o>:bdelete #<CR>

" Populate QuickFix with changes since dev
command! QfSinceDev cexpr! system("git diff --name-only dev.. \| sed -E 's/(.*)/\\1:0:0 \\1/'") | copen

" Fuzzy Finder FZF helpers {{{
command! SinceDev call fzf#run({'source': 'git diff --name-only dev..', 'down': '33%', 'sink': 'edit', 'options': '-m'})
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fh :Hist<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fd :SinceDev<CR>
" }}}

" Warning: Delete to "x register
vnoremap x "xx
vnoremap X "xX

" Delete to "d register
" I use dd too much expecting to cut.
"nnoremap d "dd
"nnoremap D "dD

" Warning: Yank without moving cursor! Awesome Sauce!
" exit visual mode, my=mark y, last visual selection, y, go to mark
vnoremap y myy`y
vnoremap Y myY`y

" Warning: Marks last yank position.
nnoremap y myy
nnoremap Y myy$

" Warning: Paste moves to end of change. As if you typed in the change.
" This paste also maintains indent level with line above it.
" Also re-indents what ever was pasted.
nnoremap p ]p`]mp=`[`p
nnoremap P ]P`]mp=`[`p

" Messes up too many other plugins :(
" nnoremap c mcc
" vnoremap c <ESC>mcgvc
" vnoremap C <ESC>mcgvC

" Quick Inserts {{{
" There's no way to remember this unless you're me.
" I often `dw` parameters and append them to reorder as needed.
" Usage: `dw`, `e` to the new location, `, `
" Note: specifically NOT <Leader><Space> because ',' is a parameter seperator.
nnoremap ,<SPACE> a, <C-r>"<ESC>
" }}}

" Grep Stuff
nnoremap <silent> <Leader>gw :execute "grep! " . shellescape(expand("<cWORD>"))<CR>:copen<CR>
" }}}

" Quick Editing {{{
command! Evimrc vsplit $MYVIMRC
command! Source source $MYVIMRC
command! Notes Files ~/notes
" }}}

" Gsub {{{
function! Gsub(a, b, re)
  try
    let z=@/
    exe "'" . a:a . ",'" . a:b . a:re
  finally
    unlet z
  endtry
endfunction
" }}}

" SymbolizeHash {{{
func! SymbolizeHash(a, b)
  call Gsub(a:a, a:b, 's/\v(''|")([^\1]+)\1\s*\=\>\s*/\2: /ge')
endf

func! SymbolizeHashOperation(type)
  call SymbolizeHash('[', ']')
endf

nnoremap <Leader>zh <Esc>:set opfunc=SymbolizeHashOperation<CR>g@
vnoremap <Leader>zh <Esc>:call SymbolizeHash('<','>')<CR>
" }}}

" DoubleToSingleQuote {{{
func! DoubleToSingleQuote(a, b)
  call Gsub(a:a, a:b, 's/\v"([^"#]+)"/''\1''/ge')
endf

func! DoubleToSingleQuoteOperation(type)
  call DoubleToSingleQuote('[', ']')
endf

nnoremap <Leader>zq <Esc>:set opfunc=DoubleToSingleQuoteOperation<CR>g@
vnoremap <Leader>zq <Esc>:call DoubleToSingleQuote('<','>')<CR>
" }}}

" Emacs Editing {{{
cnoremap <C-e> <End>
cnoremap <C-a> <Home>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
nnoremap <a-bs> "_db
inoremap <a-bs> <C-w>
" No need for normal mode mappings.
" use <S-i> to insert begining
" use <S-a> to append at end
" }}}

" BlackHole {{{
" Performs a "_d against them motion or visual selection.
func! BlackHoleDeleteOperator(type)
  if a:type ==# 'char'
    execute 'normal! `[v`]"_d'
  elseif a:type ==# 'line'
    execute 'normal! `[V`]"_d'
  else
    execute 'normal! `<' . a:type . '`>"_d'
  endif
endf

nnoremap <silent> <BS> <Esc>:set opfunc=BlackHoleDeleteOperator<CR>g@
vnoremap <silent> <BS> :<C-u>call BlackHoleDeleteOperator(visualmode())<CR>
" }}}


" Multicursor {{{
let g:multi_cursor_start_key='<Leader>m'
" Use <C-n> and <C-p> to add or remove candidates
" Use action when done. Probably want c, a, or i.
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=longest,list:longest
set wildignore=
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
" Warning: beat up all the search defaults.
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

" Map <Leader>z0-9 to set a foldlevel directly
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
" defaults to off
" set foldcolumn=0
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
  autocmd BufEnter fugitive://* setlocal foldenable
augroup END
" }}}

" Git Mappings {{{
nnoremap <Leader>gd :Gvdiff<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>ga :Gadd<cr>
nnoremap <Leader>gb :Gblame<cr>
"nnoremap <Leader>gco :Gcheckout<cr>
"nnoremap <Leader>gci :Gcommit<cr>
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
  let g:neomake_open_list = 0
augroup END

" Git Gutter {{{
augroup gitgutter_stuff
  nmap [h <Plug>GitGutterPrevHunk
  nmap ]h <Plug>GitGutterNextHunk
  nmap <Leader>hs <Plug>GitGutterStageHunk
  nmap <Leader>hr <Plug>GitGutterRevertHunk
  nmap <Leader>hp <Plug>GitGutterPreviewHunk
  nmap <Leader>hc <Plug>GitGutterStageHunk:Gcommit<cr>
augroup END
" }}}

" ctag helpers {{{
command! Ctag !ctags --verbose --languages=ruby --recurse -f tags .
command! CtagBundle !ctags --verbose --languages=ruby --recurse -f gem.tags $(bundle list --paths | grep -v $(pwd))
" }}}

" Submode Plugins {{{
" No exit submodes automatically
let g:submode_timeout=0
" }}}

" Fieldtrip and Sideways {{{
" Note: Sideways allows for switching of arguments.
"       Fieldtrip provides a submode for doing so.
" Defaults: `l` and `h' quickly move between args
"           `L` and `H` moves the arguments position right and left.
" [g]oto [a]rguments
let g:fieldtrip_start_map='ga'
" }}}

" Window Submode {{{
let g:submode_always_show_submode = 1
call submode#enter_with('window', 'n', '', '<Leader>w')
call submode#leave_with('window', 'n', '', '<Esc>')
call submode#map('window', 'n', '', 'l', '<C-w>l')
call submode#map('window', 'n', '', 'h', '<C-w>h')
call submode#map('window', 'n', '', 'j', '<C-w>j')
call submode#map('window', 'n', '', 'k', '<C-w>k')
call submode#map('window', 'n', '', 'L', '<C-w>L')
call submode#map('window', 'n', '', 'H', '<C-w>H')
call submode#map('window', 'n', '', 'J', '<C-w>J')
call submode#map('window', 'n', '', 'K', '<C-w>K')
call submode#map('window', 'n', '', 'q', '<C-w>q')
call submode#map('window', 'n', '', 'n', '<C-w>n')
call submode#map('window', 'n', '', 'v', '<C-w>v')
call submode#map('window', 'n', '', 'w', '<C-w>p') " w-w mappend to previous, not p.
" }}}
