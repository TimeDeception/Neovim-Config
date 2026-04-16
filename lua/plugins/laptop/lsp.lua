return{
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "mason-org/mason.nvim", opts = {} },

		-- ❌ REMOVE mason-null-ls completely

		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"eslint",
				"cssls",
				"html",
				"jsonls",
				"emmet_ls",
				"intelephense",
				"pyright",
			},
		})

		------------------------------------------------------------
		-- LSP handlers
		------------------------------------------------------------
		require("mason-lspconfig").setup({
			handlers = {
		    function(server_name)
		  	require("lspconfig")[server_name].setup({})
		  end,
	    },
		})

		------------------------------------------------------------
		-- FORMATTERS (none-ls)
		------------------------------------------------------------
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- JS/TS
				null_ls.builtins.formatting.prettier,

				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Python
				null_ls.builtins.formatting.black,
			},
		})
	end,
}
