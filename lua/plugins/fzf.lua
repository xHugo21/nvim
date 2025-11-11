return {
  'ibhagwan/fzf-lua',
  lazy = false,
  opts = function(_, opts)
    local fzf = require 'fzf-lua'
    local config = fzf.config
    local actions = fzf.actions

    -- Use as vim.ui.select
    fzf.register_ui_select()

    -- Quickfix
    config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'

    return vim.tbl_deep_extend('force', opts or {}, {
      defaults = {
        file_icons = 'mini',
        formatter = 'path.dirname_first',
      },
      winopts = {
        preview = {
          previewer = 'builtin',
          layout = 'vertical',
          horizontal = 'down:40%',
          border = 'rounded',
          wrap = 'nowrap',
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
    })
  end,
  keys = {
    {
      '<leader>,',
      '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
    { '<leader><space>', '<cmd>FzfLua files<cr>', desc = 'Find Files' },
    { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Live Grep' },
    { '<leader>gD', '<cmd>FzfLua git_diff<cr>', desc = 'Git Diff' },
    { '<leader>gB', '<cmd>FzfLua git_blame<cr>', desc = 'Git Blame' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Search Diagnostics' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Search Keymaps' },
  },
  dependencies = { 'nvim-mini/mini.icons' },
}
