return {
  -- Mason plugin for managing LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    version = "^1.0.0",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSPConfig to automatically link Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.0.0",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },

  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    event = "LspAttach", -- Trigger LSP config on attaching
  },
}
