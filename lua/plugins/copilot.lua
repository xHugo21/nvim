return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          keymap = {
            accept = "<Tab>",
            next = "<C-j>",
            prev = "<C-k>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
}
