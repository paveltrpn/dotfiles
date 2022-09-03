""" ============================== ---
""" === Common options section === ---
""" ============================== ---

" Enable mouse. set mouse = - for disable
set mouse=a

set shell=sh
set t_Co=256

" Syntax highlights
syntax on
" String numbers
set number
" Don't wrap string
set nowrap
" But wrap lines in preview window
autocmd BufEnter * if &previewwindow | set wrap | endif
" Disable vim to create swapfile fo edited files
set noswapfile

" Autoindent)
set autoindent

" We don't need to see things like -- INSERT -- anymore 
set noshowmode

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Fix backspace indent
set backspace=indent,eol,start
" Highlight line under cursor
set cursorline

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

set background=dark

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

" Move newborn quickfix window to bottomest place.
" This trigger takes advantage of the fact that the quickfix window 
" can be easily distinguished by its file-type, qf. The wincmd J command 
" is equivalent to the [Ctrl+W, Shift+J] shortcut sequence 
" instructing Vim to move the current window to the very bottom of the screen
:autocmd FileType qf wincmd J

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

""" ============================== ---
""" === Common keymaps section === ---
""" ============================== ---

" Unmap F1 from normal and visual mode
:map <F1> :echo<CR>
" Unmap F1 from insert mode (do no op)
:imap <F1> <Nop>
" Map list all buffers command
:noremap <F1> :ls<CR>
:noremap <F2> :bprev<CR>
:noremap <F3> :bnext<CR>
" Delete buffer (:bd) leader to avoid accident
:noremap <leader><F4> :bd<CR>
:noremap <F4> :echo "to delete buffer use F4 with leader"<CR>
" More dangerous version of command above
":noremap <leader><F4> :bd<CR>


" Shortcuts to open vim explorer on far left pan
nnoremap <leader>ee :Lexplore %:p:h<CR>
" Close opened Explorer window
nnoremap <Leader>eq :Lexplore<CR>
" Explorer pan size
let g:netrw_winsize = 20

" Toggle highlight line under cursor by <leader>h
nnoremap <Leader>h :set cursorline!<CR>

" Map to close quickfix window 
nnoremap <leader>qq :cclose<CR>

" Map to select quickfix window
nnoremap <leader>qs :copen<CR>
" Quickfix next and prev elements
nnoremap <leader>qn :cnext<CR>
nnoremap <leader>qp :cprev<CR>

" Map to deselect word selected by shift-8 (or shift-*)
nnoremap <leader>8 :nohlsearch<CR>

" Map traditional copy-paste bindings to global clipboard
" copy and paste
:inoremap <C-v> <ESC>"+pa
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d

""" ================================ ---
""" === Plugins fetching section === ---
""" ================================ ---

call plug#begin()
" Funny icons for NERDTree and some other plugins. Patched nerd fonts need for work.
  Plug 'ryanoasis/vim-devicons'

" Nice color theme
  "Plug 'safv12/andromeda.vim'
  Plug 'ghifarit53/tokyonight-vim'

" Fuzzy finder plugin. Need to do sudo apt-get install fzf, before use
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  
" Status bar and tabsline improvement plugin
  Plug 'vim-airline/vim-airline'

" Very nice plugin for smooth page scrolling by ctrl-u, ctrl-d, shuft-up, shift-down
  Plug 'psliwka/vim-smoothie'

" Plugin for autocomplete braces. 
  Plug 'raimondi/delimitmate'

" Easy comment line plugin. <leader>cc and <leader>c-space in normal mode for using.
  Plug 'preservim/nerdcommenter'

" Show changes in files accordig git.
  Plug 'airblade/vim-gitgutter'

" Golang vim plugin
  Plug 'fatih/vim-go'

  " Autocomplete plugin. Very complex node.js plugin with many features,
  " many languages support and so on. I prefer to use vim-go instead of it by now.
  " May be plugged whihout golang extension just for autocomplete and use
  " vim-go for golang features.
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""" ============================= ---
""" === Plugins setup section === ---
""" ============================= ---

" Plug 'safv12/andromeda.vim'
"colorscheme andromeda

" Plug 'preservim/nerdcommenter'
" Set default gap between comment and text
let g:NERDSpaceDelims = 2

" Plug 'ghifarit53/tokyonight-vim'
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
colorscheme tokyonight

" Plug 'vim-airline/vim-airline'
set showtabline=2
let g:airline#extensions#tabline#enabled=1
let g:airline_theme = "tokyonight" " If plugged!

" Plug 'airblade/vim-gitgutter'
" Set gitgutter signcolumn color to background.
highlight clear SignColumn

source ~/.vim/vim-go.vim
source ~/.vim/coc.vim

