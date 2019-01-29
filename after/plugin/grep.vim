if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --vimgrep\ --word-regexp
        \\ --ignore='*.js.map'
        \\ --ignore='*.csv'
        \\ --ignore='ui/public/client'
        \\ --ignore='cassettes/'
endif
