vim.o.updatetime = 1000
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.number = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd.colorscheme("rose-pine")
	end,
})
