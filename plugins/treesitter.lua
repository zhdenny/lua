return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      ensure_installed = {
        "lua",
        "bash",
        "dockerfile",
        "html",
        "ini",
        "jq",
        "json",
        "make",
        "markdown",
        "markdown_inline",
        "matlab",
        "php",
        "python",
        "regex",
        "sql",
        "typescript",
        "xml",
        "yaml",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
