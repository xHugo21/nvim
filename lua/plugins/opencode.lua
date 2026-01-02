local tmux_provider = { -- Checks for opencode on tmux window instead of a split
  toggle = function()
    local handle = io.popen "tmux list-windows -F '#{window_name}'"
    if not handle then
      vim.notify('Failed to run tmux list-windows.', vim.log.levels.ERROR)
      return
    end
    local windows = handle:read '*a'
    handle:close()

    local cmd = 'opencode'

    if windows and string.find(windows, 'opencode') then
      os.execute 'tmux select-window -t opencode'
    else
      os.execute("tmux new-window -n opencode '" .. cmd .. "'")
    end
  end,
}

return {
  'NickvanDyke/opencode.nvim',
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = tmux_provider,
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
