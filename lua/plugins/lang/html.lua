return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {
					filetypes = { "html", "templ" },
				},
			},
		},
	},
}

--[[
 Example layout of how I want to structure language specific things
 The dir will require an init where it loops over each file in the dir and appends a table of plugins for lazy
local M = {}

M.helpers = {
	-- this will just be functions relevant to the language. e.g. setting specific keymaps, custom functions ...
}
M.plugins = {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			html = {
				filetypes = { "html", "templ" },
			},
		},
	},
}

return M
]]
