return {
	{
		"stevearc/oil.nvim",
		opts = {},
		config = function()
			local oil = require("oil")
			oil.setup({
				float = {
					max_width = 110,
					max_height = 25,
				},
				keymaps = {
					["q"] = "actions.close",
				},
			})
			vim.keymap.set("n", "-", oil.toggle_float, { desc = "Oil" })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- - up a dir
		-- _ current working dir
		-- g. toggle hidden
		-- g\\ toggle trash
		-- gs change sort
		-- <C-p> preview
		-- <C-c> close
		-- <C-l> refresh
	},
}
