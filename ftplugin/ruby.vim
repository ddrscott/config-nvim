let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_use_bundler = 1
let g:ruby_indent_assignment_style = 'variable'

let g:ruby_heredoc_syntax_filetypes = {
        \ "markdown" : {
        \   "start" : "DOC",
        \},
  \}

setlocal tags=gem.tags,tags;
setlocal makeprg=bundle\ exec\ rubocop\ --format\ emacs\ %
setlocal formatprg=bundle\ exec\ rubocop\ -a\ --stdin\ %\ \|sed\ '1,/====================/d'
