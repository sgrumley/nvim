return {
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - saaw) - [S]urround [A]dd [A]round [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- status
			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = true })

			-- scope
			local indent = require("mini.indentscope")
			indent.setup({
				symbol = "│",
			})
		end,
	},
}
