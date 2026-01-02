local tmux_provider = {
  toggle = function()
    local cwd = vim.fn.getcwd()
    local handle = io.popen("tmux list-windows -F '#{window_name} #{window_id}' -f '#{==:#{window_name},opencode}'")
    if not handle then
      vim.notify('Failed to run tmux list-windows.', vim.log.levels.ERROR)
      return
    end

    local output = handle:read('*a')
    handle:close()

    if output == '' then
      os.execute(string.format("tmux new-window -n opencode 'cd %s && opencode'", cwd))
      return
    end

    for _, window_id in string.gmatch(output, '%S+%s+(@%d+)') do
      local pane_handle = io.popen(string.format("tmux list-panes -t %s -F '#{pane_current_path}'", window_id))
      if pane_handle then
        local pane_cwd = pane_handle:read('*a'):gsub('%s+$', '')
        pane_handle:close()
        if pane_cwd == cwd then
          os.execute(string.format('tmux select-window -t %s', window_id))
          return
        end
      end
    end

    os.execute(string.format("tmux new-window -n opencode 'cd %s && opencode'", cwd))
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

    vim.keymap.set({ 'n', 't' }, '<leader>ao', function()
      require('opencode').toggle()
    end, { desc = 'Open opencode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
      require('opencode').ask('', { submit = true })
    end, { desc = 'Ask opencode' })
    vim.keymap.set({ 'x' }, '<leader>ae', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode (visual)' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ax', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
  end,
}
