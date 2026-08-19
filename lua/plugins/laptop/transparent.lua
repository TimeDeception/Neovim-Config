return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("transparent").setup({
      extra_groups = { "NeoTreeNormal", "NeoTreeNormalNC" },
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.cmd("TransparentEnable")
      end,
    })
  end,
}
