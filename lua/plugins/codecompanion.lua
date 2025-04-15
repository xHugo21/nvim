return {
  "olimorris/codecompanion.nvim",
  config = true,
  opts = {
    -- adapters = {
    --   copilot = function()
    --     return require("codecompanion.adapters").extend("copilot", {
    --       schema = {
    --         model = {
    --           default = "claude-3.7-sonnet",
    --         },
    --         max_tokens = {
    --           default = 64000,
    --         },
    --       },
    --     })
    --   end,
    -- },
    strategies = {
      chat = { adapter = "copilot" },
      inline = { adapter = "copilot" },
      agent = { adapter = "copilot" },
    },
    -- display = {
    --   chat = {
    --     show_settings = true,
    --   },
    -- },
    opts = {
      log_level = "DEBUG",
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n" }, desc = "Toggle CodeCompanion Chat" },
    { "<leader>an", "<cmd>CodeCompanionChat<CR>", mode = { "n" }, desc = "Open CodeCompanion Chat" },
    { "<leader>ae", "<cmd>CodeCompanion<CR>", mode = { "v" }, desc = "CodeCompanion Prompt" },
    { "<leader>ax", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
  },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim" },
    {
      "saghen/blink.cmp",
      lazy = false,
      version = "*",
      opts = {
        keymap = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        sources = {
          default = { "lsp", "path", "buffer", "codecompanion" },
        },
        cmdline = {
          sources = {}, -- Disable sources for command-line mode
        },
      },
    },
  },
}
