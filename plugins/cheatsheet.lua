return {
	{
		"sudormrfbin/cheatsheet.nvim",
		config = function()
			require("cheatsheet").setup({
				bundled_cheatsheets = {
					disabled = { "nerd-fonts" },
				},
				bundled_plugin_cheatsheets = {
					disabled = { "cheatsheet" },
				},
				include_only_installed_plugins = true,
			})
		end,
	},
}
