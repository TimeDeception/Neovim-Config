return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup()
    local wk = require("which-key")

    wk.register({
      { "f", group = "file/find" },
      { "e", group = "toggle/tools" },
      { "u", group = "ui" },
      { "g", group = "git" },
      { "l", group = "lsp" },
      { "b", group = "buffer" },
    })
  end,
}

