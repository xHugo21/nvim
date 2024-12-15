return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
        panel = { enabled = false },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = {
          ["<Tab>"] = function(fallback)
            local copilot_suggestion = require("copilot.suggestion")
            if copilot_suggestion.is_visible() then
              copilot_suggestion.accept()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end,
        },
      })
    end,
  },
}
