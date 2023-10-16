local M = {}

local notify = require("notify")


local absolute_git_dir = vim.fn.system("git rev-parse --absolute-git-dir | tr -d '\n'")
absolute_git_dir = vim.fn.fnamemodify(absolute_git_dir, ":p")

local git_toplevel = vim.fn.system("git rev-parse --show-toplevel | tr -d '\n'")
git_toplevel = vim.fn.fnamemodify(git_toplevel, ":p")

local scratchpad_dir = git_toplevel .. ".scratchpad"


local function gitExcludeScratchpad()
  local git_exclude_path = absolute_git_dir .. "info/exclude"

  local exclude_file = io.open(git_exclude_path, "a")

  if exclude_file then
    exclude_file:write(".scratchpad/*")
    exclude_file:close()
    notify("scratchpad added to .git/info/exclude!")
  end
end


function M.new_note()
  local note_path = scratchpad_dir .. "/scratch.md"

  if vim.fn.filereadable(note_path) == 1 then
    vim.cmd(":e " .. note_path)
    return
  end

  -- maybe only create a directory after the user calls one of the commands
  if vim.fn.isdirectory(scratchpad_dir) == 0 then
    vim.fn.mkdir(scratchpad_dir, "p")
    notify("scratchpad directory created!")

    gitExcludeScratchpad()
  end

  local scratch_file = io.open(note_path, "a")

  if scratch_file then
    scratch_file:write("ok!")
    scratch_file:close()
    vim.cmd(":e " .. note_path)
  end
end

return M
