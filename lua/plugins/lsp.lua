return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
          local value = ev.data.params.value or {}
          if not value.kind then return end

          local status = value.kind == "end" and 0 or 1
          local percent = value.percentage or 0

          local osc_seq = string.format("\27]9;4;%d;%d\a", status, percent)

          if os.getenv("TMUX") then
            osc_seq = string.format("\27Ptmux;\27%s\27\\", osc_seq)
          end

          io.stdout:write(osc_seq)
          io.stdout:flush()
        end,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gd', vim.lsp.buf.definition, 'Go to Definition')
          map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
          map('gr', vim.lsp.buf.references, 'References')
          map('gI', vim.lsp.buf.implementation, 'Go to Implementation')
          map('<leader>cr', vim.lsp.buf.rename, 'Rename Variable')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
      }

      -- Gets blink capabilities to pass to the LSP
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.list_extend(
                  vim.api.nvim_get_runtime_file('', true),
                  { '${3rd}/luv/library' }
                ),
              },
            },
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function()
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettierd' },
        javascript = { 'prettierd' },
        typst = { 'typstyle' },
        python = { 'black' },
        sh = { 'shfmt' },
        c = { 'clang-format' },
      },
    },
  },
}
