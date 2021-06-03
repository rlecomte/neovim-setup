call plug#begin('~/.config/nvim/cache-plug/')

" plugins
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'itchyny/lightline.vim'
"Plug 'ap/vim-buftabline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lifepillar/vim-gruvbox8'
Plug 'airblade/vim-gitgutter'
"Plug 'prettier/vim-prettier', { 'do': 'npm install' }
"Plug 'sdiehl/vim-ormolu'
Plug 'easymotion/vim-easymotion'
" Initialize plugin system
call plug#end()

" general
set nocompatible
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set autoread
set hidden
set autoread
set hidden
set updatetime=400

" interface
set laststatus=2
set ruler
set wildmenu
set cursorline
set number
set relativenumber
set mouse=a
set title

" indentation
filetype plugin indent on
set autoindent
set expandtab     "Always uses spaces instead of tabs
set nowrap
set tabstop=4     "A tab is 4 spaces
set softtabstop=2 "Insert 4 spaces when tab is pressed
set shiftwidth=2  "An indent is 4 spaces

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" text
set fileencoding=utf-8
set linebreak
set scrolloff=3
set sidescrolloff=5
syntax enable

" miscellaneous
set confirm
set nomodeline
set nrformats-=octal
"set shell
"set spell

"copy to clipboard (+y)
set clipboard+=unnamedplus
set termguicolors
set t_Co=256

set tags=tags;

" remap escape edit mode
"inoremap <esc> <nop>
inoremap ^ <esc>
inoremap   <Space>

let mapleader = ","
map <Leader> <Plug>(easymotion-prefix)

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
let g:netrw_banner = 0
augroup ProjectDrawer
  autocmd!
  "map <C-f> :NERDTreeToggle<CR>
  "nmap <C-e> :CocCommand explorer<CR>
  nmap <C-e> :Ex <CR>
augroup END

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd FileType javascript setlocal ts=2 sw=2
autocmd FileType json setlocal ts=2 sw=2
autocmd FileType yaml setlocal ts=2 sw=2
autocmd FileType sql setlocal ts=2 sw=2

autocmd BufWritePre * %s/\s\+$//e
