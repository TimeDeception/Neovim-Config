-- ~/.config/nvim/lua/plugins/phone/init.lua
-- Lightweight alternatives for phone (Termux)

return {
	-- Mini.nvim completion (lightweight alternative to nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = {
					{ name = "buffer", max_item_count = 5 }, -- Limited for performance
					{ name = "path" },
				},
			})
		end,
	},

	-- No Treesitter on phone (too heavy)
	-- Basic syntax highlighting from Vim is enough

	-- No Telescope - use built-in :find and :vimgrep

	-- No Neo-tree - use built-in :Explore (netrw)

	-- No Bufferline - statusline shows buffer info

	-- No Dashboard - start directly in files

	-- No fancy notifications - simple echo messages

	-- Simple terminal (built-in)
	-- Use :terminal instead of toggleterm

	-- No LazyGit - use command-line git

	-- Single lightweight theme
	-- Using habamax (built-in, no download needed)

	-- Minimal LSP (optional - can be slow in Termux)
	-- Uncomment if you want basic LSP on phone:
	--[[
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Only install lua_ls for editing Neovim config on phone
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
    end,
  },
  ]]
	--
}
