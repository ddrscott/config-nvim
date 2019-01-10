if executable('sqlformat') == 1
  setlocal formatprg=sqlformat\ -k\ upper\ -i\ lower\ --reindent_aligned\ -
endif
