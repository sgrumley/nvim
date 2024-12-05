---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
}

M.ui = {
	statusline = {
		enabled = true,
		theme = "default",
		separator_style = "round",
	},
	telescope = {
		style = "bordered",
	},
	lsp = {
		signature = true,
	},
	mason = {
		pkgs = {},
		skip = {},
	},
	colify = {
		enabled = true,
		mode = "virtual",
		virt_text = "󱓻 ",
		highlight = {
			hex = true,
			lspvars = true,
		},
	},

	-- needs to be explicit in disabling
	tabufline = {
		enabled = false,
	},
}

return M
