return {
  'kyzabuilds/xeno.nvim',
  config = function()
    local xeno = require('xeno')

    xeno.setup({
      background = '#1E1E1E',
      accent = '#d39c9b',
      transparent = true,

      integrations = {
        ghostty = {
          enabled = false,
        },
      },
    })
  end,
}
