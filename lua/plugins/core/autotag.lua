return {
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
	config = function()
		require("nvim-ts-autotag").setup()
	end,
}
