vim.g.mapleader = " "
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.wildmode = { "longest", "list" }
vim.opt.termguicolors = true
vim.opt.showtabline = 2

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local ignore_ft = { "markdown", "text" }
    if vim.tbl_contains(ignore_ft, vim.bo[args.buf].filetype) then return end
    vim.lsp.buf.format({
      async = false,
      filter = function(client)
        return client.name == "null-ls"
      end,
    })
  end,
})

require("config.lazy")
require("config.options")
require("config.keymaps")
