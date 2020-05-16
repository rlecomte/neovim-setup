call plug#begin('~/.config/nvim/cache-plug/')

" plugins
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'https://github.com/junegunn/fzf.vim.git'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/schickling/vim-bufonly'
Plug 'https://github.com/ap/vim-buftabline.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/rust-lang/rust.vim.git'
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/lifepillar/vim-gruvbox8'
Plug 'https://github.com/airblade/vim-gitgutter.git'
" Initialize plugin system
call plug#end()

syntax on
filetype plugin indent on

set updatetime=400
" show line number
set number
set fileencoding=utf-8
set noshowmode
"copy to clipboard (+y)
set clipboard+=unnamedplus
set termguicolors
set t_Co=256
" Tab specific option
set tabstop=4     "A tab is 4 spaces
set expandtab     "Always uses spaces instead of tabs
set softtabstop=2 "Insert 4 spaces when tab is pressed
set shiftwidth=4  "An indent is 4 spaces

" remap escape edit mode
inoremap <esc> <nop>
inoremap jk <esc>

" delete all buffer but this one
nmap <C-n> :Bonly<CR>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" theme
" set background=dark
colorscheme gruvbox8
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" netrw
let g:netrw_localrmdir='rm -r'
augroup ProjectDrawer
  autocmd!
  nmap <C-f> :CocCommand explorer<CR>
  "nmap <C-f> :Explore<CR>
augroup END

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd FileType javascript setlocal ts=2 sw=2
"autocmd FileType json setlocal ts=2 sw=2
"autocmd FileType yaml setlocal ts=2 sw=2
"autocmd FileType sql setlocal ts=2 sw=2
