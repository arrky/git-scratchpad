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

vim.api.nvim_create_user_command("GitScratchpad", function()
  if new_note then
    new_note()
  end
end, {})


-- keymaps

local buf = vim.api.nvim_get_current_buf()

local new_note_shortcut = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>sn" }

vim.keymap.set(new_note_shortcut.modes, new_note_shortcut.shortcut, new_note, {
  noremap = true,
  silent = true,
  nowait = true,
  buffer = buf,
  desc = "Create a new git scrathpad note",
})
