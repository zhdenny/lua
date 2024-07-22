return {
  "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
  "hrsh7th/nvim-cmp", -- Autocompletion plugin
  "hrsh7th/cmp-nvim-lsp", -- source for neovim builtin LSP client
  "hrsh7th/cmp-path", --completion source for paths
  "hrsh7th/cmp-buffer", --completion source for buffer words
  "stevearc/conform.nvim",
  opts = {}, event = { "BufReadPre", "BufNewFile" }, -- formatter
  "mfussenegger/nvim-lint",
  "onsails/lspkind-nvim", -- icons for lsp functions
}
