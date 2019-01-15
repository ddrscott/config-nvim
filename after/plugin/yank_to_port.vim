" Overview:
" This is to make working between remote hosts and local easier.
" 
" On local startup the following:
" 
"     while true; do nc -l -p 6666 | tee /dev/tty > /dev/clipboard; done
" 
" Then SSH to the remote with:
" 
"     ssh -R 6666:localhost:6666 user@remote_host
" 
" When `remote_host` is running this plugin, data yanked will be sent to
" the local's `/dev/clipboard`.
" 
" Config:
" Set the global in your Vimrc to change the default target program:
" 
"     let g:yank_to_port_prg = 'nc localhost 6666'
" 
" If nothing is listening on the port the `TextYankPost` autocmd is
" removed after the first call and an `echom` is printed.
" 
" Disable: X11 Clipboard fowarding "Just Works"
" No need for this anymore
finish

" Set default program
if !exists('g:yank_to_port_prg')
  let g:yank_to_port_prg = 'nc localhost 6666'
endif

" Send to nc
" This must be on a timer or @" won't be populated, yet
function! yank_to_port#send(...) abort
  call system(g:yank_to_port_prg, @")
  if v:shell_error != 0
    echom 'Disabling Yank to Port: `' . g:yank_to_port_prg . '` returned status => ' . v:shell_error
    augroup yank_to_port
      au!
    augroup END
  endif
endfunction

augroup yank_to_port
  au!
  au TextYankPost * call timer_start(10, "yank_to_port#send")
augroup END
