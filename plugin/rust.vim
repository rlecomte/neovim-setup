let g:rustfmt_autosave = 1

autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
