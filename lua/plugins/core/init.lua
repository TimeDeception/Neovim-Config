-- ~/.config/nvim/lua/plugins/core/init.lua
-- Core plugins that work on both laptop and phone

return {
	-- Autopairs (lightweight, essential)
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- Autotag for HTML/JSX (lightweight)
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Which-key (helpful on both devices)
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({
				window = {
					border = "single",
					margin = { 1, 0, 1, 0 },
				},
			})
			local wk = require("which-key")
			wk.add({
				{ "<leader>f", group = "file/find" },
				{ "<leader>e", desc = "File explorer" },
				{ "<leader>u", group = "ui" },
				{ "<leader>g", group = "git" },
				{ "<leader>l", group = "lsp" },
				{ "<leader>b", group = "buffer" },
				{ "<leader>s", group = "split" },
				{ "<leader>t", group = "terminal" },
			})
		end,
	},

	-- Beautiful statusline (works everywhere)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local is_termux = vim.g.is_termux

			-- Different configs for laptop vs phone
			if is_termux then
				-- Simple for phone
				require("lualine").setup({
					options = {
						icons_enabled = true,
						theme = "auto",
						section_separators = "",
						component_separators = "|",
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch" },
						lualine_c = { "filename" },
						lualine_x = { "filetype" },
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},
				})
			else
				-- Fancy for laptop
				require("lualine").setup({
					options = {
						icons_enabled = true,
						theme = "auto",
						component_separators = { left = "", right = "" },
						section_separators = { left = "", right = "" },
						globalstatus = true,
					},
					sections = {
						lualine_a = {
							{ "mode", separator = { left = "" }, right_padding = 2 },
						},
						lualine_b = {
							"branch",
							{
								"diff",
								symbols = { added = " ", modified = " ", removed = " " },
							},
						},
						lualine_c = {
							{ "filename", file_status = true, path = 1 },
							{
								"diagnostics",
								sources = { "nvim_diagnostic" },
								symbols = { error = " ", warn = " ", info = " ", hint = " " },
							},
						},
						lualine_x = {
							{
								require("lazy.status").updates,
								cond = require("lazy.status").has_updates,
								color = { fg = "#ff9e64" },
							},
							{ "encoding" },
							{ "fileformat", symbols = { unix = "", dos = "", mac = "" } },
							{ "filetype" },
						},
						lualine_y = { "progress" },
						lualine_z = {
							{ "location", separator = { right = "" }, left_padding = 2 },
						},
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = { "filename" },
						lualine_x = { "location" },
						lualine_y = {},
						lualine_z = {},
					},
					extensions = { "neo-tree", "lazy", "mason" },
				})
			end
		end,
	},

	-- Gitsigns (lightweight, useful)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				map("n", "]c", gs.next_hunk, { desc = "Next hunk" })
				map("n", "[c", gs.prev_hunk, { desc = "Prev hunk" })
				map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
			end,
		},
	},

	-- Web devicons
	{
		"nvim-tree/nvim-web-devicons",
		opts = {},
	},
}
