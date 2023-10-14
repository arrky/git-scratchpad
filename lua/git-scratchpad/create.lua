local M = {}

local notify = require("notify")

function M.new_note()
  notify("New note!")
end

return M
