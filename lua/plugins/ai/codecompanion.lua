-- consider extending with MCP Hub https://github.com/ravitemer/mcphub.nvim
-- on setup use :Copilot setup to configure auth
-- https://codecompanion.olimorris.dev/usage/inline-assistant.html#classification
-- TODO: look at making my own prompt templates for things like tests
return {
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"github/copilot.vim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
