local utils = require("git_scratchpad.utils")

local M = {}

local function sortByLastModifiedDescending(dir, files)
  table.sort(files, function(a, b)
    return vim.fn.getftime(dir .. "/" .. a) >
        vim.fn.getftime(dir .. "/" .. b)
  end)

  if files then
    return files
  end
end

local function getScratchpadFiles(scratchpad_dir)
  local files = {}

  local dir_list = vim.fn.readdir(scratchpad_dir)

  for _, file in ipairs(dir_list) do
    files[#files + 1] = file
  end

  return sortByLastModifiedDescending(scratchpad_dir, files)
end

function M.open_note()
  local scratchpad_dir = utils.get_scratchpad_dir()

  if not scratchpad_dir then
    return
  end

  local files = getScratchpadFiles(scratchpad_dir)

  local selected = utils.vim_select(files)

  if selected then
    utils.vim_open_file(scratchpad_dir .. "/" .. selected)
  end
end

function M.open_recent()
  local scratchpad_dir = utils.get_scratchpad_dir()

  if not scratchpad_dir then
    return
  end

  local files = getScratchpadFiles(scratchpad_dir)

  if files then
    utils.vim_open_file(scratchpad_dir .. "/" .. files[1])
  end
end

return M
