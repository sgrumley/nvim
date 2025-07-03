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
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = {
				["*"] = false,
			}
			-- vim.g.copilot_no_tab_map = true
			-- vim.g.copilot_assume_mapped = true
			-- vim.g.copilot_commit_on_enter = false
			-- vim.g.copilot_enable_snippet_in_insert_mode = true
			-- vim.g.copilot_suggestion_text_hl_group = "CopilotSuggestion"
		end,
	},
}
