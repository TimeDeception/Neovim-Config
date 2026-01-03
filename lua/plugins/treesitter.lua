return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
      require('nvim-treesitter.install').prefer_git = true
      require("nvim-treesitter.configs").setup{
        ensure_installed = {'html','css','javascript','lua',
        'bash','dockerfile','json','python','typescript','tsx'},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enabled = true
        },
        auto_install = true
      }
      end,
}
