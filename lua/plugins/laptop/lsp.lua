return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},

		config = function()
			-- Mason (kept for installing LSP servers)
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"eslint",
					"pyright",
					"ruff",
					"html",
					"cssls",
				},
			})

			-- Shared keymaps
			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
			end

			-- =========================
			-- LSP CONFIG (NEW API)
			-- =========================

			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
			})

			vim.lsp.config("ts_ls", {
				on_attach = on_attach,
			})

			vim.lsp.config("eslint", {
				on_attach = on_attach,
			})

			vim.lsp.config("pyright", {
				on_attach = on_attach,
			})

			vim.lsp.config("ruff", {
				on_attach = on_attach,
			})

			vim.lsp.config("html", {
				on_attach = on_attach,
			})

			vim.lsp.config("cssls", {
				on_attach = on_attach,
			})

			-- =========================
			-- ENABLE SERVERS
			-- =========================

			vim.lsp.enable({
				"lua_ls",
				"ts_ls",
				"eslint",
				"pyright",
				"ruff",
				"html",
				"cssls",
			})
		end,
	},
}
