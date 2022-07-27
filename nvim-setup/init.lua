
-- ============================= ---
-- === Basic options section === ---
-- ============================= ---

-- Enable mouse. set mouse = - for disable
vim.opt.mouse = "a"
-- String numbers
vim.opt.number = true

vim.opt.shell = "sh"

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

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd([[
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
]])
-- ======================= ---
-- === Keymaps section === ---
-- ======================= ---

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Highlight line under cursor
vim.o.cursorline = true
-- Toggle highlight line under cursor by <leader>h
map("n", "<Leader>h", ":set cursorline!<CR>")

-- Map to close quickfix window - <leader>q
vim.cmd([[
nnoremap <leader>q :cclose<CR>
]])

-- Map to deselect word selected by shift-8 (or shift-*)
vim.cmd([[
nnoremap <leader>8 :nohlsearch<CR>
]])

--- ================================ ---
--- === Plugins fetching section === ---
--- ================================ ---

-- Uncomment next sentence if packer plugins fetch in 
-- seperate script, e.g. ~/.config/nvim/lua/plugins.lua
-- require("plugins")

local use = require('packer').use
require('packer').startup(function()
  -- Packer package manager
  use 'wbthomason/packer.nvim' 

  -- Color theme
  use 'folke/tokyonight.nvim'

  -- Status line written in lua
  use 'feline-nvim/feline.nvim'

  -- Tabbar plugin
  use 'romgrk/barbar.nvim'

  -- Plugin for autocomplete braces. This one works with LUA.
  use 'windwp/nvim-autopairs'
  
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
   -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Fuzzy finder plugin
  -- I use this instead of 'ibhagwan/fzf-lua'  
  -- despite of it's vim script plugin
  -- use 'junegunn/fzf'
  
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- Smooth scrolling plugin.
  -- Scroll by ctrl-f, ctrl-b, ctrl-e, ctrl-y
  use 'karb94/neoscroll.nvim'

  use 'lewis6991/gitsigns.nvim'

  -- Neovim tree-sitter support plugin
  use {
        'nvim-treesitter/nvim-treesitter',
         run = ':TSUpdate'
  }

  -- Neovim built-in LSP support plugin
  use 'neovim/nvim-lspconfig'

  -- Autocomplition engine
  -- for work need do this:
  -- sudo apt-get install python3-venv
  -- :COQdeps
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'

end)

--- ============================= ---
--- === Plugins setup section === ---
--- ============================= ---

-- Require 'folke/tokyonight.nvim'
vim.cmd[[colorscheme tokyonight]]

-- Require 'karb94/neoscroll.nvim'
require('neoscroll').setup()

-- use 'nvim-treesitter/nvim-treesitter',
require "treesitter"

require "t-scope"
vim.cmd([[
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
]])

require "nvim-lspconfig"

-- use 'ms-jpq/coq_nvim'
-- Config autostart
vim.cmd([[
let g:coq_settings = { 'auto_start': 'shut-up' }
]])
-- Cunfig to use with gopls
local lsp = require "lspconfig"
local coq = require "coq" -- add this
lsp.gopls.setup(coq.lsp_ensure_capabilities()) -- after

require "gitsigns-nvim"

require("nvim-autopairs").setup{}

require('feline').setup()

-- use 'kyazdani42/nvim-tree',
require "tree"
