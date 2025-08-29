return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      winopts = {
        preview = {
          previewer = "builtin",
          layout = "vertical",
          horizontal = "down:40%",
          border = "rounded",
          wrap = "nowrap",
        },
      },
    })
  end,
}
