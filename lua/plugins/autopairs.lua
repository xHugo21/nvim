return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    ignored_next_char = '[%w%.]',

    -- Prevent pairing if inside a string or comment
    check_ts = true,
    ts_config = {
      lua = { 'string' },
      javascript = { 'template_string' },
    },

    -- Enter places closing pair on new line
    map_cr = true,
  },
}
