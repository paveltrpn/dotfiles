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
" Toggle highlight line under cursor by <leader>h
nnoremap <Leader>h :set cursorline!<CR>

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4

set expandtab
set ruler

" Useful to faster update gitgutter plugin show bar with changes
set updatetime=500

call plug#begin()
" Golang vim plugin
  Plug 'fatih/vim-go'

" Funny icons fo NERDTree and some other plugins. Patched nerd fonts need for work.
  Plug 'ryanoasis/vim-devicons'

" File explorer
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Fuzzy finder plugin. Need to do sudo apt-get install fzf, before use
  Plug 'junegunn/fzf'

" Find text in files. Searches through whole directory. Very fast.
" Required sudo apt-get install silversearcher-ag for work and set
" to silversearcher-ag as main finding tool.
" May use 'epmatsw/ag.vim' instead of these guy, but it repo 
" mark as deprecated.
  Plug 'mileszs/ack.vim'

" Status bar and tabsline improvement plugin
  Plug 'vim-airline/vim-airline'

" Nice color theme
  Plug 'safv12/andromeda.vim'

" Plugin for autocomplete braces. 
  Plug 'raimondi/delimitmate'

" Multiline selection plugin
  Plug 'mg979/vim-visual-multi'

" Easy comment line plugin. <leader>cc and <leader>c-space in normal mode for using.
  Plug 'preservim/nerdcommenter'

" Very nice plugin for smooth page scrolling by ctrl-u, ctrl-d, shuft-up, shift-down
  Plug 'psliwka/vim-smoothie'

" Show changes in files accordig git.
  Plug 'airblade/vim-gitgutter'

  Plug 'nvim-treesitter/nvim-treesitter'
  
  Plug 'neovim/nvim-lspconfig'

  " Plugin for autocomplete braces. This one works with LUA.
  " Must be enabled by some sofisticated method listed below.
  " Plug 'windwp/nvim-autopairs'

  " Plugin for showing tags (functions, variables an so on) in source file.
  " Currently commented because of when it plug with vim-go it cause strange
  " bug - when you try to use ctrl-] (go to definition) vim-go show this error
  " message - vim-go: could not find 'gotags'
  " Plug 'majutsushi/tagbar'
  "
  " Make tabs little prettier. Also show opened (but may be hidden) buffers.
  " I found that vim-airline can make same things.
  " Plug 'romgrk/barbar.nvim'
  "
  "
  " Autocomplete plugin. Very complex node.js plugin with many features,
  " many languages support and so on. I prefer to use vim-go instead of it by now.
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Setup ack.vim to use the_silver_searcher (ag) by default.
let g:ackprg = 'ag --nogroup --nocolor --column'

" Open a neovim with window splitted by two parts
" autocmd VimEnter * :vsplit

set background=dark
colorscheme andromeda

" Hide tilde symbol that indicates empty lines in vim beffer.
" It replace with blank space, in the end of next line space
" symbol was next to backslash symbol
set fillchars+=eob:\ 

" Map to close quickfix window - <leader>q
nnoremap <leader>q :cclose<CR>

" vim-airline plugin setup
set showtabline=2
let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_sep='|'
"let g:airline#extensions#tabline#left_alt_sep='|'
"let g:airline#extensions#tabline#right_sep='|'
"let g:airline#extensions#tabline#right_alt_sep='|'

"" NERDTree configuration
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
      
" Remap fo Tagbar, not always useful, maybe better call :TagbarToggle
" directly at first time.
" Uncomment this when you fix bug with tagbar and vim-go simulteineus
" usage!
" nnoremap <leader>t :TagbarToggle<CR>

" Force to work 'windwp/nvim-autopairs'
"lua << EOF
"require("nvim-autopairs").setup {}
"EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
require'lspconfig'.gopls.setup{}
EOF

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

" Show identifier info in status bar
let g:go_auto_type_info = 1

let g:go_doc_popup_window = 1
let g:go_metlinter_command = "staticcheck"
" Some vim-go remaps for easy invoke `go vet`, `gofmt`,`staticcheck`
" and `go-doc. Remaping works with \v, \f, \l and \d respectively
autocmd FileType go nnoremap <leader>v :GoVet!<CR>
autocmd FileType go nnoremap <leader>f :GoFmt<CR>
autocmd FileType go nnoremap <leader>l :GoMetaLinter<CR>
autocmd FileType go nnoremap <leader>d :GoDoc<CR>

" Supress vim-go autocomplete preview window
set completeopt-=preview

" Autoclose vim-go autocomplete preview window when
" close autocomplete popup hover window
augroup completion_preview_close
  autocmd!
  autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | augroup END

" Automatically call vim-go autocomplete dialog
" au filetype go inoremap <buffer> . .<C-x><C-o>

" Remap default vim-go ctrl-x + ctrl-o autocomplete to alt-x
autocmd FileType go inoremap <A-x> <C-x><C-o>

" Some remaps fo vim-visual-multi
" Disable dafault mappings, for C-Up/Down cursor selection off
let g:VM_default_mappings = 0
" Define new map - needed for strings below
let g:VM_maps = {}
" Map cursor selection for Shift-Ctrl-Up/Down, VSCode style multicursor
let g:VM_maps["Select Cursor Down"] = '<S-C-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<S-C-Up>'        " start selecting up

" Map to deselect word selected by shift-8 (or shift-*)
nnoremap <leader>8 :nohlsearch<CR>

" The following mappings a quick way to move lines of text up or down. 
" The mappings work in normal, insert and visual 
" modes, allowing you to move the current line, or a selected block of lines. 
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv

" Some barbar tab manager plugin options
" NOTE: If barbar's option dict isn't created yet, create it
"let bufferline = get(g:, 'bufferline', {})
" Tell barbar don't search devicons plugin
"let bufferline.icons = v:false

" Set gitgutter signcolumn color to background.
highlight clear SignColumn

