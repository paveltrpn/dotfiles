
-- Enable mouse. set mouse = - for disable
vim.opt.mouse = "a"
-- String numbers
vim.opt.number = true

vim.opt.shell = "sh"

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Fix backspace indent
--vim.opt.backspace = indent,eol,start
vim.cmd([[
set backspace=indent,eol,start
]])

-- Hide tilde symbol that indicates empty lines in vim beffer.
-- It replace with blank space, in the end of next line space
-- symbol was next to backslash symbol
vim.cmd([[
set fillchars+=eob:\ 
]])

-- Map to close quickfix window - <leader>q
vim.cmd([[
nnoremap <leader>q :cclose<CR>
]])

-- Map to deselect word selected by shift-8 (or shift-*)
vim.cmd([[
nnoremap <leader>8 :nohlsearch<CR>
]])

-- The following mappings a quick way to move lines of text up or down. 
-- The mappings work in normal, insert and visual 
-- modes, allowing you to move the current line, or a selected block of lines. 
vim.cmd([[
nnoremap <A-down> :m .+1<CR>==
nnoremap <A-up> :m .-2<CR>==
inoremap <A-down> <Esc>:m .+1<CR>==gi
inoremap <A-up> <Esc>:m .-2<CR>==gi
vnoremap <A-down> :m '>+1<CR>gv=gv
vnoremap <A-up> :m '<-2<CR>gv=gv
]])

-- Highlight line under cursor
vim.o.cursorline = true
-- Toggle highlight line under cursor by <leader>h
map("n", "<Leader>h", ":set cursorline!<CR>")

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4

-- Syntax highlights
vim.opt.syntax = "on"
-- String numbers
vim.opt.number = true
-- Don't wrap string
vim.opt.wrap = false
-- Disable vim to create swapfile fo edited files
vim.opt.swapfile = false

vim.opt.autoindent = true

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"

vim.opt.expandtab = true
vim.opt.ruler = true

-- Useful to faster update gitgutter plugin show bar with changes
vim.opt.updatetime = 500

--require("plugins")

local use = require('packer').use
require('packer').startup(function()
  -- Packer package manager
  use 'wbthomason/packer.nvim' 

  -- Color theme
  use 'folke/tokyonight.nvim'

  use 'feline-nvim/feline.nvim'

  -- Plugin for autocomplete braces. This one works with LUA.
  -- Must be enabled by some sofisticated method listed below.
  use 'windwp/nvim-autopairs'
  
  -- Fuzzy finder plugin
  use 'ibhagwan/fzf-lua'

  -- Smooth scrolling plugin.
  -- Scroll by ctrl-f, ctrl-b, ctrl-e, ctrl-y
  use 'karb94/neoscroll.nvim'

  -- Neovim tree-sitter support plugin
  use {
        'nvim-treesitter/nvim-treesitter',
         run = ':TSUpdate'
  }

  -- Neovim built-in LSP support plugin
  use 'neovim/nvim-lspconfig' 

end)

-- Require tokyonight theme
vim.cmd[[colorscheme tokyonight]]

-- Require fzf-lua.
-- Map fuzzy finder plugint to ctrl-p (like VSCode)
vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files({ cwd = '~/' })<CR>",
    { noremap = true, silent = true })

-- Require 'karb94/neoscroll.nvim'
require('neoscroll').setup()

-- Require 'nvim-treesitter/nvim-treesitter'
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

-- NEOVIM LSP DEFAULT CONFIG --
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

-- Supress neovim builtin lsp and vim-go autocomplete preview window
vim.cmd([[
    set completeopt-=preview
]])

require("nvim-autopairs").setup {}
require('feline').setup()

