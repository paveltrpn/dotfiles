-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
    {
        spec = {
            -- Add plugin - Colorscheme
            {
                "sainnhe/everforest",
                init = function()
                    vim.cmd(
                        [[
                set termguicolors
                set background=dark
                let g:everforest_background = 'hard'
                let g:everforest_colors_override = {  'bg0': ['#0c0c0c', '235'],
                                                    \ 'bg1': ['#232024', '236'],
                                                    \ 'bg2': ['#2b282c', '237'],
                                                    \ 'yellow': ['#efcf91', '214'],
                                                    \ 'green': ['#b1d975', '142'],
                                                    \ 'red' : ['#fa575a', '167']}
                colorscheme everforest
                ]]
                    )
                end
            },
            --{"folke/tokyonight.nvim"},
            --{"sainnhe/sonokai"},
            --{"Shatur/neovim-ayu"},
            --{"rebelot/kanagawa.nvim"},
            --{"ayu-theme/ayu-vim"},
            --{"ellisonleao/gruvbox.nvim"},

            -- Add plugin - Fuzzy finder plugin
            -- I use this instead of 'ibhagwan/fzf-lua'
            -- despite of it's vim script plugin
            -- :FZF      - for fuzzy search
            -- :Rg <str> - for ripgrep
            {
                "junegunn/fzf",
                init = function()
                    vim.g.fzf_buffers_jump = 1
                end
            },
            -- Add plugins trought plugins/*.lua files
            {
                import = "plugins"
            }
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {colorscheme = {"habamax"}},
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)

