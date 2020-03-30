" [Tags] Command to generate tags file
"let g:fzf_tags_command = 'fast-tags -R .'

" ~~~~~~~~~~~~~~ haskell-vim ~~~~~~~~~~~~~~
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" ~~~~~~~~~~~~~ tips ~~~~~~~~~~~~~~~~~~~
" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

augroup haskelltips
    au BufRead,BufNewFile *.hs setfiletype haskell
    au FileType haskell :iabbrev <buffer> STV {-# LANGUAGE ScopedTypeVariables #-}
    au FileType haskell :iabbrev <buffer> RNT {-# LANGUAGE RankNTypes #-}
    "highlight
    autocmd BufWritePre *.hs :%s/\s\+$//e
    set list listchars=trail:.,extends:>
    nmap <C-k> :call TrimWhiteSpace()<CR>
augroup END
