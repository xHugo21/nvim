return {
  -- Mason plugin for managing LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSPConfig to automatically link Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup()

      -- Setup the handlers for LSP servers
      require("mason-lspconfig").setup_handlers({
        -- Default handler for any LSP server
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,

        -- Dedicated handler for specific servers
        -- ["rust_analyzer"] = function()
        --   require("rust-tools").setup({})
        -- end,
      })
    end,
  },

  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    event = "LspAttach", -- Trigger LSP config on attaching
  },
}
