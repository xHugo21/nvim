return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {
      "<leader>e",
      function()
        local oil = require("oil")
        if oil.get_current_dir() ~= nil then
          if vim.bo.modified then
            oil.save({ confirm = true }, function(err)
              if not err then
                oil.close()
              end
            end)
          else
            oil.close()
          end
        else
          oil.open()
        end
      end,
      desc = "Toggle File Explorer",
    },
    {
      "<leader>E",
      function()
        require("oil").open(vim.fn.getcwd())
      end,
      desc = "Toggle File Explorer (cwd)",
    },
  },
}
