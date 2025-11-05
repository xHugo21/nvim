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
    },
    keys = {
      {
        '<leader>gg',
        function()
          require('snacks').lazygit()
        end,
        desc = 'Open Lazygit',
      },
    },
  },
}
