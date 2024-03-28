local lsp = {}

-- might use this later in editor
-- lsp["kevinhwang91/nvim-bqf"] = {
-- 	lazy = true,
-- 	ft = "qf",
-- 	config = require("lsp.bqf"),
-- 	dependencies = {
-- 		{ "junegunn/fzf", build = ":call fzf#install()" },
-- 	},
-- }

-- completion

lsp["hrsh7th/nvim-cmp"] = {
    lazy=true 
    event ="InsertEnter" 
    dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
    }
    config = require("lsp.nvim-cmp")
}

lsp["L3MON4D3/LuaSnip"] = {
    lazy=true ,
    build = "make install_jsregex",
    config = require("lsp.luasnip"),
}

-- formatting

lsp["stevearc/conform.nvim"] = {
    lazy=true 
    event = {"BufReadPre", "BufNewFile"},
    config = require("lsp.conform"),
}

-- linting

lsp["mfussenegger/nvim-lint"] = {
    lazy=true
	event = { "BufReadPre", "BufNewFile" },
    config = require("lsp.nvim-lint")
}

-- lsp
lsp["neovim/nvim-lspconfig"] = {
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = require("lsp.lspconfig")
}

lsp["williamboman/mason.nvim"] = {

}

lsp["nvim-treesitter/nvim-treesitter"] = {
"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
        config = require("lsp.treesitter")
}