-- START THESE LINES ARE TO GET TELESCOPE PICKER TO SHOW FILENAME FIRST AND THEN PATH
vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})

local function filenameFirst(_, path)
	local tail = vim.fs.basename(path)
	local parent = vim.fs.dirname(path)
	if parent == "." then
		return tail
	end
	return string.format("%s\t\t%s", tail, parent)
end
-- END THESE LINES ARE TO GET TELESCOPE PICKER TO SHOW FILENAME FIRST AND THEN PATH

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			require("telescope").setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
					find_files = {
						follow = true,
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--no-ignore-vcs",
							"-g",
							"!rclone_mounts",
							"-g",
							"!.git",
							"-g",
							"!.cache",
							"-g",
							"!.local",
							"-g",
							"!/Cache",
							"-g",
							"!nerd-fonts",
							"-g",
							"!/data/kometa_assets",
							"-g",
							"!Metadata",
						},
					},
				},
				-- START THESE LINES ARE TO GET TELESCOPE PICKER TO SHOW FILENAME FIRST AND THEN PATH
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "󰼛 ",
					entry_prefix = "  ",
					path_display = filenameFirst,
				},
				-- END THESE LINES ARE TO GET TELESCOPE PICKER TO SHOW FILENAME FIRST AND THEN PATH
			})
			-- vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files<CR>", {})
			vim.keymap.set("n", "<leader>to", "<Cmd>cd /opt/ | Telescope find_files<CR>", { desc = "[T]elescope opt" })
			vim.keymap.set(
				"n",
				"<leader>tc",
				"<Cmd>cd /opt/custom_scripts/ | Telescope find_files<CR>",
				{ desc = "[T]elescope opt" }
			)
			vim.keymap.set(
				"n",
				"<leader>th",
				"<Cmd>cd /home/beast/ | Telescope find_files<CR>",
				{ desc = "[T]elescope home" }
			)
			vim.keymap.set(
				"n",
				"<leader>sb",
				":Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "[S]earch [B]uffer" }
			)
			vim.keymap.set(
				"n",
				"<leader>sG",
				"<Cmd>:lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",
				{ desc = "[S]earch current file" }
			)
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>n", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })
			vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<CR>", { desc = "Cheatsheet" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Find existing buffers" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = false,
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
