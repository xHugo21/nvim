local ui2 = require('vim._core.ui2').enable({ enable = true, msg = { targets = 'msg' } })

local mode_map = {
  n = { text = 'NORMAL', hl = 'Type' },
  v = { text = 'VISUAL', hl = 'Special' },
  i = { text = 'INSERT', hl = 'String' },
  R = { text = 'REPLACE', hl = 'Error' },
  c = { text = 'COMMAND', hl = 'Statement' },
  t = { text = 'TERMINAL', hl = 'String' },
}

local special_filetypes = {
  lazy = true,
  fzf = true,
  oil = true,
}

local lsp_progress = {}

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

local function diagnostic_counts()
  local severity = vim.diagnostic.severity

  if vim.diagnostic.count then
    local ok, counts = pcall(vim.diagnostic.count, 0)
    if ok and type(counts) == 'table' then
      return {
        error = counts[severity.ERROR] or 0,
        warn = counts[severity.WARN] or 0,
        info = counts[severity.INFO] or 0,
        hint = counts[severity.HINT] or 0,
      }
    end
  end

  return {
    error = #vim.diagnostic.get(0, { severity = severity.ERROR }),
    warn = #vim.diagnostic.get(0, { severity = severity.WARN }),
    info = #vim.diagnostic.get(0, { severity = severity.INFO }),
    hint = #vim.diagnostic.get(0, { severity = severity.HINT }),
  }
end

local function diagnostics_component()
  local counts = diagnostic_counts()
  local parts = {}

  if counts.error > 0 then
    table.insert(parts, string.format('%%#DiagnosticError#E:%d%%*', counts.error))
  end
  if counts.warn > 0 then
    table.insert(parts, string.format('%%#DiagnosticWarn#W:%d%%*', counts.warn))
  end
  if counts.info > 0 then
    table.insert(parts, string.format('%%#DiagnosticInfo#I:%d%%*', counts.info))
  end
  if counts.hint > 0 then
    table.insert(parts, string.format('%%#DiagnosticHint#H:%d%%*', counts.hint))
  end

  return table.concat(parts, ' ')
end

local function lsp_progress_component()
  local progress_parts = {}
  for _, client_data in pairs(lsp_progress) do
    table.insert(progress_parts, client_data.message)
  end
  return table.concat(progress_parts, ' ')
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

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('native_lsp_progress', { clear = true }),
  callback = function(ev)
    local client_id = ev.data.client_id
    local value = ev.data.params.value or {}
    local kind = value.kind

    if kind == 'begin' then
      lsp_progress[client_id] = { message = value.title or 'LSP' }
    elseif kind == 'report' then
      if lsp_progress[client_id] then
        local message = value.title or 'LSP'
        if value.percentage then
          message = message .. ' ' .. value.percentage .. '%'
        end
        lsp_progress[client_id].message = message
      end
    elseif kind == 'end' then
      lsp_progress[client_id] = nil
    end

    vim.cmd 'redrawstatus'
  end,
})

return {
  ui2,
  render = render
}
