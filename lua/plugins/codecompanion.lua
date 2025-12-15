return {
  'olimorris/codecompanion.nvim',
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = 'copilot',
          model = 'gpt-4.1',
        },
        roles = {
          llm = function(adapter)
            return adapter.formatted_name .. ' (' .. adapter.parameters.model .. ')'
          end,
          user = 'Me',
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
    { '<leader>ae', '<cmd>CodeCompanion<CR>', mode = { 'n', 'v' }, desc = 'Code Companion Visual' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
}
