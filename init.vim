call plug#begin('~/.config/nvim/cache-plug/')

" plugins
Plug 'https://github.com/Raimondi/delimitMate.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lifepillar/vim-gruvbox8'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'sdiehl/vim-ormolu'
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
"inoremap <esc> <nop>
""inoremap ,, <esc>

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
  "map <C-f> :NERDTreeToggle<CR>
  "nmap <C-e> :CocCommand explorer<CR>
  nmap <C-e> :Explore<CR>
augroup END

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd FileType javascript setlocal ts=2 sw=2
autocmd FileType json setlocal ts=2 sw=2
autocmd FileType yaml setlocal ts=2 sw=2
autocmd FileType sql setlocal ts=2 sw=2

autocmd BufWritePre * %s/\s\+$//e

augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END
