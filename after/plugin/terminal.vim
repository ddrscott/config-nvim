if !exists(':term')
  finish
endif

if executable('zsh')
  set shell=zsh
endif

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
tnoremap <Esc><Esc> <C-\><C-n>
" tnoremap gf :pedit <cfile><cr>
augroup neovim_stuff
  au!
  autocmd BufWinEnter,WinEnter term://*
        \ setlocal nonumber norelativenumber signcolumn=no

  autocmd TermOpen * startinsert |
        \ setlocal nonumber norelativenumber signcolumn=no
augroup END

function! TermGf()
  if &buftype ==# "terminal"
    :vertical pedit <cfile>
  else
    normal! gf
  endif
endfunction
nnoremap gf :call TermGf()<CR>

command! -complete=file -nargs=+ Vterm vnew | setlocal winfixwidth winfixheight | terminal <args>
command! -complete=file -nargs=+ Sterm new | setlocal winfixwidth winfixheight | terminal <args>
nnoremap <Leader>tv :vnew <BAR>setlocal winfixwidth winfixheight <BAR> terminal<SPACE>
nnoremap <Leader>ts :new <BAR>setlocal winfixwidth winfixheight <BAR> terminal<SPACE>
