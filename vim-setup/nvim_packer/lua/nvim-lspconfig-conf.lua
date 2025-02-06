
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

util = require "lspconfig/util"

-- golang
require'lspconfig'.gopls.setup {
    on_attach = on_attach,
    flags = lsp_flags,

    cmd = {'gopls'},
    -- filetypes = {"go", "gomod"},
    -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	-- for postfix snippets and analyzers
	capabilities = capabilities,
	    settings = {
	      gopls = {
		      experimentalPostfixCompletions = true,
		      analyses = {
		        unusedparams = true,
		        shadow = true,
		     },
		     staticcheck = true,
		    },
	    },
}

-- python
require'lspconfig'.pyright.setup {
   on_attach = on_attach,
   flags = lsp_flags,
   -- filetypes = {'python'}
}

-- typescript
require 'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  }
}

-- zig language server
require 'lspconfig'.zls.setup = {
  default_config = {
    cmd = {"/mnt/main_disk/zig/zls"};
    filetypes = {"zig"};
    root_dir = util.root_pattern("build.zig", ".git");
  };
  docs = {
    description = [[ ]];
    default_config = {
      root_dir = [[root_pattern("build.zig", ".git")]];
    };
  };
}

-- clangd downloaded from https://github.com/clangd/clangd/releases/tag/15.0.1
-- place symlink from ../bin/clangd to /usr/local/bin/
-- or build whole llvm clang from source!
require'lspconfig'.clangd.setup {
   on_attach = on_attach,
   flags = lsp_flags,
   defalt_config = {
       cmd = {
            "clangd", "--clang-format", "--background-index", "--pch-storage=memory",
            "--clang-tidy", "--suggest-missing-includes"
        },
        filetypes = {"c", "cpp", "objc", "objcpp"},
        init_option = {
            fallbackFlags = {"-std=c++20"}
        }
    }
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

