--[[
  File: ui.lua
  Description: This is for plugins related to the UI. These are indepentant of functionality
]]
local function moons()
	return [[          ]]
end

return {
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.config.ui.whichkey")
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		enabled = true,
		opts = function()
			return require("plugins.config.ui.noice").opts
		end,
		keys = function()
			return require("plugins.config.ui.noice").keys
		end,
	},
	{
		-- MINIMAP
		"petertriho/nvim-scrollbar",
		opts = {},
		config = {},
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"RRethy/vim-illuminate",
	},
	-- alternative to neotree
	{
		"stevearc/oil.nvim",
		opts = {},
		config = function()
			local oil = require("oil")
			oil.setup()
			vim.keymap.set("n", "-", oil.toggle_float, {})
		end,
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.config.ui.neotree")
		end,
	},
	-- Status Line
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = " ",
			},
			sections = {
				lualine_c = {
					"%=",
					{ moons },
				},
			},
		},
	},
	-- file path header
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			-- configurations go here
		},
		-- config = function()
		-- 	theme = "catppuccin",
		-- end,
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		integrations = {
			cmp = true,
			gitsigns = true,
			treesitter = true,
			harpoon = true,
			dap = true,
			dap_ui = true,
			noice = true,
			telescope = {
				enabled = true,
			},
			illuminate = {
				enabled = true,
				lsp = false,
			},
		},
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		-- config = function()
		-- 	require('plugins.config.catppuccin')
		-- end,
	},
}
