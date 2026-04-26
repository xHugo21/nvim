return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = "main",
  main = 'nvim-treesitter',
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local ensureInstalled = {
      'bash', 'regex', 'diff', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vimdoc',
    }
    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,
}
