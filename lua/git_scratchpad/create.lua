local utils = require("git_scratchpad.utils")

local M = {}

local function createNote(filetype)
  local scratchpad_dir = utils.get_scratchpad_dir()

  if not scratchpad_dir then
    return
  end

  local note_path = utils.get_note_path(scratchpad_dir, filetype)

  if utils.file_is_readable(note_path) then
    utils.vim_open_file(note_path)
    return
  end

  utils.gitExcludeScratchpad()

  if not utils.is_directory(scratchpad_dir) then
    vim.fn.mkdir(scratchpad_dir, "p")
  end

  local scratch_file = io.open(note_path, "a")

  if scratch_file then
    scratch_file:close()
    utils.vim_open_file(note_path)
  end
end

local function selectFiletypeThen(callback)
  vim.ui.select({ 'md', 'js', 'lua', 'py', 'sh', 'go' }, {
    prompt = 'Select filetype:',
    format_item = function(item)
      return item
    end,
  }, function(filetype)
    if filetype then
      callback(filetype)
    end
  end)
end

function M.new_note()
  selectFiletypeThen(createNote)
end

return M
