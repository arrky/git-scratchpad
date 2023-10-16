local plenary_dir = os.getenv("PLENARY_DIR") or "/tmp/plenary.nvim"
local no_plenary_dir = vim.fn.isdirectory(plenary_dir) == 0

if no_plenary_dir then
  print("Cloning plenary.nvim at " .. plenary_dir .. "...\n")

  vim.fn.system({ "git", "clone", "https://github.com/nvim-lua/plenary.nvim", plenary_dir })

  print("Done.\n")
end

vim.opt.rtp:append(".")
vim.opt.rtp:append(plenary_dir)

vim.cmd("runtime plugin/plenary.vim")
vim.cmd("runtime plugin/git_scratchpad")
require("plenary.busted")
