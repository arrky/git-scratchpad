if vim.g.loaded_git_scratchpad == 1 then
  return
end

vim.g.loaded_git_scratchpad = 1

local is_inside_work_tree = vim.fn.system("git rev-parse --is-inside-work-tree | tr -d '\n'")

if is_inside_work_tree == "false" then
  return
end


-- user commands

local new_note = require("git_scratchpad").new_note
local open_note = require("git_scratchpad").open_note
local open_recent = require("git_scratchpad").open_recent

vim.api.nvim_create_user_command("GitScratchpadNew", function()
  if new_note then
    new_note()
  end
end, {})

vim.api.nvim_create_user_command("GitScratchpadOpen", function()
  if open_note then
    open_note()
  end
end, {})

vim.api.nvim_create_user_command("GitScratchpadRecent", function()
  if open_recent then
    open_recent()
  end
end, {})


-- keymaps

local buf = vim.api.nvim_get_current_buf()

local new_note_shortcut = { modes = { "n", "v" }, shortcut = "<leader>sn" }
local open_note_shortcut = { modes = { "n", "v" }, shortcut = "<leader>so" }
local open_recent_shortcut = { modes = { "n", "v" }, shortcut = "<leader>sr" }

vim.keymap.set(new_note_shortcut.modes, new_note_shortcut.shortcut, new_note, {
  noremap = true,
  silent = true,
  nowait = true,
  buffer = buf,
  desc = "Create a new git scrathpad note",
})

vim.keymap.set(open_note_shortcut.modes, open_note_shortcut.shortcut, open_note, {
  noremap = true,
  silent = true,
  nowait = true,
  buffer = buf,
  desc = "Open an existing git scrathpad note",
})

vim.keymap.set(open_recent_shortcut.modes, open_recent_shortcut.shortcut, open_recent, {
  noremap = true,
  silent = true,
  nowait = true,
  buffer = buf,
  desc = "Open most recent scrathpad note",
})
