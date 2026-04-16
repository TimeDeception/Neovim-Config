return {
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
			{ "<leader>g", group = "git" },
			{ "<leader>l", group = "lsp" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>s", group = "split" },
			{ "<leader>t", group = "terminal" },
		})
	end,
}
