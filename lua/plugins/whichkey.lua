return {
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.add({
				{ "<leader>a", group = "󱡁 [A]rrow" },
				{ "<leader>c", group = "󰘦 [C]ode" },
				{ "<leader>d", group = " [D]ebug" },
				{ "<leader>f", group = "󰥨 [F]ind File" },
				{ "<leader>g", group = " [G]it" },
				{ "<leader>l", group = " [L]anguage" },
				{ "<leader>m", group = " [M]enu" },
				{ "<leader>n", group = "󰛏 [N]otification" },
				{ "<leader>s", group = " [S]earch" },
				{ "<leader>t", group = "󰙨 [T]esting" },
				{ "<leader>u", group = "󰹑 [U]I" },
				{ "<leader>w", group = " [W]indow Management" },
				{ "<leader>z", group = " Fold[Z]" },
			})
		end,
	},
}
