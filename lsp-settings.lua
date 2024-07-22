-- LSP settings
-- lsp diagnostics (signs)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- lsp diagnostics (messages)
local function setup_lsp_diags()
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
	})
end
-- conform.nvim specify formatters
local conform = require("conform")

local function setFormat(filetypes, formatter)
	local config = {}
	for _, filetype in ipairs(filetypes) do
		config[filetype] = { formatter }
	end
	return config
end

local config = {
	go = { "gofmt" },
	python = { { "ruff_format", "black" } },
	lua = { "stylua" },
	shell = { "shfmt" },
}

config = vim.tbl_extend(
	"keep",
	config,
	setFormat({
		"javascript",
		"javascriptreact",
		"html",
		"json",
		"markdown",
		"toml",
		"typescript",
		"typescriptreact",
		"yaml",
	}, "prettier")
)
conform.setup({
	formatters_by_ft = config,
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
})
-- conform.nvim format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ async = true, lsp_fallback = true, bufnr = args.buf })
	end,
})
-- nvim-lint
require("lint").linters_by_ft = {
	go = { "golangcilint" },
	html = { "tidy" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	json = { "jsonlint" },
	lua = { "luacheck" },
	markdown = { "markdownlint" },
	python = { "ruff" },
	sh = { "shellcheck" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	xml = { "tidy" },
	yaml = { "yamllint" },
}
-- nvim-lint activate linting
vim.api.nvim_create_autocmd({ "InsertLeave", "BufNewFile", "BufRead" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})
-- nvim-cmp setup
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			-- fancy icons and a name of kind
			vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
			-- set a name for each source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				look = "[Look]",
				path = "[Path]",
				spell = "[Spell]",
				calc = "[Calc]",
				emoji = "[Emoji]",
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "treesitter", max_item_count = 10 },
		{ name = "buffer", max_item_count = 10 },
		{ name = "path", max_item_count = 10 },
	},
})
-- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
