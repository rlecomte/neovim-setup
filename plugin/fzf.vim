set rtp+=~/.fzf/

nmap <C-s> :Tags<CR>
nmap <C-t> :GFiles<CR>
nmap <C-d> :Rg<CR>
nmap <C-n> :History<CR>

" Search current word in tags
" nmap <C-c> :call fzf#vim#tags(expand('<cword>'))<CR>

" Find files using Telescope command-line sugar.
" nnoremap <C-t> <cmd>Telescope find_files<cr>
" nnoremap <C-d> <cmd>Telescope live_grep<cr>
" nnoremap <C-n> <cmd>Telescope oldfiles<cr>
" nnoremap <C-g> <cmd>Telescope git_branches<cr>
" nnoremap <C-s> <cmd>Telescope buffers<cr>

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
