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

      prompts = {
        commit = {
          prompt = "Generate a Conventional Commit message for the following changes: @diff. Return ONLY the raw commit message (e.g. 'feat: add feature'). Do NOT include the scope/parenthesis part (e.g. do NOT use 'feat(core): add feature'). Do not wrap in markdown or provide explanations.",
          submit = true,
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
