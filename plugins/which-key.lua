return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 50
  end,
  config = function()
    local wk = require("which-key")
    wk.register({
      -- ["<leader>f"] = { name = "+file" },
      -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
      -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
      -- ["<leader>gf"] = { "LSP-Format" },
      -- ["<leader>gd"] = { "LSP-Definition" },
      -- ["<leader>gr"] = { "LSP-References" },
      -- ["<leader>ca"] = { "LSP-Code Action" },
      ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['<leader>i'] = { name = '[I]nfo', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      -- ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    })
  end,
}
