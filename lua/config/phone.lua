-- ~/.config/nvim/lua/config/phone.lua
-- Phone (Termux) specific optimizations

-- Simpler colorscheme (faster, works better in Termux)
vim.cmd.colorscheme("habamax")

-- Disable heavy features
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Faster syntax highlighting
vim.opt.synmaxcol = 200  -- Don't highlight super long lines

-- Smaller command history (saves memory)
vim.opt.history = 100

-- Disable swap files (phone storage is limited)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Simpler status line message
vim.api.nvim_echo(
  {{ "📱 Phone mode active - Lightweight config loaded", "Title" }},
  false,
  {}
)

-- Disable cursor hold diagnostics (annoying on small screen)
-- Instead, use manual <leader>ld to show diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- Don't show inline (clutters small screen)
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Simple grep command for searching
vim.opt.grepprg = "grep -n $* /dev/null"
