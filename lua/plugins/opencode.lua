return {
  'sudo-tee/opencode.nvim',
  event = 'VeryLazy',
  config = function()
    require('opencode').setup {
      keymap = {
        editor = {
          ['<leader>aa'] = { 'toggle' },
          ['gp'] = { 'configure_provider' },
          ['<leader>oc'] = false,
        },
        input_window = {
          ['<C-s>'] = { 'submit_input_prompt', mode = { 'n', 'i' } },
          ['<C-c>'] = { 'close' },
          ['<esc>'] = { 'cancel' },
          ['<C-p>'] = { 'mention_file', mode = { 'n', 'i' } },
          ['<M-m>'] = { 'toggle_pane', mode = { 'n', 'i' } },
          ['<tab>'] = { 'switch_mode', mode = { 'n', 'i' } },
        },
        output_window = {
          ['<C-c>'] = { 'close' },
          ['<esc>'] = { 'cancel' },
          ['<M-m>'] = { 'toggle_pane', mode = { 'n', 'i' } },
        },
      },
    }
  end,
  keys = {
    {
      '<leader>oc',
      function()
        vim.cmd 'Opencode command commit'
      end,
      desc = 'Run opencode commit command',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        anti_conceal = { enabled = false },
        file_types = { 'opencode_output' },
      },
      ft = { 'opencode_output' },
    },
    'saghen/blink.cmp',
    'ibhagwan/fzf-lua',
  },
}
