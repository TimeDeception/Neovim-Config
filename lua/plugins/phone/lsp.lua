return {
	{
		"neovim/nvim-lspconfig",
		enabled = false,
		config = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,
	},
}
