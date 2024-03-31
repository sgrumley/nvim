local editor = {}
-- Navigation
editor["ThePrimeagen/harpoon"]	= {
		dependencies = { "nvim-lua/plenary.nvim" },
		-- keys = function()
		-- 	require("plugins.config.harpoon")
		-- end,
},
	
editor["folke/flash.nvim"] = {
		event = "VeryLazy",
		-- keys = function()
		-- 	require("plugins.config.flash")
		-- end,
},

-- Git

editor["sindrets/diffview.nvim"] = {}

editor[ "tpope/vim-fugitive" ] = {}

editor["lewis6991/gitsigns.nvim" ] = {
		config = require("plugins.config.gitsigns")
}


editor["folke/noice.nvim"] = {
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		enabled = true,
		opts = function()
			return require("plugins.config.noice").opts
		end,
		-- keys = function()
		-- 	return require("plugins.config.noice").keys
		-- end,
	}


editor["stevearc/dressing.nvim"] = {
		lazy = true,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

editor["petertriho/nvim-scrollbar"] = {
		opts = {},
		config = {},
	}

-- comment
editor["numToStr/Comment.nvim"] = {
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		-- keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
		-- config = function(_, _)
		-- 	local opts = {
		-- 		ignore = "^$",
		-- 		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		-- 	}
		-- 	require("Comment").setup(opts)
		-- end,
}
	
	-- peek definitions
editor["rmagatti/goto-preview"] = {
		config = function()
			require("plugins.config.goto")
		end,
}
	-- auto pairs
editor["windwp/nvim-autopairs"] = {
		event = "InsertEnter",
		opts = {},
}

editor["tpope/vim-sleuth"] = {}
editor["numToStr/Comment.nvim"] = {
 	opts = {} 
}
editor["folke/todo-comments.nvim"] = {
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
}

editor["nvim-neo-tree/neo-tree.nvim"] = {
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.config.neotree")
		end,
}

return editor