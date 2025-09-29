return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 50
  end,
  opts = {
    preset = "helix", -- Changed from default "classic" to "helix"
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      -- ["<leader>f"] = { name = "+file" },
      -- ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
      -- ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      -- ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
      -- ["<leader>gf"] = { "LSP-Format" },
      -- ["<leader>gd"] = { "LSP-Definition" },
      -- ["<leader>gr"] = { "LSP-References" },
      -- ["<leader>ca"] = { "LSP-Code Action" },
      -- ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
      -- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      -- ['<leader>i'] = { name = '[I]nfo', _ = 'which_key_ignore' },
      -- ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      -- ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
      -- ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      { "<leader>c", group = "[C]ode", icon = { icon = "", color = "yellow" } },
      { "<leader>c_", hidden = true },
      { "<leader>d", group = "[D]ocument", icon = { icon = "📄", color = "yellow" } },
      { "<leader>d_", hidden = true },
      { "<leader>i", group = "[I]nfo", icon = { icon = "", color = "yellow" } },
      { "<leader>i_", hidden = true },
      { "<leader>r", group = "[R]ename", icon = { icon = "", color = "yellow" } },
      { "<leader>r_", hidden = true },
      { "<leader>s", group = "[S]earch", icon = { icon = "", color = "yellow" } },
      { "<leader>s_", hidden = true },
      { "<leader>t", group = "[T]elescope", icon = { icon = "", color = "yellow" } },
      { "<leader>t_", hidden = true },
    })
  end,
}
