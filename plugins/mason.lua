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
					"ruff",
				},
			})
			-- No additional setup_handlers needed - mason-lspconfig v2.0+
			-- automatically enables installed servers using vim.lsp.enable()
		end,
	},
}
