local ui2 = require('vim._core.ui2').enable({ enable = true, msg = { targets = 'msg' } })

-- Diagnostic Visibility
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
}

local mode_map = {
  n = { text = 'NORMAL', hl = 'Type' },
  v = { text = 'VISUAL', hl = 'Special' },
  i = { text = 'INSERT', hl = 'String' },
  R = { text = 'REPLACE', hl = 'Error' },
  c = { text = 'COMMAND', hl = 'Error' },
  t = { text = 'TERMINAL', hl = 'String' },
}

local special_filetypes = {
  lazy = true,
  fzf = true,
  oil = true,
}

local function mode_component()
  local mode = vim.api.nvim_get_mode().mode
  local first = mode:sub(1, 1)
  local entry = mode_map[first] or { text = mode:upper(), hl = 'StatusLine' }
  return string.format('%%#%s# %s %%*', entry.hl, entry.text)
end

local function branch_component()
  local head = vim.b.gitsigns_head
  if not head or head == '' then
    return ''
  end
  return string.format('%%#Conditional# %s %%*', head)
end

local function filename_component()
  local path = vim.fn.expand '%:~:.'
  if path == '' then
    path = '[No Name]'
  end

  local flags = {}
  if vim.bo.modified then
    table.insert(flags, '+')
  end
  if vim.bo.readonly then
    table.insert(flags, 'RO')
  end
  if not vim.bo.modifiable then
    table.insert(flags, '-')
  end

  if #flags > 0 then
    path = path .. ' [' .. table.concat(flags, ',') .. ']'
  end

  return path
end

local function diagnostics_component()
  return vim.diagnostic.status()
end

local function lsp_progress_component()
  return vim.lsp.status()
end

local function recording_component()
  local reg = vim.fn.reg_recording()
  if reg == '' then
    return ''
  end
  return string.format('%%#ErrorMsg#recording @%s %%*', reg)
end

local function progress_component()
  local current = vim.fn.line '.'
  local total = math.max(vim.fn.line '$', 1)
  local percent = math.floor((current / total) * 100)
  return string.format('%3d%%%%', percent)
end

local function location_component()
  return string.format('%d:%d', vim.fn.line '.', vim.fn.virtcol '.')
end

local function render()
  local ft = vim.bo.filetype
  if special_filetypes[ft] then
    return ' ' .. ft .. ' '
  end

  local parts = {
    mode_component(),
    branch_component(),
    filename_component(),
    '%<',
    '%=',
    recording_component(),
    diagnostics_component(),
    lsp_progress_component(),
    progress_component(),
    location_component(),
  }

  local result = {}
  for _, p in ipairs(parts) do
    if p ~= '' then
      table.insert(result, p)
    end
  end

  return table.concat(result, ' ')
end

vim.opt.statusline = "%!v:lua.require('config.native').render()"

return {
  ui2,
  render = render
}
