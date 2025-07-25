-- ============================= ---
-- === Basic options section === ---
-- ============================= ---

-- font config for neovide gui client
-- set to Hack because of Fira Code not working here...
-- vim.o.guifont = "monospace:h10"
-- vim.o.guifont = "Source Code Pro:h10"
-- vim.o.guifont = "IBM Plex Mono:h10"
vim.o.guifont = "Fira Code Medium:h8.5"

-- Enable mouse. set mouse = - for disable
vim.opt.mouse = "a"
-- String numbers
vim.opt.number = true

vim.opt.shell = "bash"

-- Fix backspace indent
vim.opt.backspace = "indent,eol,start"

-- Hide tilde symbol that indicates empty lines in vim beffer.
-- It replace with blank space, in the end of next line space
-- symbol was next to backslash symbol
vim.opt.fillchars = "eob: "

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

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

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- undo reopened files
vim.opt.undofile = true

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.cmd(
    [[
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
]]
)

vim.cmd([[
set clipboard+=unnamedplus
]])


--- NETRW file explorer settings (native vim file explorer)
--- call by :Explore command
vim.g.netrw_banner = 0
--- Tree instead a split view
vim.g.netrw_liststyle = 3
--- Open file in new tab
vim.g.netrw_browse_split = 3

-- Ask t oclose unsaved buffer instead of throw error
vim.opt.confirm = true

-- Show hidden chars
--vim.opt.list = true
----vim.opt.listchars = {eol = "¬"}
--vim.opt.listchars = {eol = "⏎", trail = "×", tab = ">·", nbsp = "⎵"}
----vim.opt.listchars = {space = "¬"}

-- Move newborn quickfix window to bottomest place.
-- This trigger takes advantage of the fact that the quickfix window
-- can be easily distinguished by its file-type, qf. The wincmd J command
-- is equivalent to the [Ctrl+W, Shift+J] shortcut sequence
-- instructing Vim to move the current window to the very bottom of the screen
vim.cmd([[
:autocmd FileType qf wincmd J
]])

-- ======================= ---
-- === Keymaps section === ---
-- ======================= ---

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Highlight line under cursor
vim.o.cursorline = true
vim.o.cursorcolumn = true

-- Toggle highlight line under cursor by <leader>h
map("n", "<Leader>h", ":set cursorline!<CR>")

-- Map to deselect word selected by shift-8 (or shift-*)
map("n", "<leader>8", ":nohlsearch<CR>")

-- buffers switch and list all
vim.cmd([[
:noremap <leader>bl :ls<CR>
:noremap <leader>bp :bprev<CR>
:noremap <leader>bn :bnext<CR>
]])

-- tabs switch and close current
vim.cmd(
    [[
:noremap <leader>to :tabnew<CR>
:noremap <leader>tn :tabn<CR>
:noremap <leader>tp :tabp<CR>
:noremap <leader>tc :tabc<CR>
]]
)

-- disable ctrl-z!!! in normal mode it immidiately
-- close nvim
vim.cmd([[
nnoremap <c-z> <nop>
]])

-- Shortcuts to toggle vim explorer on far left pan
map("n", "<leader>ee", ":Lexplore<CR>")
-- Explorer pan size
vim.g.netrw_winsize = 20

-- Map to close quickfix window
map("n", "<leader>qq", ":cclose<CR>")

-- Map to select quickfix window
map("n", "<leader>qs", ":copen<CR>")
-- Quickfix next and prev elements
map("n", "<leader>qn", ":cnext<CR>")
map("n", "<leader>qp", ":cprev<CR>")

-- Mappings fo vim diagnostics (for compile errors etc.)
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

--- ================================ ---
--- === Plugins fetching section === ---
--- ================================ ---

require("config.lazy")

-- ============================= ---
-- === Plugins setup section === ---
-- ============================= ---

-- Plugin theme 'folke/tokyonight.nvim'
-- vim.g.tokyonight_italic_comments = false
-- vim.g.tokyonight_italic_keywords = false
-- vim.cmd[[colorscheme tokyonight-day]]
-- vim.cmd[[colorscheme tokyonight-moon]]
-- vim.cmd[[colorscheme tokyonight-storm]]
-- vim.cmd[[colorscheme tokyonight-night]]

-- Plugin theme kanagawa
--require('kanagawa').setup({
--    compile = false,             -- enable compiling the colorscheme
--    undercurl = true,            -- enable undercurls
--    commentStyle = { italic = false },
--    functionStyle = {},
--    keywordStyle = { italic = false},
--    statementStyle = { bold = true },
--    typeStyle = {},
--    transparent = false,         -- do not set background color
--    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--    colors = {                   -- add/modify theme and palette colors
--        palette = {},
--        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--    },
--    overrides = function(colors) -- add/modify highlights
--        return {}
--    end,
--    --theme = "wave",              -- Load "wave" theme when 'background' option is not set
--    --background = {               -- map the value of 'background' option to a theme
--    --    dark = "wave",           -- try "dragon" !
--    --    light = "lotus"
--    --},
--})
--require("kanagawa").load("dragon") -- night style
--require("kanagawa").load("lotus") -- day style
--require("kanagawa").load("wave")

-- Plugin theme 'sainnhe/sonokai'
--vim.cmd([[
--set termguicolors
--let g:sonokai_style = 'shusia'
--let g:sonokai_better_performance = 1
--let g:sonokai_colors_override = {'bg0': ['#1e1b1f', '235'], 'bg1': ['#232024', '236'], 'bg2': ['#2b282c', '236']}
--colorscheme sonokai
--]])

-- Plugin theme 'Shatur/neovim-ayu'
-- require('ayu').setup({
--     mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
--     overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
-- })
-- require('ayu').colorscheme()

-- vim.cmd([[ set termguicolors ]])
-- vim.cmd([[ let ayucolor="dark"]])
-- vim.cmd([[ colorscheme ayu]])

--vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox]])

-- Plugin fuzzyfinder 'junegunn/fzf'
-- if file already opened, show it's buffer

