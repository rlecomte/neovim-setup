" ~~~~~~~~~~~~~ tips ~~~~~~~~~~~~~~~~~~~
augroup pythontips
    au BufRead,BufNewFile *.py setfiletype python
    autocmd BufWritePre *.py :%s/\s\+$//e
augroup END

let g:jedi#popup_on_dot = 0
