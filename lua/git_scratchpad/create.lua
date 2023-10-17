local utils = require("git_scratchpad.utils")

local M = {}

function M.new_note()
  local scratchpad_dir = utils.get_scratchpad_dir()
  local note_path = utils.get_note_path(scratchpad_dir)

  if utils.file_is_readable(note_path) then
    utils.vim_open_file(note_path)
    return
  end

  if not utils.is_directory(scratchpad_dir) then
    vim.fn.mkdir(scratchpad_dir, "p")

    utils.gitExcludeScratchpad()
  end

  local scratch_file = io.open(note_path, "a")

  if scratch_file then
    scratch_file:close()
    utils.vim_open_file(note_path)
  end
end

return M
