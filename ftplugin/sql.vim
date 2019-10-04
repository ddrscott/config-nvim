setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=120
setlocal expandtab
setlocal autoindent
setlocal smartindent
setlocal smarttab

if executable('sqlformat') == 1
  setlocal formatprg=sqlformat\ -k\ upper\ -i\ lower\ --reindent_aligned\ -
endif
