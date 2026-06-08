"" visual settings
set number
set relativenumber
set mouse=a
set clipboard=unnamedplus

"" search settings
set ignorecase
set smartcase
set incsearch
set hlsearch

"" tab settings
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

"" Alt+j and Alt+k to move line
nnoremap <A-j> :m '>+1<CR>gv=gv
nnoremap <A-k> :m '<-2<CR>gv=gv

"" theme :p

set termguicolors
silent! colorscheme kanagawa
if !exists('g:colors_name')
  colorscheme desert
endif
