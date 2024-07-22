return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"dockerls",
					"docker_compose_language_service",
					"jsonls",
					"pyright",
					"yamlls",
					-- "gofmt",
					-- "ruff_format",
					-- "black",
					-- "stylua",
					-- "shfmt",
					-- "golangcilint",
					-- "tidy",
					-- "eslint_d",
					-- "jsonlint",
					-- "luacheck",
					-- "markdownlint",
					"ruff",
					-- "shellcheck",
					-- "yamllint",
				},
			})
		end,
	},
}
