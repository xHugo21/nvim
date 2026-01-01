return {
  'NickvanDyke/opencode.nvim',
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = 'tmux',
        tmux = {
          options = '-h -p 40',
        },
      },
    }

    vim.o.autoread = true

    vim.keymap.set({ 'n', 't' }, '<leader>aa', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ae', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ax', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
  end,
}
