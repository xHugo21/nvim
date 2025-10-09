return {
  "nvim-mini/mini.surround",
  init = function()
    -- free the 's' key in Normal and Visual modes
    vim.keymap.set({ "n", "x" }, "s", "<Nop>")
  end,
  opts = {
    mappings = {
      add = "sa",
      delete = "sd",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      replace = "sr",
      update_n_lines = "sn",
    },
  },
  keys = function(_, keys)
    local o = LazyVim.opts("mini.surround")
    local maps = {
      { o.mappings.add,            desc = "Add Surrounding",       mode = { "n", "v" } },
      { o.mappings.delete,         desc = "Delete Surrounding" },
      { o.mappings.find,           desc = "Find Right Surrounding" },
      { o.mappings.find_left,      desc = "Find Left Surrounding" },
      { o.mappings.highlight,      desc = "Highlight Surrounding" },
      { o.mappings.replace,        desc = "Replace Surrounding" },
      { o.mappings.update_n_lines, desc = "Update n_lines" },
    }
    maps = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, maps)
    return vim.list_extend(maps, keys)
  end,
}
