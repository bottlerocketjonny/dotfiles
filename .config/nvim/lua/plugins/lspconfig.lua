return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        -- Install these LSPs automatically
        ensure_installed = {
          'bashls',
          'cssls',
          'html',
          'lua_ls',
          'jdtls',
          'jsonls',
          'marksman',
          'quick_lint_js',
          'yamlls',
          'pyright',
        },
      }

      require('mason-tool-installer').setup {
        -- Install these linters, formatters, debuggers automatically
        ensure_installed = {
          'java-debug-adapter',
          'java-test',
        },
      }

      -- There is an issue with mason-tools-installer running with VeryLazy, since it triggers on VimEnter which has already occurred prior to this plugin loading so we need to call install explicitly
      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
      vim.api.nvim_command 'MasonToolsInstall'

      local lspconfig = require 'lspconfig'
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lsp_attach = function(client, bufnr)
        -- Helper function for mapping keys in the LSP buffer context
        local function map(mode, lhs, rhs, desc)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = 'LSP: ' .. desc })
        end

        -- Jump to definition using Telescope
        map('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", '[G]oto [D]efinition')

        -- Find references using Telescope
        map('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", '[G]oto [R]eferences')

        -- Jump to implementation using Telescope
        map('n', 'gI', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", '[G]oto [I]mplementation')

        -- Type definition using Telescope
        map('n', '<leader>D', "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", 'Type [D]efinition')

        -- List document symbols using Telescope
        map('n', '<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", '[D]ocument [S]ymbols')

        -- List workspace symbols using Telescope
        map('n', '<leader>ws', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", '[W]orkspace [S]ymbols')

        -- Rename using built-in LSP functionality
        map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', '[R]e[n]ame')

        -- Code actions using Telescope
        map('n', '<leader>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", '[C]ode [A]ction')

        -- Hover documentation
        map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover Documentation')

        -- Goto declaration using built-in LSP functionality
        map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', '[G]oto [D]eclaration')
      end

      -- Call setup on each LSP server
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          -- Don't call setup for JDTLS Java LSP because it will be setup from a separate config
          if server_name ~= 'jdtls' then
            lspconfig[server_name].setup {
              on_attach = lsp_attach,
              capabilities = lsp_capabilities,
            }
          end
        end,
      }

      -- Lua LSP settings
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
          },
        },
      }

      -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
      local open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or 'rounded' -- Set border to rounded
        return open_floating_preview(contents, syntax, opts, ...)
      end
    end,
  },
}
