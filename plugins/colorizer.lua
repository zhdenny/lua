return {
  'norcalli/nvim-colorizer.lua',
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
  config = function()
    require("colorizer").setup()
  end,
}
