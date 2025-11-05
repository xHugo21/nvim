-- AUTOCMDS

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('last_loc', { clear = true }),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close_with_q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('json_conceal', { clear = true }),
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- auto create dir when saving a file in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- disable auto comment after line
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('disable_auto_comment', { clear = true }),
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})

-- open current git repo in GitHub
vim.api.nvim_create_user_command('OpenGitHubRepo', function()
  -- Get the remote origin URL
  local remote = vim.fn.system('git remote get-url origin'):gsub('%s+', '')
  if remote == '' then
    vim.notify("Not a git repository or no remote named 'origin'", vim.log.levels.WARN)
    return
  end

  -- Convert SSH to HTTPS if needed
  -- e.g. git@github.com:user/repo.git → https://github.com/user/repo
  local url = remote:gsub('^git@([^:]+):', 'https://%1/'):gsub('%.git$', ''):gsub('^ssh://git@', 'https://')

  -- For HTTPS remotes, just strip trailing .git
  url = url:gsub('%.git$', '')

  -- Open in default browser
  if vim.fn.has 'mac' == 1 then
    vim.fn.jobstart({ 'open', url }, { detach = true })
  elseif vim.fn.has 'unix' == 1 then
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
  elseif vim.fn.has 'win32' == 1 then
    vim.fn.jobstart({ 'start', url }, { detach = true })
  else
    vim.notify('Could not detect OS to open browser', vim.log.levels.ERROR)
    return
  end

  vim.notify('Opening ' .. url)
end, { desc = 'Open current GitHub repo in browser' })

-- Optional keymap
vim.keymap.set('n', '<leader>go', ':OpenGitHubRepo<CR>', { desc = 'Open current repo on GitHub' })
