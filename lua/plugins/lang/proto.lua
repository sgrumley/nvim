return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "proto" })
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "buf" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				buf = {},
			},
		},
	},
}
