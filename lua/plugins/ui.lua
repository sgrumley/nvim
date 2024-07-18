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
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			-- local highlight = {
			-- 	"Rosewater",
			-- 	"Mauve",
			-- 	"Peach",
			-- 	"Green",
			-- 	"Lavendar",
			-- }

			-- local hooks = require("ibl.hooks")
			-- -- create the highlight groups in the highlight setup hook, so they are reset
			-- -- every time the colorscheme changes
			-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- 	vim.api.nvim_set_hl(0, "Rosewater", { fg = "#f5e0dc" })
			-- 	vim.api.nvim_set_hl(0, "Mauve", { fg = "#cba6f7" })
			-- 	vim.api.nvim_set_hl(0, "Peach", { fg = "#fab387" })
			-- 	vim.api.nvim_set_hl(0, "Green", { fg = "#a6e3a1" })
			-- 	vim.api.nvim_set_hl(0, "Lavendar", { fg = "#b4befe" })
			-- end)

			-- require("ibl").setup({ indent = { highlight = highlight } })
			require("ibl").setup()
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
		opts = {},
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
		enabled = true,
		priority = 1000,
		config = function()
			local catppuccin = require("catppuccin")

			catppuccin.setup({
				flavour = "mocha",
				term_color = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					native_lsp = { enabled = true },
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
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
