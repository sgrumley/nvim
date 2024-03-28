local tools = {}
-- Tooling
-- Database Client
{
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}

-- GRPC Client
["hudclark/grpc-nvim"] = { 
	dependencies = { { "nvim-lua/plenary.nvim" } },
}

-- REST Client
tooling["rest-nvim/rest.nvim"]{
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = require("tools.rest-nvim"),
}

-- WhichKey
tools["folke/which-key.nvim"] =	{
	config = require("plugins.config.whichkey"),
}