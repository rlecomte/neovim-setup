set statusline+=%{gutentags#statusline()}

augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

let g:gutentags_project_info = []
call add(g:gutentags_project_info, {'type': 'scala', 'file': 'build.sbt'})
let g:gutentags_ctags_executable_scala = 'stags --output tags.temp .'
