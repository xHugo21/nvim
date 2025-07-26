local M = {}

local colors = {
  bg = "#282c34",
  fg = "#b8c0d1",
  backgroundFg = "#3a3f4b",
  red = "#e06c75",
  green = "#8fbc8f",
  yellow = "#d4b474",
  blue = "#a7c7f9",
  magenta = "#a875bf",
  cyan = "#56b6c2",
  gray = "#626a7e",

  -- Additional non-functional, color-based names
  darkerBg = "#2c313a",
  diffAddBg = "#2c3e2f",
  diffChangeBg = "#3e3e2f",
  diffDeleteBg = "#3e2f2f",
  diffTextBg = "#2f3e3e",
  referenceBg = "#3e4452",
}

local function set_highlights()
  local hl = vim.api.nvim_set_hl

  -- UI Highlights
  hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
  hl(0, "NormalNC", { fg = colors.gray, bg = colors.bg })
  hl(0, "Cursor", { fg = colors.bg, bg = colors.fg })
  hl(0, "CursorIM", { fg = colors.bg, bg = colors.fg })
  hl(0, "CursorColumn", { bg = colors.backgroundFg })
  hl(0, "CursorLine", { bg = colors.backgroundFg })
  hl(0, "CursorLineNr", { fg = colors.yellow, bg = colors.backgroundFg })
  hl(0, "LineNr", { fg = colors.gray, bg = colors.bg })
  hl(0, "SignColumn", { fg = colors.gray, bg = colors.bg })
  hl(0, "ColorColumn", { bg = colors.darkerBg })
  hl(0, "Conceal", { fg = colors.gray })
  hl(0, "VertSplit", { fg = colors.backgroundFg })
  hl(0, "StatusLine", { fg = colors.fg, bg = colors.backgroundFg })
  hl(0, "StatusLineNC", { fg = colors.gray, bg = colors.backgroundFg })
  hl(0, "WinSeparator", { fg = colors.backgroundFg })
  hl(0, "TabLine", { fg = colors.gray, bg = colors.backgroundFg })
  hl(0, "TabLineFill", { fg = colors.gray, bg = colors.backgroundFg })
  hl(0, "TabLineSel", { fg = colors.fg, bg = colors.bg })
  hl(0, "Title", { fg = colors.magenta, bold = true })
  hl(0, "Visual", { bg = colors.gray })
  hl(0, "VisualNOS", { bg = colors.gray })
  hl(0, "Pmenu", { fg = colors.fg, bg = colors.backgroundFg })
  hl(0, "PmenuSel", { fg = colors.bg, bg = colors.blue })
  hl(0, "PmenuSbar", { bg = colors.backgroundFg })
  hl(0, "PmenuThumb", { bg = colors.blue })
  hl(0, "WildMenu", { fg = colors.bg, bg = colors.blue })
  hl(0, "Folded", { fg = colors.gray, bg = colors.backgroundFg })
  hl(0, "FoldColumn", { fg = colors.gray, bg = colors.bg })
  hl(0, "DiffAdd", { fg = colors.green, bg = colors.diffAddBg })
  hl(0, "DiffChange", { fg = colors.yellow, bg = colors.diffChangeBg })
  hl(0, "DiffDelete", { fg = colors.red, bg = colors.diffDeleteBg })
  hl(0, "DiffText", { fg = colors.blue, bg = colors.diffTextBg })
  hl(0, "Directory", { fg = colors.blue })
  hl(0, "EndOfBuffer", { fg = colors.backgroundFg })
  hl(0, "ErrorMsg", { fg = colors.red, bold = true })
  hl(0, "WarningMsg", { fg = colors.yellow, bold = true })
  hl(0, "ModeMsg", { fg = colors.magenta })
  hl(0, "MoreMsg", { fg = colors.magenta })
  hl(0, "Question", { fg = colors.cyan })
  hl(0, "Search", { fg = colors.bg, bg = colors.yellow })
  hl(0, "IncSearch", { fg = colors.bg, bg = colors.magenta })
  hl(0, "Substitute", { fg = colors.bg, bg = colors.red })
  hl(0, "MatchParen", { fg = colors.bg, bg = colors.cyan, bold = true })
  hl(0, "NonText", { fg = colors.backgroundFg })
  hl(0, "Whitespace", { fg = colors.backgroundFg })
  hl(0, "SpecialKey", { fg = colors.backgroundFg })
  hl(0, "SpellBad", { undercurl = true, sp = colors.red })
  hl(0, "SpellCap", { undercurl = true, sp = colors.yellow })
  hl(0, "SpellLocal", { undercurl = true, sp = colors.cyan })
  hl(0, "SpellRare", { undercurl = true, sp = colors.magenta })
  hl(0, "QuickFixLine", { bg = colors.backgroundFg })

  -- Syntax Highlight Groups
  hl(0, "Comment", { fg = colors.gray, italic = true })
  hl(0, "Constant", { fg = colors.yellow })
  hl(0, "String", { fg = colors.green })
  hl(0, "Character", { fg = colors.green })
  hl(0, "Number", { fg = colors.yellow })
  hl(0, "Boolean", { fg = colors.yellow })
  hl(0, "Float", { fg = colors.yellow })
  hl(0, "Identifier", { fg = colors.cyan })
  hl(0, "Function", { fg = colors.blue })
  hl(0, "Statement", { fg = colors.magenta })
  hl(0, "Conditional", { fg = colors.magenta })
  hl(0, "Repeat", { fg = colors.magenta })
  hl(0, "Label", { fg = colors.magenta })
  hl(0, "Operator", { fg = colors.fg })
  hl(0, "Keyword", { fg = colors.magenta })
  hl(0, "Exception", { fg = colors.magenta })
  hl(0, "PreProc", { fg = colors.yellow })
  hl(0, "Include", { fg = colors.yellow })
  hl(0, "Define", { fg = colors.yellow })
  hl(0, "Macro", { fg = colors.yellow })
  hl(0, "PreCondit", { fg = colors.yellow })
  hl(0, "Type", { fg = colors.cyan })
  hl(0, "StorageClass", { fg = colors.cyan })
  hl(0, "Structure", { fg = colors.cyan })
  hl(0, "Typedef", { fg = colors.cyan })
  hl(0, "Special", { fg = colors.gray })
  hl(0, "SpecialChar", { fg = colors.magenta })
  hl(0, "Tag", { fg = colors.magenta })
  hl(0, "Delimiter", { fg = colors.fg })
  hl(0, "SpecialComment", { fg = colors.gray, italic = true })
  hl(0, "Debug", { fg = colors.red })
  hl(0, "Underlined", { underline = true })
  hl(0, "Ignore", { fg = colors.backgroundFg })
  hl(0, "Error", { fg = colors.red, bold = true })
  hl(0, "Todo", { fg = colors.red, bold = true, underline = true })

  -- Treesitter Highlight Groups
  hl(0, "@comment", { fg = colors.gray, italic = true })
  hl(0, "@constant", { fg = colors.yellow })
  hl(0, "@constant.builtin", { fg = colors.yellow })
  hl(0, "@constructor", { fg = colors.blue })
  hl(0, "@function", { fg = colors.blue })
  hl(0, "@function.builtin", { fg = colors.blue })
  hl(0, "@function.macro", { fg = colors.yellow })
  hl(0, "@keyword", { fg = colors.magenta })
  hl(0, "@keyword.function", { fg = colors.magenta })
  hl(0, "@method", { fg = colors.blue })
  hl(0, "@operator", { fg = colors.fg })
  hl(0, "@parameter", { fg = colors.fg })
  hl(0, "@property", { fg = colors.cyan })
  hl(0, "@punctuation.delimiter", { fg = colors.fg })
  hl(0, "@punctuation.bracket", { fg = colors.fg })
  hl(0, "@punctuation.special", { fg = colors.magenta })
  hl(0, "@string", { fg = colors.green })
  hl(0, "@string.regex", { fg = colors.yellow })
  hl(0, "@string.escape", { fg = colors.yellow })
  hl(0, "@tag", { fg = colors.magenta })
  hl(0, "@tag.attribute", { fg = colors.cyan })
  hl(0, "@tag.delimiter", { fg = colors.fg })
  hl(0, "@type", { fg = colors.cyan })
  hl(0, "@type.builtin", { fg = colors.cyan })
  hl(0, "@variable", { fg = colors.fg })
  hl(0, "@variable.builtin", { fg = colors.cyan })

  -- LSP and Diagnostic Highlight Groups
  hl(0, "DiagnosticError", { fg = colors.red })
  hl(0, "DiagnosticWarn", { fg = colors.yellow })
  hl(0, "DiagnosticInfo", { fg = colors.blue })
  hl(0, "DiagnosticHint", { fg = colors.cyan })
  hl(0, "DiagnosticOk", { fg = colors.green })

  hl(0, "LspReferenceText", { bg = colors.referenceBg })
  hl(0, "LspReferenceRead", { bg = colors.referenceBg })
  hl(0, "LspReferenceWrite", { bg = colors.referenceBg })

  hl(0, "LspCodeLens", { fg = colors.gray, italic = true })
  hl(0, "LspCodeLensSeparator", { fg = colors.gray })

  hl(0, "LspSignatureActiveParameter", { fg = colors.yellow, bold = true })
  hl(0, "LspInlayHint", { fg = colors.gray, italic = true })
end

function M.colorscheme()
  vim.cmd("highlight clear")
  vim.o.termguicolors = true
  vim.g.colors_name = "onedarkish"
  set_highlights()
end

return M
