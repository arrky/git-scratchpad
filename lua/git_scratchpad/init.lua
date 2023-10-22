local create = require("git_scratchpad.create")
local read = require("git_scratchpad.read")

local M = {}

M.new_note = create.new_note
M.open_note = read.open_note

return M
