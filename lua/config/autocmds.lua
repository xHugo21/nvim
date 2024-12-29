-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable auto comment after line
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

-- Close Neo-tree when no more file buffers are open
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("AutoCloseNeoTree", { clear = true }),
  callback = function()
    local non_floating_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).relative == ""
    end, vim.api.nvim_tabpage_list_wins(0))

    local non_neo_tree_windows = vim.tbl_filter(function(win)
      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "neo-tree"
    end, non_floating_windows)

    if #non_neo_tree_windows == 0 then
      vim.cmd("q")
    end
  end,
})
