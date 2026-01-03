return {
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			local notify = require("notify")
			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 2000,
				background_colour = "#1e1e2e",
				minimum_width = 50,
			})
			vim.notify = notify
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			-- ✅ no need to list notify here again
		},
		config = function()
			require("noice").setup({
				lsp = {
					progress = { enabled = true },
					signature = { enabled = true },
					hover = { enabled = true },
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = true,
					lsp_doc_border = true,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-lua/plenary.nvim",
			-- ✅ no need to list notify again here either
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("notify")
		end,
	},
}
