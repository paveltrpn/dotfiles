""" ============================== ---
""" === Common options section === ---
""" ============================== ---

" Enable mouse. set mouse = - for disable
set mouse=a

set shell=sh
set t_Co=256

" Syntax highlights, colors, appearence
syntax on
colorscheme darkblue
set background=dark

" String numbers
set number
" Don't wrap string
set nowrap
" But wrap lines in preview window
autocmd BufEnter * if &previewwindow | set wrap | endif
" Disable vim to create swapfile fo edited files
set noswapfile

" set cursorline only under line numbers
" hi CursorLineNr guifg=#af00af
set cursorline
" set cursorlineopt=number

" Autoindent)
set autoindent

" We don't need to see things like -- INSERT -- anymore 
" set noshowmode

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs
set tabstop=4
set softtabstop=0
set shiftwidth=4           
set expandtab

set ruler

" Enable line highlighting when insert mode on
":autocmd InsertEnter * set cul
":autocmd InsertLeave * set nocul

" Change cursor style depend which mode are we in
" necessary in vim
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Useful to faster update gitgutter plugin show bar with changes
set updatetime=200

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Hide tilde symbol that indicates empty lines in vim beffer.
" It replace with blank space, in the end of next line space
" symbol was next to backslash symbol
set fillchars+=eob:\ 

" Set for highlight search word
set hlsearch

" NETRW file explorer settings (native vim explorer)
" call by :Explore command
let g:netrw_banner = 0
" Tree instead a split view
let g:netrw_liststyle = 3
" Open file in new tab
let g:netrwabrowse_split = 3

" Ask t oclose unsaved buffer instead of throw error
set confirm

" Show tabs as >---
" set list
" set listchars=tab:>-

let g:netrw_winsize = 35

""" ============================== ---
""" === Common keymaps section === ---
""" ============================== ---

" Map to deselect word selected by shift-8 (or shift-*)
nnoremap <leader>8 :nohlsearch<CR>

" buffers switch and list all
noremap <leader>bl :ls<CR>
noremap <leader>bp :bprev<CR>
noremap <leader>bn :bnext<CR>

" tabs switch and close current
noremap <leader>tn :tabn<CR>
noremap <leader>tp :tabp<CR>
noremap <leader>tc :tabc<CR>

noremap <leader>ee :Lexplore<CR>

