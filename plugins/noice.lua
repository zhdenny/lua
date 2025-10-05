return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			-- Position the command popup at the center of the screen
			-- See https://github.com/folke/noice.nvim/blob/0cbe3f88d038320bdbda3c4c5c95f43a13c3aa12/lua/noice/types/nui.lua#L6
			-- See https://github.com/folke/noice.nvim/wiki/Configuration-Recipes
			---@type NoiceConfigViews
			views = {
				cmdline_popup = {
					backend = "popup",
					relative = "editor",
					zindex = 200,
					position = {
						row = "15%", -- 40% from top of the screen. This will position it almost at the center.
						col = "80%",
					},
					size = {
						width = 40,
						height = "auto",
					},
					win_options = {
						winhighlight = {
							Normal = "NoiceCmdlinePopup",
							FloatTitle = "NoiceCmdlinePopupTitle",
							FloatBorder = "NoiceCmdlinePopupBorder",
							IncSearch = "",
							CurSearch = "",
							Search = "",
						},
						winbar = "",
						foldenable = false,
						cursorline = false,
					},
				},
				popupmenu = {
					-- relative = 'editor', -- "'cursor'"|"'editor'"|"'win'"
					position = {
						row = "auto", -- Popup will show up below the cmdline automatically
						col = "auto",
					},
					size = {
						width = 60, -- Making this as wide as the cmdline_popup
						height = "auto",
					},
					border = {
						---@type _.NuiBorderStyle
						style = "double", -- 'double'"|"'none'"|"'rounded'"|"'shadow'"|"'single'"|"'solid'
						---@type _.NuiBorderPadding
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = {
							Normal = "NoicePopupmenu", -- Normal | NoicePopupmenu
							FloatBorder = "NoicePopupmenuBorder", -- DiagnosticInfo | NoicePopupmenuBorder
							CursorLine = "NoicePopupmenuSelected",
							PmenuMatch = "NoicePopupmenuMatch",
						},
					},
				},
			},
		})
		require("notify").setup({
			background_colour = "#000000",
			top_down = false,
			timeout = 3000, -- How long notifications stay visible (milliseconds)
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		})
	end,
}
