local ui = {}
-- file path header
ui["utilyre/barbecue.nvim"] = {
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
	}
-- nicer cmd mode input
ui["VonHeikemen/fine-cmdline.nvim"] = {
		opts = {},
}

-- Status Line
ui["nvim-lualine/lualine.nvim"] = {
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
}

ui["folke/trouble.nvim"] = {
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
}
-- Theme: Catppuccin {{{
ui["catppuccin/nvim"] = {
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
}

return ui