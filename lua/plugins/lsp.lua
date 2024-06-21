return {
	{},
	-- {
	-- 		"neovim/nvim-lspconfig",
	-- 		dependencies = {
	-- 			-- Automatically install LSPs and related tools to stdpath for neovim
	-- 			"williamboman/mason.nvim",
	-- 			"williamboman/mason-lspconfig.nvim",
	-- 			"WhoIsSethDaniel/mason-tool-installer.nvim",

	-- 			{ "j-hui/fidget.nvim", opts = {} },
	-- 		},
	-- 		config = require("plugins.config.lsp.lspconfig").config
	--   },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = require("plugins.config.lsp.cmp"),
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = require("plugins.config.lsp.luasnip").dependencies,
		build = "make install_jsregexp",
		opts = require("plugins.config.lsp.luasnip").opts,
		keys = require("plugins.config.lsp.luasnip").keys,
		config = function(_, opts)
			require("luasnip").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = require("plugins.config.lsp.treesitter").opts,
		config = require("plugins.config.lsp.treesitter").config,
	},
}
