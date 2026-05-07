---@diagnostic disable: undefined-global
return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    event = 'VeryLazy',
    opts = {
      lazygit = {
        enabled = true,
        win = {
          style = 'lazygit',
          border = 'solid',
          width = 0.9,
          height = 0.9,
        },
      },
      scope = {},
      gitbrowse = {},
      toggle = {},
      rename = {},
    },
    config = function(_, opts)
      local Snacks = require 'snacks'
      Snacks.setup(opts)

      Snacks.toggle.option('spell', { name = 'spelling' }):map '<leader>us'
      Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>uw'
      Snacks.toggle.inlay_hints():map '<leader>uh'
    end,
    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Open Lazygit',
      },
      {
        '<leader>go',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Open',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bo',
        function()
          Snacks.bufdelete.other()
        end,
        desc = 'Delete Other Buffers',
      },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'LSP: Rename File',
      },
    },
  },
}
