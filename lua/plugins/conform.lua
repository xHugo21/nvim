return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
      json = { "prettier" },
      -- javascript = { "prettier" },
      -- typescript = { "prettier" },
      -- python = { "black" },
      -- html = { "prettier" },
      -- css = { "prettier" },
      vue = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
}
