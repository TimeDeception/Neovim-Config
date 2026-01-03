local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

-- Files & Search (Telescope)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

-- Bufferline
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", opts)
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)

-- LSP
map("n", "<leader>ld", vim.diagnostic.open_float, opts)
map("n", "<leader>lr", vim.lsp.buf.rename, opts)
map("n", "<leader>la", vim.lsp.buf.code_action, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gi", vim.lsp.buf.implementation, opts)

-- UI / Theme
map("n", "<leader>ut", function()
	local themes = { "catppuccin", "tokyonight", "gruvbox", "rose-pine", "nightfox" }
	local index = vim.g.current_theme_index or 1
	index = index % #themes + 1
	vim.g.current_theme_index = index
	vim.cmd.colorscheme(themes[index])
	print("Theme set to: " .. themes[index])
end, { desc = "Toggle UI Theme" })

-- Dashboard
map("n", "<leader>;", "<cmd>Dashboard<CR>", { desc = "Open dashboard" })

map("n", "<leader>nh", "<cmd>Telescope notify<CR>", { desc = "Show notification history" })
--Terminal
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])
