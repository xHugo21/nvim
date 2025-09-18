return {
  -- Mason plugin for managing LSP servers, linters, and formatters
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSPConfig to automatically link Mason with nvim-lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason_lspconfig.setup({
        automatic_enable = true,
      })

      for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
        lspconfig[server_name].setup({})
      end
    end,
  },

  -- nvim-lspconfig for configuring LSP servers
  {
    "neovim/nvim-lspconfig",
    event = "LspAttach", -- Trigger LSP config on attaching
  },
}
