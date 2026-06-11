"" visual settings
syntax on
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
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==

vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"" theme :p

set termguicolors

"" theme :p
set termguicolors

function! ApplyKanagawaInline()
    highlight Normal       guifg=#dcd7ba guibg=NONE ctermfg=187 ctermbg=NONE
    highlight Comment      guifg=#727169 gui=italic ctermfg=242 cterm=italic
    highlight Constant     guifg=#ffa066 guibg=NONE ctermfg=215
    highlight String       guifg=#98bb6c guibg=NONE ctermfg=107
    highlight Identifier   guifg=#e6c384 guibg=NONE ctermfg=180
    highlight Function     guifg=#7e9cd8 guibg=NONE ctermfg=110
    highlight Statement    guifg=#957fb8 gui=bold ctermfg=103 cterm=bold
    highlight PreProc      guifg=#e46876 guibg=NONE ctermfg=167
    highlight Type         guifg=#7aa89f gui=NONE ctermfg=109
    highlight Special      guifg=#b8b4d0 guibg=NONE ctermfg=146
    highlight Underlined   guifg=#7e9cd8 gui=underline ctermfg=110
    highlight Error        guifg=#c3404b guibg=NONE gui=bold ctermfg=131
    highlight Todo         guifg=#1f1f28 guibg=#98bb6c gui=bold ctermfg=234 ctermbg=107

    highlight LineNr       guifg=#54546d guibg=NONE ctermfg=239 ctermbg=NONE
    highlight CursorLineNr guifg=#ff9e3b guibg=NONE gui=bold ctermfg=215 ctermbg=NONE
    highlight Visual       guifg=NONE    guibg=#2d4f67 ctermbg=24
    highlight Search       guifg=#1f1f28 guibg=#e6c384 ctermfg=234 ctermbg=180
    highlight IncSearch    guifg=#1f1f28 guibg=#ff9e3b ctermfg=234 ctermbg=215
    highlight VertSplit    guifg=#54546d guibg=NONE gui=NONE
    highlight Pmenu        guifg=#dcd7ba guibg=#223249 ctermfg=187 ctermbg=236
    highlight PmenuSel     guifg=#1f1f28 guibg=#2d4f67 ctermfg=234 ctermbg=24

    highlight EndOfBuffer  guifg=#54546d guibg=NONE ctermfg=239 ctermbg=NONE
    highlight SignColumn   guibg=NONE    ctermbg=NONE
endfunction

augroup KanagawaTransparent
    autocmd!
    autocmd ColorScheme,VimEnter * call ApplyKanagawaInline()
augroup END

colorscheme default
let g:colors_name = "kanagawa-inline"
