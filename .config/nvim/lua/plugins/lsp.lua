return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        ensure_installed = "all",
        ignore_install = {},
        auto_install = true,
        sync_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,
          additional_vim_regex_highlighting = false,
        },
      })
    end
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    enabled = true,
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Setup LSP inlay messages
      vim.diagnostic.config({
        virtual_text = {
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          spacing = 2,
        },
        signs      = false,
        underline  = false,
        update_in_insert = false,
      })
      -- Handle lspattach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end
          map('<leader>gr', vim.lsp.buf.rename, '[R]ename')
          map('<leader>gga', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
          map('<leader>ggr', require('telescope.builtin').lsp_references, '[R]eferences')
          map('<leader>ggi', require('telescope.builtin').lsp_implementations, '[I]mplementation')
          map('<leader>ggd', require('telescope.builtin').lsp_definitions, '[D]efinition')
          map('<leader>ggD', vim.lsp.buf.declaration, '[D]eclaration')
          map('<leader>gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('<leader>gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('<leader>ggt', require('telescope.builtin').lsp_type_definitions, '[T]ype Definition')

        end
      })
      -- Setup the LSP's I use
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local servers = {
        gopls = {},
        pyright = {},
        rust_analyzer = {},
        terraformls = {},
        tailwindcss = {},
        ts_ls = {},
        helm_ls = {},
        bashls = {},
        dockerls = {},
        nginx_language_server = {
          cmd = { 'nginx-language-server' },
        },
        starlark_rust = {},
        tilt = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        }
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table ( handled by mason-tool-installer)
        automatic_installation = false,
        automatic_enable = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
      -- done
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    opts = {
      inlay_hints = true,
    },
  },
}
