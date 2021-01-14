if has("autocmd")
augroup netrw_bepo_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_bepo()
augroup END
function! Fix_netrw_maps_for_bepo()
    noremap <buffer> t j
    noremap <buffer> s k
    noremap <buffer> k s
endfunction
endif
