source ~/.config/nvim/plugins.vim

runtime macros/matchit.vim
call arpeggio#load()

" Basics Settings {{{
scriptencoding utf-8

filetype indent plugin on
syntax sync fromstart

" turn off bell on ESC
set noerrorbells visualbell t_vb=

" misc
set nostartofline
set directory=~/tmp
set foldmethod=syntax
set foldlevelstart=99
set incsearch
set number
set relativenumber
set showcmd
set virtualedit=block
" Case sensitivity
" I tried this while ignoring case and it was driving me crazy
set noignorecase
set smartcase
set nocursorcolumn
set cursorline
set mouse=a

" No tmp or swp files
set nobackup
set nowritebackup
set noswapfile

" System clipboard
set clipboard+=unnamedplus

" allow unsaved buffers to be hidden
set hidden
" }}}

" Look and Feel {{{
set background=dark
" Make sure to set iTerm to xterm-256color
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  colorscheme base16-default-dark
endif

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
set winminheight=1
set winminwidth=5

" no background on vertical split
highlight VertSplit cterm=bold ctermfg=11 ctermbg=NONE

" text wrapping
set textwidth=80
set linebreak     " break at whitespace
set nolist        " list disables linebreak
set nowrap
set lazyredraw    " reduced screen flicker
set breakindent
set breakindentopt=sbr,shift:4
set showbreak=↪>\  " ↪ space
set autoindent smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set whichwrap+=<,>,h,l,[,]

" make columns outside textwidth blanked out
let &colorcolumn=join(range(&textwidth+1,&textwidth+1),",")

" Sensible side scrolling, makes it like other editors.
" Reduce scroll jump with cursor goes off the screen.
set sidescroll=1
set sidescrolloff=3

" Completion options
"   current buffer, windowed buffers, other loaded bufferes, and tags.
"   different from default by NOT considering unloaded buffers.
"
" 	.	scan the current buffer ('wrapscan' is ignored)
"   w scan buffers from other windows
"   b scan other loaded buffers that are in the buffer list
"   k scan the files given with the 'dictionary' option
"   ] tag completion
set complete=.,w,b,],k
set completeopt=menuone,preview,longest
" }}}

" Airline {{{
" Disable: no more airline. try a simple status line instead.
" let g:airline#extensions#tabline#left_alt_sep = '|'
" " no more top bar. lets see if we can live without it.
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
" let g:airline#extensions#quickfix#location_text = 'Location'
" let g:airline#extensions#branch#enabled = 0
" " removes full path from status line. just show the file name
" let g:airline_section_c = '%<%t%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_powerline_fonts = 0
" let g:airline_theme='solarized'
" let g:airline_section_x=''
" let g:airline_section_y=''
" }}}

" Markdown Settings {{{
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']
" }}}

" NeoVim {{{
if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  tnoremap <Esc><Esc> <C-\><C-n>
  " tnoremap gf :pedit <cfile><cr>
  augroup neovim_stuff
    au!
    autocmd BufWinEnter,WinEnter term://*
          \ setlocal nonumber norelativenumber
    " autocmd WinEnter term://* startinsert
  augroup END

  function! TermGf()
    if &buftype ==# "terminal"
      :vertical pedit <cfile>
    else
      normal! gf
    endif
  endfunction
  nnoremap gf :call TermGf()<CR>
endif
if exists('+inccommand')
  set inccommand=nosplit
endif
" }}}

" Deoplete - disabled {{{
" This might slow down individual keystrokes.
" Comment out the block if the benefits aren't worth the cost.
" @see https://github.com/Shougo/deoplete.nvim
" :help deoplete
if exists('g:loaded_deoplete')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_camel_case = 1
  let g:deoplete#auto_complete_delay = 100
  let g:deoplete#complete_method = 'omnifunc'
  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#functions.javascript = [
    \ 'tern#Complete',
    \ 'jspc#omni'
    \]
  nnoremap <Leader>dt :call deoplete#toggle()<CR>
endif
" }}}

" YouCompleteMe {{{
let g:ycm_auto_trigger = 0
" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" let g:ycm_key_invoke_completion = '<C-Space>'
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
  " sets special tag files to include gem.tags and look at parent dirs
  autocmd FileType ruby set tags=gem.tags,tags;/
        \ | setlocal makeprg=rubocop\ --format\ emacs\ %
        \ | setlocal formatprg=rubocop\ -a\ --stdin\ %\ \|sed\ '1,/====================/d'

  autocmd FileType javascript,javascript.jxs set tags=.tags.jsx,tags
        \ | command! -buffer Reformat call SaveViewExecute('!eslint --fix %')
        " This doesn't work :( \ | setlocal formatprg=eslint\ --stdin\ --fix

  if executable('sqlformat') == 1
    autocmd FileType sql setlocal formatprg=sqlformat\ -k\ upper\ -i\ lower\ --reindent_aligned\ -
  endif
  
  autocmd FileType markdown,vim setlocal textwidth=80
  autocmd FileType java,go,hs set autoindent smartindent tabstop=4 shiftwidth=4  noexpandtab

  autocmd FileType markdown set makeprg=diction\ % errorformat=%f:%l:\ %m

  " set term title to current file
  autocmd BufEnter * let &titlestring=expand("%:t") | set title

  " Use Neomake for syntax checking
  autocmd BufWritePost * Neomake

  autocmd VimResized * let &previewheight=(winheight(0) * 1/3)
  autocmd BufEnter init.vim setlocal foldmethod=marker

  autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Open help always to the right.
  autocmd FileType help wincmd L
augroup END
" }}}

" Key Mappings {{{
" Reset Leader
nnoremap <Space> <Nop>
let mapleader=" "

" Fix my common typos
command! W w    " write it
command! QQ qa! " quit I mean it!

" <C-@> is same as <S-Space>
inoremap <C-@> <C-n>

" Toggle Movements {{{
" Helper function to use an alternate movement if the first
" movement doesn't move the cursor.
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  let c = v:count > 0 ? v:count : ''
  execute "normal! " . c . a:firstOp
  if pos == getpos('.')
    execute "normal! " . c . a:thenOp
  endif
endfunction

" Warning: 0 uses ^ first, then 0
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>
nnoremap <silent> ^ :call ToggleMovement('0', '^')<CR>
nnoremap <silent> $ :call ToggleMovement('$', '^')<CR>
" }}}

" Warning: I'm killing the 2nd <C-r> in these modes because '"' is too hard to
" reach. This makes <C-r> more consistent with Register access in insert and
" command mode.
nnoremap <C-r><C-r> ""
cnoremap <C-r><C-r> <C-r>"
vnoremap <C-r><C-r> ""
cnoremap <C-k> <up>
cnoremap <C-j> <down>

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
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>
noremap <ScrollWheelLeft> zl
noremap <ScrollWheelRight> zh

" Warning: Faster schooling with C-e/y and keeps cursor in place.
" This is similar to <C-d/u> behavior
nnoremap <C-e> 3<C-e>3gj
nnoremap <C-y> 3<C-y>3gk

" Search Replace Helpers {{{
" Allows use of '.' to change the next occurance of the same work. Totally Sweet!
nnoremap c* *<C-o>cgn
nnoremap c# #<C-o>cgn
nnoremap <Leader>*  /\v<<C-r><C-w>><CR><C-o>
nnoremap <Leader>// /\v<<C-r><C-w>><CR><C-o>
nnoremap <Leader>/w /\v<><left>
nnoremap <Leader>/s :%s/\v<<C-r><C-w>>//gce<left><left><left>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR><C-o>'
" }}}

" cut/copy/paste helpers {{{
vnoremap <Leader>x d
vnoremap <Leader>c ygv
vnoremap <Leader>v "_p
nnoremap <Leader>y myyiw`y
nnoremap <Leader>p mp"_diwP`p
" visually select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" }}}

" Nerd Tree / Netrw {{{
let g:netrw_liststyle=3
let g:netrw_altfile=1
let g:netrw_winsize=25
" nnoremap <Leader>n :Lexplore<CR>
" nnoremap - :exe 'Lexplore' expand('%:h')<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap - :NERDTreeFind<CR>
" }}}

" Tagbar {{{
nnoremap <Leader>tb :Tagbar<CR>
nnoremap <Leader>ta :TagbarOpenAutoClose<CR>
" }}}

" Neoterm mappings {{{
" nnoremap <Leader>tt :Topen<CR>
" nnoremap <Leader>tr :TREPLSend<CR>
" }}}

" Easy Command Mode
nnoremap <Leader>; :
" `<CR>` in normal buffer sends `:`
nnoremap <silent> <CR> :call feedkeys((&buftype == '' ? ':' : expand("\r")), 'n')<CR>

" Paste mode, NeoVim might not need this.
nnoremap <silent> <f5> :set paste!<CR>:set paste?<CR>

" Better use :tjump instead of :tag
" Warning: swapping <C-]> and g<C-]>
nnoremap <C-]> g<C-]>
nnoremap g<C-]> <C-]>

" [c]lear [w]hitespace
function! ClearWhitespace()
  let winview = winsaveview()
  let _s=@/
  execute 'keepjumps %s/\s\+$//e'
  let @/=_s
  nohl
  update
  call winrestview(winview)
endfunction
nnoremap <Leader>cw :call ClearWhitespace()<CR>

" Copy current buffer path to system clipboard
" I picked 5 because it's also the '%' key.
nnoremap <silent> <Leader>5 :let @* = expand("%:p")<CR>:echom "copied: " . expand("%:p")<CR>

" Visual Selection Helpers {{{
" reselect last change
nnoremap <Leader>vv mv`[V`]`v

" Ctrl Left and Right (h, l) starts visual selection
" then continues it simlar to Shift-Option-Left/Right
nmap <S-A-l> ve
vmap <S-A-l> e
nmap <S-A-h> vb
vmap <S-A-h> b
nmap <A-l> e
nmap <A-h> b
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
command! Qa qa
command! QA qa

" Faster :ex commands
nnoremap <C-s> :write<CR>
inoremap <C-s> <ESC>:write<CR>
nnoremap <C-q> :close<CR>

" Buffer Stuff
" Warning: C-n/C-p to move to next/previous buffer. Instead of down/up lines.
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>
" Jump out until buffer changes {{{
function! s:jump_till_next_buffer() abort
  let current_nr = bufnr('%')
  let max = 100
  while bufnr('%') == current_nr
    exec "normal \<C-o>"
    if max == 0
      echo 'max jumps reached!'
      break
    endif
    let max -= 1
  endwhile
endfunction
" [x]-out the current buffer and jump out.
" nnoremap <silent> <C-x> <C-o>:bdelete! #<CR>
nnoremap <silent> <C-x> :call <SID>jump_till_next_buffer() <BAR>silent! bd#<CR>
" }}}

" Populate QuickFix with branch changes
command! QfBranch cgetexpr system("git diff --name-only  `git log --graph --oneline -99 \| grep -A 1 -E '^\\* [0-9a-f]{7}' \| cut -c 5-11 \| tail -1`.. \| sed -E 's/(.*)/\\1:0:0 \\1/'") | copen

" WIP - sed doesn't work in script, but does in terminal :/
" command! QfStat cexpr! system("git diff --stat=999 --name-only"
" \ . " `git log --graph --oneline -99 \| grep -A 1 -E '^\\* [0-9a-f]{7}' \| cut -c 5-11 \| tail -1`.. \|"
" \ . " sed -E 's~ ([^ \|]+)([ \|])+(.+)~\\1:0:0 Cats~'"
" \) | copen

" Fuzzy Finder FZF helpers {{{
" Super charged File finder
let g:fzf_file_name_only=" -d '/' --nth=-1"
let g:fzf_preview_source=" --preview 'pygmentize -g {} 2>/dev/null \|\| head -200 {}'"
nnoremap <silent> <Leader><Leader> :call fzf#vim#files('.', {'options': g:fzf_preview_source . g:fzf_file_name_only })<CR>
nnoremap <silent> <Leader>ff :call fzf#vim#files('.', {'options': g:fzf_preview_source })<CR>
nnoremap <silent> <Leader>fh :call fzf#vim#history({'options': g:fzf_preview_source . g:fzf_file_name_only })<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ls :Buffers<CR>

command! SinceDev call fzf#run({'source': 'git diff --name-only dev..', 'down': '33%', 'sink': 'edit', 'options': '-m'})
nnoremap <silent> <Leader>fd :SinceDev<CR>
" }}

nnoremap <silent> <Leader>bb :b#<CR>

" [b]uffer [o]nly - close all except my buffer
" Thanks: http://stackoverflow.com/a/34050776
nnoremap <silent> <Leader>bo :update<cr>:%bd<cr>:e#<CR>

" Not a FZF but I like the 'f' prefix :/
map <Leader>fw [I:let nr = input("Which tag?: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Warning: Yank without moving cursor! Awesome Sauce!
"          exit visual mode, my=mark y, last visual selection, y, go to mark
" Thanks: http://ddrscott.github.io/blog/2016/yank-without-jank/#comment-2643800118
vnoremap <expr>y 'my"'.v:register.'y`y'
vnoremap <expr>Y 'my"'.v:register.'Y`y'

" Warning: Marks last yank position.
nnoremap <expr>y 'my"'.v:register.'y'
nnoremap <expr>Y 'my"'.v:register.'y$'

" Warning: Paste moves to end of change. As if you typed in the change.
" This paste also maintains indent level with line above it.
" Also re-indents what ever was pasted.
nnoremap <expr>p '"'.v:register.']p`]mp=`[`p'
nnoremap <expr>P '"'.v:register.']P`]mp=`[`p'

" Visual Paste Override {{{
" Warning: overrides `p` and `P` behavior by preserving the "" register and
"          moving cursor to end of paste location
" See `:h setreg()` for a reference of how to use get/setreg.
function! VisualPaste()
  let s:saved_unnamed = getreg(v:register,1)
  let s:saved_type = getregtype(v:register)
  return "p`]mp=`[`p:call RestorePaste()\<cr>"
endfunction
function! RestorePaste()
  call setreg(v:register, s:saved_unnamed, s:saved_type)
endfunction
vnoremap <silent> <expr> p VisualPaste()

" Messes up too many other plugins :(
" nnoremap c mcc
" vnoremap c <ESC>mcgvc
" vnoremap C <ESC>mcgvC

" Grep Stuff
" Warning: sets @/ register to current word
nnoremap <silent> <Leader>gw :let @/=expand("<cword>")<CR>:execute "grep! " . shellescape(expand("<cword>"))<CR>:cwindow<CR>
" }}}

" Quick Editing {{{
command! Notes Files ~/notes
" Hit [v]im[r]c at the same time to open vimrc.
nnoremap <silent> <Leader>vr :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>ve :edit $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :source $MYVIMRC<CR>:echo $MYVIMRC . ' sourced'<CR>

" TODO why doesn't this work?
augroup SourceVimrc
  au!
  autocmd BufWritePost $MYVIMRC source <afile> | echo v:statusmsg . ' and sourced'
augroup END
" }}}

" Gsub {{{
function! Gsub(a, b, re)
  try
    let z=@/
    exe "'" . a:a . ",'" . a:b . a:re
  finally
    let @/=z
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
nnoremap <a-bs> a<C-w>
inoremap <a-bs> <C-w>
" No need for normal mode mappings.
" use <S-i> to insert begining
" use <S-a> to append at end
" }}}

" BlackHole {{{
" Performs a "_d against them motion or visual selection.
func! BlackHoleDeleteOperator(type, ...)
  if a:type ==# 'char'
    execute 'normal! `[v`]"_d'
  elseif a:type ==# 'line'
    execute 'normal! `[V`]"_d'
  else
    execute 'normal! `<' . a:type . '`>"_d'
  endif
endf
" Too intrusive to accidental BS use. Keep the visual mapping cause it's neat.
" nnoremap <silent> <BS> :set opfunc=BlackHoleDeleteOperator<CR>g@
vnoremap <silent> <BS> :<C-u>call BlackHoleDeleteOperator(visualmode(), 1)<CR>
" }}}


" Multicursor {{{
" Warning: Slightly more intuitive mappings. Plus I already use the defaults
"          <C-n/p> for buffer switching.
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<Leader>m'
let g:multi_cursor_next_key='m'
let g:multi_cursor_prev_key='<S-m>'
let g:multi_cursor_skip_key='<C-m>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=longest,list:longest
set wildignore=
set wildignore+=.hg,.git,.svn,*.pyc,*.spl,*.o,*.out,*.DS_Store,*.class,*.manifest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*.bak,*.exe,target,tags,gem.tags
set wildignore+=*.pyc,*.DS_Store,*.db,*.min.js
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,*.xc*,*.pbxproj,*.xcodeproj/**,*.xcassets/**
set wildignore+=*.js.map,ui/public/client/*,cassettes/**,node_modules/**
" }}}

" The Silver Searcher {{{
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ --word-regexp
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
" Disabled: This makes Vim slow for some reason.
" augroup cline
"   au!
"   au WinLeave,InsertEnter * set nocursorline
"   au WinEnter,InsertLeave * set cursorline
" augroup END
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
" Warning: takes over visual mode. Get use to it! Totally Sweet!
"          Defaults to `viw` which is usually what I want anyway.
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

call expand_region#custom_text_objects('ruby', {
      \ 'ir' :0,
      \ 'ar' :1,
      \ })
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
nmap <Leader>zf :execute 'set foldlevel='.(foldlevel(line('.')) - 1)<CR>zzzO
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
  " let g:neomake_open_list = 2
  sign define neomake_err text=⛔️
  sign define neomake_warn text=💩
augroup END

" Git Gutter {{{
augroup gitgutter_stuff
  au!
  nmap [h <Plug>GitGutterPrevHunk
  nmap ]h <Plug>GitGutterNextHunk
  nmap <Leader>hs <Plug>GitGutterStageHunk
  nmap <Leader>hr <Plug>GitGutterRevertHunk
  nmap <Leader>hp <Plug>GitGutterPreviewHunk
  nmap <Leader>hcc <Plug>GitGutterStageHunk:Gcommit<cr>
  nmap <Leader>hca <Plug>GitGutterStageHunk:Gcommit --amend<cr>
augroup END
" }}}

" ctag helpers {{{
command! Ctag !ctags --verbose --languages=ruby --recurse -f tags .
command! CtagBundle !ctags --verbose --languages=ruby --recurse -f gem.tags $(bundle list --paths | grep -v $(pwd))
command! Rtag !ripper-tags -R -f tags .
command! RtagBundle !ripper-tags -R -f gem.tags $(bundle list --paths | grep -v $(pwd))
" }}}

" Submode Plugins {{{
" Exit submodes after a 2 seconds. Think fast!
let g:submode_always_show_submode=1
let g:submode_timeout=1
let g:submode_timeoutlen=2000
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
call submode#enter_with('window', 'n', '', '<Leader>w')
call submode#leave_with('window', 'n', '', '<Esc>')
for key in ['a','b','c','d','e','f',
      \ 'g','h','i','j','k','l',
      \ 'm','n','o','p','r','s',
      \ 't','u','v','w','x','y','z']
  call submode#map('window', 'n', '', key, '<C-w>' . key)
  call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
  call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
call submode#map('window', 'n', '', 'q', '<C-w>c')
call submode#map('window', 'n', '', '<C-q>', '<C-w>c')
call submode#map('window', 'n', '', 'v', ':vnew<CR>')
call submode#map('window', 'n', '', '<C-v>', ':vnew<CR>')
call submode#map('window', 'n', '', '\', ':vertical resize 80<CR>')
call submode#map('window', 'n', '', '+', '3<C-w>+')
call submode#map('window', 'n', '', '-', '3<C-w>-')
call submode#map('window', 'n', '', '<', '10<C-w><')
call submode#map('window', 'n', '', '>', '10<C-w>>')
call submode#map('window', 'n', '', '=', '<C-w>=')
" }}}

" 'z' submode {{{
call submode#enter_with('Z', 'n', '', '<Leader>zz', 'zz')
call submode#leave_with('Z', 'n', '', '<Esc>')
call submode#map('Z', 'n', '', 't', 'zt')
call submode#map('Z', 'n', '', 'b', 'zb')
call submode#map('Z', 'n', '', 'l', 'zl')
call submode#map('Z', 'n', '', 'h', 'zh')
call submode#map('Z', 'n', '', 'L', 'zL')
call submode#map('Z', 'n', '', 'H', 'zH')
call submode#map('Z', 'n', '', 'j', 'zjzz')
call submode#map('Z', 'n', '', 'k', 'zkzz')
call submode#map('Z', 'n', '', 'z', 'zz')

" folding
call submode#map('Z', 'n', '', 'a', 'za')
call submode#map('Z', 'n', '', 'm', 'zm')
call submode#map('Z', 'n', '', 'o', 'zo')
call submode#map('Z', 'n', '', 'r', 'zr')
call submode#map('Z', 'n', '', 'A', 'zA')
call submode#map('Z', 'n', '', 'M', 'zM')
call submode#map('Z', 'n', '', 'O', 'zO')
call submode#map('Z', 'n', '', 'R', 'zR')
" }}}

" g-changes submode {{{
call submode#enter_with('g-changes', 'n', '', 'g;', 'g;')
call submode#enter_with('g-changes', 'n', '', 'g,', 'g,')
call submode#leave_with('g-changes', 'n', '', '<Esc>')
call submode#map('g-changes', 'n', '', ';', 'g;')
call submode#map('g-changes', 'n', '', ',', 'g,')
" }}}

" Smart Word Mappings {{{
" Warning: This overrides w/b/e/ge defaults
" map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge <Plug>(smartword-ge)
" }}}

" Arpeggio Mappings {{{
" Try [jl] since those fingers are closer in length :/
Arpeggio imap kj <Esc>
Arpeggio cmap kj <Esc>
Arpeggio vmap kj <Esc>
Arpeggio imap jl <Esc>
Arpeggio cmap jl <Esc>
Arpeggio vmap jl <Esc>
" }}}

" Git Functions {{{
function! GitBranchPoint()
  return system('git log --graph --oneline -99 | grep -A 1 -E ''^\* [0-9a-f]{7}'' | cut -c 5-11 | tail -1')
endfunction
command! DiffBranchPoint execute(':Gvdiff ' . GitBranchPoint())
" [d]iff [v]isually, same as fugitives mapping
nnoremap <Leader>dv :DiffBranchPoint<CR>
" }}}

" Inspired by some ajh17's save view routine
" Thanks: https://github.com/ajh17/dotfiles/blob/master/.vim/autoload/format.vim
function! SaveViewNormal(cmd)
  let winview = winsaveview()
  execute 'keepjumps normal! ' . a:cmd
  call winrestview(winview)
endfunction

function! SaveViewExecute(cmd)
  let winview = winsaveview()
  execute 'keepjumps ' . a:cmd
  call winrestview(winview)
endfunction

" Indent all lines without changing jumps or cursor position.
nnoremap <silent> g= :call SaveViewExecute('normal! gg=G')<CR>
command! Reformat call SaveViewExecute('normal! gggqG')

" Re-indent last change and move cursor to end of change
nnoremap =. :normal! =````<CR>
" }}}

" Split Join {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" [jo]in and [sp]lit
nmap <Leader>jo :SplitjoinJoin<cr>
nmap <Leader>sp :SplitjoinSplit<cr>
" }}}

" Better Behavior with PUM menu {{{
function! WhenPum(pum_map, other)
  if pumvisible()
    return a:pum_map
  endif
  return a:other
endfunction
" Don't do these mappings until `expr` with pumvisible works on first boot.
" inoremap <silent> <expr> <Enter> WhenPum("\<C-y>", "\<Enter>")
" inoremap <silent> <expr> <C-j> WhenPum("\<C-n>", "\<C-j>")
" inoremap <silent> <expr> <C-k> WhenPum("\<C-p>", "\<C-k>")
"}}}

" Sneak Plugin Settings {{{
" Help: :help sneak-defaults
" Warning: Overrides `s` and `S`.
"
"    Key Sequence             | Description
"    -------------------------|----------------------------------------------
"    s{char}{char}            | Go to the next occurrence of {char}{char}
"    S{char}{char}            | Go to the previous occurrence of {char}{char}
let g:sneak#s_next = 1
" }}}

" Side Toggle {{{
" Toggles a window with `a:src` file
" Example:  nnoremap <silent> <Leader>f0 :call <SID>side_toggle('~/notes/vim.md', 0.25)<CR><C-w>p
"           <C-w>p focuses on previous window.
" Params: a:src - the file to open
"         a:width - the width of the split as a percentage of screen width
function! s:side_toggle(src, width) abort
  if exists('s:side_bufnr') && s:side_bufnr > -1 && bufname(s:side_bufnr) != ''
    silent execute 'bwipeout ' . s:side_bufnr
    let s:side_bufnr = -1
    return
  endif
  let width = printf('%.f', &columns * a:width)
  silent execute 'keepalt botright vertical ' . width . 'split ' . a:src
  setlocal nobuflisted nolist nonumber norelativenumber noswapfile nowrap
  setlocal bufhidden=hide foldcolumn=0 textwidth=0 winfixheight winfixwidth
  let s:side_bufnr = bufnr('%')
endfunction

" [f]ile toggle 0 to view file, <Shift-0> to edit it
" repeat the f, command to close the buffer
nnoremap <silent> <Leader>f0 :call <SID>side_toggle('~/notes/vim.md', 0.25)<CR><C-w>p
nnoremap <silent> <Leader>f) :call <SID>side_toggle('~/notes/vim.md', 0.25)<CR>
nnoremap <silent> <Leader>fs :e ~/code/cen/scratch/spierce/scratch.rb<CR>
nnoremap <silent> <Leader>fz :e ~/.zshrc<CR>
" }}}

" Startify {{{
let g:startify_change_to_dir=0
let g:startify_change_to_vcs_root=1
" }}}

" Split Dot {{{
command! SplitDot
      \ let _s=@/                               <bar>
      \ s/\v\.\w+%(\([^)]+\)|\{[^}]+})*/\r\0/g  <bar>
      \ let @/=_s                               <bar>
      \ keepjumps normal! ``=']']

nnoremap <Leader>sd :SplitDot<CR>
" }}}

" terminal in new split {{{
command! -complete=file -nargs=+ Vterm vnew | setlocal winfixwidth winfixheight | terminal <args>
command! -complete=file -nargs=+ Sterm new | setlocal winfixwidth winfixheight | terminal <args>
nnoremap <Leader>tv :vnew <BAR>setlocal winfixwidth winfixheight <BAR> terminal<SPACE>
nnoremap <Leader>ts :new <BAR>setlocal winfixwidth winfixheight <BAR> terminal<SPACE>
" }}}

" Side Search {{{
let g:side_search_prg = 'ag --word-regexp'
      \. " --ignore='*.js.map'"
      \. " --ignore='*.csv'"
			\. " --ignore='*tags'"
      \. " --ignore='ui/public/client'"
      \. " --ignore='cassettes/'"
      \. " --ignore='components/help'"
      \. " --heading --stats -C 2 --group"
let g:side_search_splitter = 'vnew'
let g:side_search_split_pct = 0.4

" SideSearch current word and return to original window
nnoremap <Leader>ss :SideSearch <C-r><C-w><CR> | wincmd p

" SS shortcut and return to original window
command! -complete=file -nargs=+ SS execute 'SideSearch <args>'
" }}}

" Window Mappings for improved layout commands {{{
" Important: `:<C-U>` is required the function doesn't get called multiple times.
nnoremap ]r :<C-u>call window#rotate(-1 * v:count1)<cr>
nnoremap [r :<C-u>call window#rotate(1 * v:count1)<cr>

nmap <C-w>r ]r
nmap <C-w><C-r> ]r

nnoremap <C-w>x :<C-u>call window#exchange(v:count)<cr>
nnoremap <C-w><c-x> :<C-u>call window#exchange(v:count)<cr>

nnoremap <C-w>o :call window#only()<cr>
nnoremap <C-w><c-o> :call window#only()<cr>

nnoremap <C-w>gl :<C-u>call window#join('rightbelow vsplit', v:count) <BAR>normal 100zh<CR>
nnoremap <C-w>gh :<C-u>call window#join('leftabove vsplit', v:count)  <BAR>normal 100zh<CR>
nnoremap <C-w>gj :<C-u>call window#join('belowright split', v:count)  <BAR>normal 100zh<CR>
nnoremap <C-w>gk :<C-u>call window#join('aboveleft split', v:count)   <BAR>normal 100zh<CR>

command! -nargs=* LayoutH call window#layout('ball', 'H', <args>)
command! -nargs=* LayoutJ call window#layout('vertical ball', 'J', <args>) 
command! -nargs=* LayoutK call window#layout('vertical ball', 'K', <args>) 
command! -nargs=* LayoutL call window#layout('ball', 'L', <args>)

command! -nargs=* WinH call window#layout('windo wincmd J', 'H', <args>)
" }}}

" Simple commands to open external tools {{{
command! -nargs=* Stree call system('stree ' . <q-args>)
command! -nargs=* Open call system('open ' . <q-args>)
" }}}

" command! Duplicate execute('normal :saveas '.expand('%'))
cnoremap <C-e> <C-R>=expand('%')<CR>

" Open current file and line in Stash browser.
" Fugitives :Gbrowse doesn't support stash, so this is our ugly hack. {{{
command! StashOpen
  \ let _file=substitute(expand('%'), system('git rev-parse --show-toplevel'), '', '') <bar>
  \ let _branch=substitute(system('git rev-parse --abbrev-ref HEAD'), '\n', '', '') <bar>
  \ let _cmd='open "https://stash.centro.net/projects/CEN/repos/centro-media-manager/browse/' . _file . '?at=refs/heads/' . _branch . '#' . line('.') . '"'<bar>
  \ echo _cmd . system(_cmd)

" SendText Mappings {{{
" Send current line
nnoremap <silent> <Leader>i<CR> :SendTextCurrentLine<CR>

" Send in/around text object
nnoremap <silent> <Leader>i :set opfunc=sendtext#iTermSendOperator<CR>g@

" Send visual selection
vnoremap <silent> <Leader>i :<C-u>call sendtext#iTermSendOperator(visualmode(), 1)<CR>
" }}}

" Identify syntax group at current cursor position {{{
" Thanks: http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}

" Any character {{{
" Thanks: https://github.com/rhysd/vim-textobj-anyblock/blob/master/plugin/textobj/anyblock.vim
call textobj#user#plugin('anyblock', {
    \ '-' : {
    \      'select-a' : 'a.', '*select-a-function*' : 'textobj#anyblock#select_a',
    \      'select-i' : 'i.', '*select-i-function*' : 'textobj#anyblock#select_i',
    \   },
    \ })
" }}}

" This is a work around for using clipboard+=unnamedplus and block paste
" Thanks: https://github.com/neovim/neovim/issues/1822#issuecomment-70386284
" I modified slighty to accept different registers
function! BlockPaste(...)
  " Default to '+' system register
  let reg = '+'
  if a:0 > 0
    let l:reg = a:1
  endif
  let c = split(getreg(l:reg), '\n', 1)
  let lenght =  len(c)
  let start = line('.')
  let end = start + lenght -1
  let col = col('.') - 1
  let op_lines = range(start, end)
  let idx = 0
  for line in op_lines
    let line_orig = getline(line)
    let head = line_orig[:col-1]
    exe "let tail = line_orig[".col.":]"
    if len(head) < col
      let spaces = col - len(head)
      let head = head.repeat(' ', spaces)
    endif
    let new_line = head . c[idx] . tail
    call setline(line, new_line)
    let idx += 1
  endfor
endfunction
command! BlockPaste call BlockPaste('+')
