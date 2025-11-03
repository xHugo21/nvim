return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = 'copilot',
          model = 'gpt-4.1',
        },
        slash_commands = {
          ['file'] = { -- Maps <C-p> to enter files as context
            keymaps = {
              modes = {
                i = '<C-p>',
                n = '<C-p>',
              },
            },
          },
        },
      },
    },
  },
  keys = {
    { '<leader>aa', '<cmd>CodeCompanionChat Toggle<CR>', mode = { 'n' }, desc = 'Toggle CodeCompanion Chat' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
}
