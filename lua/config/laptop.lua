-- ~/.config/nvim/lua/config/laptop.lua
-- Laptop-specific settings

-- Full color support
vim.opt.termguicolors = true

-- Better UI
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency

-- Set default theme (can be toggled with <leader>ut)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd.colorscheme("catppuccin")
	end,
})

-- Enable cursor hold diagnostics (have screen space for it)
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = "",
		})
	end,
})

-- Beautiful diagnostic config
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 4,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Custom diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Better borders for LSP windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Swap and backup files (have plenty of storage)
vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undofile = true

-- Welcome message
vim.api.nvim_echo({ { "💻 Laptop mode - Full feature set loaded", "Title" } }, false, {})
