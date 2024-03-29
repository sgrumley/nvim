return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"sql",
				})
			end
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				sqlls = {},
				-- postgres_lsp = {}, -- requires installing executabel to path
			},
		},
	},
	-- { TODO: replace with nvim-lint + conform
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	opts = function(_, opts)
	-- 		if type(opts.sources) == "table" then
	-- 			local null_ls = require("null-ls")
	-- 			vim.list_extend(opts.sources, {
	-- 				null_ls.builtins.formatting.terraform_fmt,
	-- 				null_ls.builtins.diagnostics.terraform_validate,
	-- 			})
	-- 		end
	-- 	end,
	-- },
}
