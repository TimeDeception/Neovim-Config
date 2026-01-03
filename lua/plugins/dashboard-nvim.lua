return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local telescope_builtin = require("telescope.builtin")
		require("dashboard").setup({
			theme = "hyper",
			config = {
				project = {
					action = function()
						telescope_builtin.find_files()
					end,
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
