-- ~/.config/nvim/lua/plugins/laptop/init.lua
-- Heavy plugins for laptop only

return {
	-- Your full autocomplete setup
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			"saadparwaiz1/cmp_luasnip",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "html", "css", "javascript", "lua", "bash", "python", "typescript" },
				highlight = { enable = true },
				indent = { enable = true },
				auto_install = true,
			})
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = { require("telescope.themes").get_dropdown({}) },
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},

	-- Neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
		},
	},

	-- Beautiful Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					themable = true,
					numbers = "none",
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "  File Explorer",
							text_align = "center",
							separator = true,
						},
					},
					color_icons = true,
					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "slant", -- "slant", "thick", "thin", { 'any', 'any' }
					always_show_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
				},
				highlights = {
					buffer_selected = {
						bold = true,
						italic = false,
					},
				},
			})
		end,
	},

	-- Dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({ theme = "hyper" })
		end,
	},

	-- Notify + Noice
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			local notify = require("notify")
			notify.setup({
				stages = "fade_in_slide_out",
				timeout = 2000,
				background_colour = "#1e1e2e",
			})
			vim.notify = notify
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
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
				},
			})
		end,
	},

	-- Toggleterm
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
		},
		config = true,
	},

	-- LazyGit
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- Beautiful Themes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					telescope = true,
					which_key = true,
					mason = true,
					noice = true,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		config = function()
			require("tokyonight").setup({
				style = "storm", -- storm, night, moon, day
				transparent = false,
				styles = {
					sidebars = "dark",
					floats = "dark",
				},
			})
		end,
	},
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, dawn
				dark_variant = "main",
			})
		end,
	},
	{ "EdenEast/nightfox.nvim", lazy = true },

	-- Beautiful indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"lazy",
					"mason",
				},
			},
		},
	},

	-- Colorful parentheses
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
				},
				query = {
					[""] = "rainbow-delimiters",
				},
			}
		end,
	},

	-- Better icons for file types
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh",
					},
				},
				color_icons = true,
				default = true,
			})
		end,
	},

	-- LSP (your full setup)
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "mason-org/mason.nvim", opts = {} },
			"jay-babu/mason-null-ls.nvim",
			{ "nvimtools/none-ls.nvim", dependencies = { "nvimtools/none-ls-extras.nvim" } },
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
				handlers = {
					function(server_name)
						if server_name == "pyright" then
							lspconfig.pyright.setup({
								settings = {
									python = { analysis = { typeCheckingMode = "basic" } },
								},
							})
						else
							lspconfig[server_name].setup({})
						end
					end,
				},
			})

			-- null-ls
			require("mason-null-ls").setup({
				ensure_installed = { "prettier", "eslint_d", "black", "ruff" },
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					require("none-ls.diagnostics.eslint_d"),
					require("none-ls.code_actions.eslint_d"),
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.diagnostics.ruff,
				},
			})
		end,
	},

	-- DAP (debugger)
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
			{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			require("dap-python").setup("python3")

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
		end,
	},
}
