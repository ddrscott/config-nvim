augroup dotvimrc
  au!
  let dotfile = fnamemodify('./.vimrc', ':p')
  if filereadable(dotfile)
    echom "sourcing: " . dotfile
    execute "source " . dotfile
  endif
augroup END
