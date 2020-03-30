set rtp+=~/.fzf/

nmap <C-s> :Tags<CR>
nmap <C-p> :GFiles<CR>

" Search current word in tags
nmap <C-c> :call fzf#vim#tags(expand('<cword>'))<CR>
