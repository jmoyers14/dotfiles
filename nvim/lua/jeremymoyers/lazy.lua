-- lua/jeremymoyers/init.lua

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load your existing configs first
require("jeremymoyers.remap")  -- Load keymaps before lazy
require("jeremymoyers.set")    -- Load settings before lazy

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "jeremymoyers.plugins" },
  },
  install = { colorscheme = { "catppuccin/mocha" } }, -- Use your current colorscheme
  checker = { enabled = true },
})
