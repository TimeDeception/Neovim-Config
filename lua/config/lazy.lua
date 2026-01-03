-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ 
    "git", "clone", "--filter=blob:none", "--branch=stable", 
    lazyrepo, lazypath 
  })
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

-- Determine which plugins to load
local is_termux = vim.g.is_termux

-- Setup lazy.nvim with conditional imports
require("lazy").setup({
  spec = {
    -- Core plugins (always loaded)
    { import = "plugins.core" },
    
    -- Laptop-only plugins (heavy features)
    { import = "plugins.laptop", cond = not is_termux },
    
    -- Phone-only plugins (lightweight alternatives)
    { import = "plugins.phone", cond = is_termux },
  },
  
  install = { colorscheme = { "habamax" } },
  checker = { 
    enabled = not is_termux,  -- Disable auto-check on phone (saves battery)
  },
  performance = {
    rtp = {
      disabled_plugins = is_termux and {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      } or {},
    },
  },
})
