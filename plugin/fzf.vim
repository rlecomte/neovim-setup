set rtp+=~/.fzf/

nmap <C-s> :Tags<CR>
nmap <C-t> :GFiles<CR>
nmap <C-d> :Rg<CR>
nmap <C-n> :History<CR>

" Search current word in tags
nmap <C-c> :call fzf#vim#tags(expand('<cword>'))<CR>
