return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    -- Don't pair if next char is alphanumeric or a dot
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
