local utils = require("git_scratchpad.utils")

local M = {}

function M.new_note()
  local scratchpad_dir = utils.get_scratchpad_dir()
  local note_path = utils.get_note_path(scratchpad_dir)

  if vim.fn.filereadable(note_path) == 1 then
    utils.vim_open_file(note_path)
    return
  end

  if vim.fn.isdirectory(scratchpad_dir) == 0 then
    vim.fn.mkdir(scratchpad_dir, "p")

    utils.gitExcludeScratchpad()
  end

  local scratch_file = io.open(note_path, "a")

  if scratch_file then
    scratch_file:close()
    vim.cmd(":e " .. note_path)
  end
end

return M
