-- GLOBALS
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.autoformat = true
vim.g.ai_cmp = true
vim.g.root_lsp_ignore = { 'copilot' }
vim.g.deprecation_warnings = false
vim.g.markdown_recommended_style = 0

-- OPTIONS
local opt = vim.opt

-- UI
opt.background = 'dark'
opt.winborder = 'rounded'
opt.laststatus = 3 -- Global statusline
opt.ruler = false -- Disable the default ruler. Already shown in lualine
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.termguicolors = true -- True color support
opt.pumblend = 10 -- Popup menus slightly transparent (blend)
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.winminwidth = 5 -- Minimum window width of every split window
opt.cmdheight = 0 -- Doesn't reserve space for cmd at the bottom. Replaces statusline when needed
opt.cursorline = true -- Enable highlighting of the current line
opt.list = true -- Show some invisible characters (tabs, trailing spaces, etc...)

-- Editing
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.shiftround = true -- Round indentation to a multiple of shiftwidth
opt.formatoptions = 'jqlnt'
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.spelllang = { 'en', 'es' } -- Languages to consider for spelling
opt.autowrite = true -- Enable auto write
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 0 -- No concealment
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Search
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Don't ignore case with capitals when searching
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.inccommand = 'nosplit' -- Preview substitutions :%s
opt.wildmode = 'longest:full,full' -- Command-line completion mode

-- Splits & Windows
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = 'screen' -- Keep same visual layout when splitting windows
opt.scrolloff = 4 -- Lines of context visible when scrolling
opt.sidescrolloff = 8 -- Columns of context visible when scrolling
opt.jumpoptions = 'view' -- Keeps position when jumping through page

-- Session
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' } -- What gets saved in a session

-- Folding
opt.foldmethod = 'indent' -- Fold text based on indentation level
opt.foldlevel = 99
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- Misc
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.shortmess:append { W = true, I = true, c = true, C = true } -- Suppresses some messages
opt.showmode = false -- Dont show mode since we have a statusline
opt.mouse = 'a' -- Enable mouse mode
opt.timeoutlen = 1000 -- Timeout between leader key press and following letters in keybindings
opt.undofile = true -- Save undo history to a .undo file so it can undo after reopening
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wrap = false -- Disable line wrap. Activated via autocmd on typing files: Markdown, Typst...
opt.linebreak = true -- Wrap lines at convenient points (Only matters if wrap is on)
