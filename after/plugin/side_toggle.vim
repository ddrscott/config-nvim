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
