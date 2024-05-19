return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup({
			mappings = {
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = false,
			},
		})
	end,
}
