-- ~/.config/nvim/init.lua
-- Universal Neovim config for laptop and phone (Termux)

-- Set leader keys FIRST
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Detect environment
local is_termux = vim.fn.isdirectory('/data/data/com.termux') == 1
local is_ssh = os.getenv("SSH_CONNECTION") ~= nil

-- Store globally so other modules can access
vim.g.is_termux = is_termux
vim.g.is_ssh = is_ssh

-- Basic settings (shared across all environments)
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wildmode = { "longest", "list" }
vim.opt.showtabline = 2
vim.opt.updatetime = 1000
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true

-- Phone-specific optimizations
if is_termux then
  vim.opt.termguicolors = false  -- Better terminal compatibility
  vim.opt.lazyredraw = true      -- Faster scrolling
  vim.opt.updatetime = 2000      -- Less frequent updates
  vim.opt.showtabline = 0        -- Hide tabline (save space)
  vim.opt.cmdheight = 1          -- Minimize command line
else
  vim.opt.termguicolors = true
end

-- Auto-format on save (conditional)
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local ignore_ft = { "markdown", "text" }
    if vim.tbl_contains(ignore_ft, vim.bo[args.buf].filetype) then return end
    
    -- Only format with LSP if available
    if not is_termux then
      vim.lsp.buf.format({
        async = false,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end
  end,
})

-- Load configuration modules
require("config.lazy")
require("config.keymaps")

-- Load environment-specific options
if is_termux then
  require("config.phone")
else
  require("config.laptop")
end
