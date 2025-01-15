return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			require("todo-comments").setup({
				keywords = {
					-- TODO: example
					TODO = { icon = " ", color = "info" },
					-- NOTE: example
					NOTE = { icon = "󱞁 ", color = "hint", alt = { "INFO" } },
					-- TEST: example
					TEST = { icon = "󰙨 ", color = "warning", alt = { "TESTING", "PASSED", "FAILED" } },
					-- HACK: example
					HACK = { icon = " ", color = "warning" },
					-- WARN: example
					WARN = { icon = " ", color = "warning" },
					-- PERF: example
					PERF = { icon = "󰓅 " },
					-- FIX: example
					FIX = { icon = " ", color = "error", alt = { "BUG", "ISSUE" } },
				},
			})
		end,
	},
}
