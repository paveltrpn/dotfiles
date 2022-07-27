
-- trash_opt.lua - bunch of unused or broken neovim
-- settings and snippets


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

-- Require 'ibhagwan/fzf-lua'
-- Map fuzzy finder plugint to ctrl-p (like VSCode)
-- vim.api.nvim_set_keymap('n', '<c-P>',
--    "<cmd>lua require('fzf-lua').files({ cwd = '~/' })<CR>",
--    { noremap = true, silent = true })

-- Supress neovim builtin lsp and vim-go autocomplete preview window
vim.cmd([[
    set completeopt-=preview
]])
