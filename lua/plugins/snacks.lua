---@diagnostic disable: undefined-global
return {
  {
    'folke/snacks.nvim',
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
      scope = {}, -- Scope detection, text objects and jumping based on treesitter or indent
      gitbrowse = {},
      toggle = {},
      rename = {},
    },
    config = function()
      local Snacks = require 'snacks'

      -- Rename files on oil modification
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OilActionsPost',
        callback = function(event)
          if event.data.actions[1].type == 'move' then
            Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
          end
        end,
      })

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
