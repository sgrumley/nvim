--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootstrap plugin manager
require("lazy-bootstrap")

-- Settings
require("config.keymaps")
require("config.options")
-- unsure about these
-- require("config.autocmds")

-- Plugin management
require("lazy").setup({
	{ import = "plugins.dashboard" },
	{ import = "plugins.lsp.lspconfig" },
	{ import = "plugins.lsp.formatting" },
	{ import = "plugins" },
	{ import = "plugins.lang" },
}, {})

-- require("config.go-test")
