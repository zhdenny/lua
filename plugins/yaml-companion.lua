return {
  "someone-stole-my-name/yaml-companion.nvim",
  requires = {
    { "neovim/nvim-lspconfig" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    local cfg = require("yaml-companion").setup({
      -- detect k8s schemas based on file content
      builtin_matchers = {
        kubernetes = { enabled = true },
      },

      -- schemas available in Telescope picker
      schemas = {
        -- not loaded automatically, manually select with
        -- :Telescope yaml_schema
        {
          name = "Kometa Config File",
          uri = "https://raw.githubusercontent.com/Kometa-Team/Kometa/nightly/json-schema/config-schema.json",
        },
        -- schemas below are automatically loaded, but added
        -- them here so that they show up in the statusline
        {
          name = "Kustomization",
          uri = "https://json.schemastore.org/kustomization.json",
        },
        {
          name = "GitHub Workflow",
          uri = "https://json.schemastore.org/github-workflow.json",
        },
      },

      lspconfig = {
        settings = {
          yaml = {
            validate = true,
            schemaStore = {
              enable = false,
              url = "",
            },

            -- schemas from store, matched by filename
            -- loaded automatically
            schemas = {
              require("schemastore").yaml.schemas({
                select = {
                  "kustomization.yaml",
                  "GitHub Workflow",
                },
              }),
              ["https://raw.githubusercontent.com/Kometa-Team/Kometa/nightly/json-schema/config-schema.json"] =
              "kometa/config/*.{yml,yaml}",
            },
          },
        },
      },
    })

    require("lspconfig")["yamlls"].setup(cfg)

    require("telescope").load_extension("yaml_schema")

    -- get schema for current buffer
    local function get_schema()
      local schema = require("yaml-companion").get_buf_schema(0)
      if schema.result[1].name == "none" then
        return ""
      end
      return schema.result[1].name
    end

    require("lualine").setup({
      sections = {
        lualine_x = { "fileformat", "filetype", get_schema },
      },
    })
  end,
}
