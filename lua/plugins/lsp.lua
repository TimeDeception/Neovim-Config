return {
	------------------------
	-- Mason + LSP setup
	------------------------
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "mason-org/mason.nvim", opts = {} },
			"jay-babu/mason-null-ls.nvim",
			{ "nvimtools/none-ls.nvim", dependencies = { "nvimtools/none-ls-extras.nvim" } },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")
			-- LSP servers to install
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
					"pyright", -- ADDED: Python LSP
				},
				handlers = {
					function(server_name)
						-- Safe ESLint setup
						if server_name == "eslint" then
							lspconfig.eslint.setup({
								root_dir = function(fname)
									return util.find_package_json(fname) or vim.loop.cwd()
								end,
							})
						-- ADDED: Python setup
						elseif server_name == "pyright" then
							lspconfig.pyright.setup({
								settings = {
									python = {
										analysis = {
											typeCheckingMode = "basic",
											autoSearchPaths = true,
											useLibraryCodeForTypes = true,
											diagnosticMode = "workspace",
										},
									},
								},
							})
						else
							lspconfig[server_name].setup({})
						end
					end,
				},
			})
			------------------------
			-- Diagnostics UI
			------------------------
			vim.diagnostic.config({
				virtual_text = { prefix = "▎", spacing = 2 },
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = "",
					})
				end,
			})
			------------------------
			-- mason-null-ls
			------------------------
			require("mason-null-ls").setup({
				ensure_installed = {
					"prettier",
					"eslint_d",
					"black", -- ADDED: Python formatter
					"ruff", -- ADDED: Python linter
				},
			})
		end,
	},
	------------------------
	-- null-ls setup (Prettier + ESLint diagnostics)
	------------------------
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvimtools/none-ls-extras.nvim" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				root_dir = vim.loop.cwd, -- fallback for single files
				sources = {
					-- ESLint for diagnostics & code actions only
					require("none-ls.diagnostics.eslint_d"),
					require("none-ls.code_actions.eslint_d"),
					-- Prettier for formatting
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "javascript", "typescript", "html", "css", "json", "php" },
					}),
					-- stylua for Lua formatting
					null_ls.builtins.formatting.stylua,

					-- ADDED: Python formatting with black
					null_ls.builtins.formatting.black.with({
						extra_args = { "--fast", "--line-length", "88" },
					}),
					-- ADDED: Python linting with ruff
					null_ls.builtins.diagnostics.ruff,
				},
			})
			-- Autoformat on save using null-ls (Prettier)
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.js", "*.ts", "*.lua", "*.py" }, -- ADDED: *.py
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end,
	},
}
