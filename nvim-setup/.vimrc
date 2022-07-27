
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
" Disable vim to create swapfile fo edited files
set noswapfile

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

"" Tabs. May be overridden by autocmd rules
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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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
let g:netrw_browse_split = 3
""" ============================== ---
""" === Common keymaps section === ---
""" ============================== ---

" Toggle highlight line under cursor by <leader>h
nnoremap <Leader>h :set cursorline!<CR>

"" Map to close quickfix window - <leader>q
nnoremap <leader>q :cclose<CR>

"" Map to deselect word selected by shift-8 (or shift-*)
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

" File explorer
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Nice color theme
  "Plug 'safv12/andromeda.vim'
  Plug 'ghifarit53/tokyonight-vim'

" Fuzzy finder plugin. Need to do sudo apt-get install fzf, before use
  Plug 'junegunn/fzf'

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

"" Plug 'safv12/andromeda.vim'
"colorscheme andromeda

"" Plug 'preservim/nerdcommenter'
" Set default gap between comment and text
let g:NERDSpaceDelims = 2

"" Plug 'ghifarit53/tokyonight-vim'
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
colorscheme tokyonight


"" Plug 'preservim/nerdtree'
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 20
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
" Start NERDTree and leave the cursor in it.
" autocmd VimEnter * NERDTree ~/code

" \b to call NERDTree 
nnoremap <leader>b :NERDTreeToggle ~/code<CR>


"" Plug 'vim-airline/vim-airline'
set showtabline=2
let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_sep='|'
"let g:airline#extensions#tabline#left_alt_sep='|'
"let g:airline#extensions#tabline#right_sep='|'
"let g:airline#extensions#tabline#right_alt_sep='|'
let g:airline_theme = "tokyonight" " If plugged!


"" Plug 'airblade/vim-gitgutter'
" Set gitgutter signcolumn color to background.
highlight clear SignColumn


"" Plug 'fatih/vim-go'
" Golang vim-go plugin hightlights options
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1

" Show identifier info in status bar
let g:go_auto_type_info = 1

let g:go_doc_popup_window = 1
let g:go_metlainter_command = "staticcheck"
" May be set to gofmt instead, beacuse of some people claims
" that goimports may take long time for work.
let g:go_fmt_command = "goimports" 
" Some vim-go remaps for easy invoke `go vet`, `gofmt`,`staticcheck`
" and `go-doc. Remaping works with \v, \f, \l and \d respectively
autocmd FileType go nnoremap <leader>f :GoFmt<CR>
autocmd FileType go nnoremap <leader>l :GoMetaLinter<CR>
autocmd FileType go nnoremap <leader>d :GoDoc<CR>
" go vet can be replaced with statickcheck
" autocmd FileType go nnoremap <leader>v :GoVet!<CR>
"
" Supress vim-go autocomplete preview window
set completeopt-=preview

" Autoclose vim-go autocomplete preview window when
" close autocomplete popup hover window
augroup completion_preview_close
  autocmd!
  autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | augroup END

" Automatically call vim-go autocomplete dialog
" Not very useful.
" au filetype go inoremap <buffer> . .<C-x><C-o>

" Remap default vim-go ctrl-x + ctrl-o autocomplete to alt-x
" Not work in Vim 9.0
" autocmd FileType go inoremap <A-x> <C-x><C-o>
