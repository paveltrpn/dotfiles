
require("nvim-tree").setup({
    filters = {
        dotfiles = true,
    },

    view = {
        width = 24,
    },

    git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
    },
})

-- Remap \b to call NvimTree 
vim.cmd([[
    nnoremap <leader>b :NvimTreeToggle ~/code<CR>
]])
