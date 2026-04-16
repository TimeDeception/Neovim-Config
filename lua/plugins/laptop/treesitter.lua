return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },

		opts = {
			ensure_installed = {
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"lua",
				"bash",
				"python",
			},
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		},
	},
}
