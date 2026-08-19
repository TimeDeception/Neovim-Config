return {
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true, opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  }, },
	{ "EdenEast/nightfox.nvim", lazy = true },
}
