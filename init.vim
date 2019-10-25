source ~/.config/nvim/after/plugin/multiple_cursors.vim
source ~/.config/nvim/after/plugin/linter_fixer.vim
source ~/.config/nvim/plugins.vim

let g:python_highlight_all = 1

runtime macros/matchit.vim

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

" Mouse in all but command mode.
set mouse=nvirh
" Use right click as a menu, not extending selection.
set mousemodel=popup_setpos

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
set completeopt=menuone,preview
" }}}

" Markdown Settings {{{
" }}}

if exists('+inccommand')
  set inccommand=nosplit
endif
" }}}

" Autocmds Settings  {{{
" File specific commands should go into ftplugins.
augroup basics_autocmd
  au!
  " set term title to current file
  autocmd BufEnter * let &titlestring=expand("%:t") | set title
  autocmd VimResized * let &previewheight=(winheight(0) * 1/3)

  autocmd WinEnter * if &previewwindow | setlocal nonumber norelativenumber colorcolumn=0 statusline='' | endif
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
nnoremap c* #*cgn
nnoremap c# *#cgn
nnoremap <Leader>*  /\v<<C-r><C-w>><CR><C-o>
nnoremap <Leader>// /\v<<C-r><C-w>><CR><C-o>
nnoremap <Leader>/w /\v<><left>
nnoremap <Leader>/s :%s/\v<<C-r><C-w>>//gce<left><left><left>
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR><C-o>'
vnoremap s :s/\v//g<left><left><left>
" }}}

" easier @@
nnoremap \ @@

" Some terminals double hit C-o when only a single is typed.
" So I need to bind C-o to another key.
nnoremap <C-\> <C-o>

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
" Creative, but annoying. Too often I accidentally hit <CR> and was typing in
" command mode.
"    nnoremap <silent> <CR> :call feedkeys((&buftype == '' ? ':' : expand("\r")), 'n')<CR>

" Turn on paste mode, paste, turn off paste mode.
nnoremap <silent> <f5> :set paste <bar> exec('norm! p') <bar> set nopaste<cr>

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
vnoremap k gk
vnoremap j gj
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
command! QA qa!
command! -bang QA qa!

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
nnoremap <expr>y 'my'.v:count.'"'.v:register.'y'
nnoremap <expr>Y 'my"'.v:register.'y$'

" Warning: Paste moves to end of change. As if you typed in the change.
" This paste also maintains indent level with line above it.
nnoremap <expr>p ''.v:count.'"'.v:register.']p`]mp'
nnoremap <expr>P ''.v:count.'"'.v:register.']P`]mp'

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
nnoremap <silent> <Leader>vs :w <bar> source $MYVIMRC<CR>
" }}}

" Emacs Editing {{{
cnoremap <C-e> <End>
cnoremap <C-a> <Home>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
nnoremap <a-bs> a<C-w>
inoremap <a-bs> <C-w>
" Ctrl-C to quit insert mode with AfterInsert callbacks
inoremap <C-c> <ESC>
" No need for normal mode mappings.
" use <S-i> to insert begining
" use <S-a> to append at end
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest,full
set wildignore=
set wildignore+=.hg,.git,.svn,*.pyc,*.spl,*.o,*.out,*.DS_Store,*.class,*.manifest
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*.bak,*.exe,target,tags,gem.tags
set wildignore+=*.pyc,*.DS_Store,*.db,*.min.js
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,*.xc*,*.pbxproj,*.xcodeproj/**,*.xcassets/**
set wildignore+=*.js.map,ui/public/client/*,cassettes/**,node_modules/**
" }}}

" Fieldtrip and Sideways {{{
" Note: Sideways allows for switching of arguments.
"       Fieldtrip provides a submode for doing so.
" Defaults: `l` and `h' quickly move between args
"           `L` and `H` moves the arguments position right and left.
" [g]oto [a]rguments
let g:fieldtrip_start_map='ga'
" }}}

" Re-indent last change and move cursor to end of change
nnoremap =. :normal! =````<CR>
" }}}


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

" Startify {{{
let g:startify_change_to_dir=0
let g:startify_change_to_vcs_root=1
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

" Identify syntax group at current cursor position {{{
" Thanks: http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
