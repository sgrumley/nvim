--[[
  File: init.lua
  Description: Entry point file for neovim
]]
 -- put this in your main init.lua file ( before lazy setup )
 vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- Bootstrap plugin manager
require("lazy-bootstrap")

-- Settings
require("config.keymaps")
require("config.options")
-- require("config.autocmds")

-- Plugin management
require("lazy").setup({
	{ import = "plugins.lsp" },
	{ import = "plugins.lang" },
	{ import = "plugins" },
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- To load all integrations at once
 for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
   dofile(vim.g.base46_cache .. v)
 end
-- require("config.go-test")
-- vim: ts=2 sts=2 sw=2 et
