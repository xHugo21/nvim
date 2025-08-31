-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>o", "<cmd>update<CR> <cmd>source<CR>")

vim.api.nvim_create_user_command("YankRelPath", function()
  local oil = require("oil")
  local dir = oil.get_current_dir()
  local entry = oil.get_cursor_entry()

  if dir and entry then
    local abspath = vim.fn.fnamemodify(dir .. entry.name, ":p")
    local relpath = vim.fn.fnamemodify(abspath, ":.")
    vim.fn.setreg("+", relpath)
    vim.notify("Copied relative path: " .. relpath, vim.log.levels.INFO)
  else
    local abspath = vim.fn.expand("%:p")
    if abspath == "" then
      vim.notify("No file to yank path from", vim.log.levels.WARN)
      return
    end
    local relpath = vim.fn.fnamemodify(abspath, ":.")
    vim.fn.setreg("+", relpath)
    vim.notify("Copied relative path: " .. relpath, vim.log.levels.INFO)
  end
end, { desc = "Yank path relative to cwd" })

vim.keymap.set("n", "<leader>yp", "<cmd>YankRelPath<CR>", { desc = "Yank relative path" })

-- Function to find package.json directory by traversing up
local function find_package_json_dir(start_path)
  local current_dir = vim.fn.fnamemodify(start_path, ":p:h")

  while current_dir ~= "/" do
    local package_json = current_dir .. "/package.json"
    if vim.fn.filereadable(package_json) == 1 then
      return current_dir
    end
    current_dir = vim.fn.fnamemodify(current_dir, ":h")
  end

  return nil
end

-- Function to run Jest in tmux window
local function run_jest_test()
  local current_file = vim.fn.expand("%:p")

  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.WARN)
    return
  end

  local package_dir = find_package_json_dir(current_file)
  if not package_dir then
    vim.notify("No package.json found in parent directories", vim.log.levels.WARN)
    return
  end

  local relative_file = vim.fn.fnamemodify(current_file, ":.")
  local jest_cmd = string.format("cd '%s' && npx jest '%s' --watch --no-coverage", package_dir, relative_file)
  local tmux_cmd = string.format("tmux new-window -n 'jest:%s' '%s'", vim.fn.fnamemodify(current_file, ":t"), jest_cmd)

  local result = vim.fn.system(tmux_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to create tmux window: " .. result, vim.log.levels.ERROR)
  else
    vim.notify("Started Jest test in new tmux window", vim.log.levels.INFO)
  end
end

vim.keymap.set("n", "<leader>tr", run_jest_test, { desc = "Run Jest Test File (tmux)" })
