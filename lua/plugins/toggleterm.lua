return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()
	end,
	keys = {
		{ "<leader>tt", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
	},
}
