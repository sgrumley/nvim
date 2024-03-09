return {
	-- Navigation
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = function()
			require("plugins.config.harpoon")
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = function()
			require("plugins.config.flash")
		end,
	},
	-- Git
	{
		"sindrets/diffview.nvim",
	},
	{ "tpope/vim-fugitive" },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.config.gitsigns")
		end,
	},
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
	},
	-- GRPC Client
	{
		"hudclark/grpc-nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- REST Client
	{
		"rest-nvim/rest.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("rest-nvim").setup({})
		end,
	},

	-- WhichKey
	{
		"folke/which-key.nvim",
		config = function()
			require("plugins.config.whichkey")
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
			return require("plugins.config.noice").opts
		end,
		keys = function()
			return require("plugins.config.noice").keys
		end,
	},

	-- UI
	{
		-- DOCUMENT/CODE SYNTAX TREE
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				-- autofold_depth = 1, -- h: close, l: open, W: close all, E: open all
				auto_close = false,
				highlight_hovered_item = true,
				position = "left",
				width = 15,
			})
			vim.keymap.set("n", "<leader>uo", "<cmd>SymbolsOutline<CR>", {
				noremap = true,
				silent = true,
				desc = "Toggle Symbol [O]utline",
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
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
	{
		-- MINIMAP
		-- TODO: replace with scroll bar
		"petertriho/nvim-scrollbar",
		opts = {},
		config = {},
	},

	-- Quality Of Life
	{
		"RRethy/vim-illuminate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {},
	},
	-- comment
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
		config = function(_, _)
			local opts = {
				ignore = "^$",
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
			require("Comment").setup(opts)
		end,
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
	},
	-- nicer cmd mode input
	{
		"VonHeikemen/fine-cmdline.nvim",
		opts = {},
	},
	-- peek definitions
	{
		"rmagatti/goto-preview",
		config = function()
			require("plugins.config.goto")
		end,
	},
	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},

	-- Status Line
	{
		-- Set lualine as statusline
		"nvim-lualine/lualine.nvim",
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	-- Neo Tree / could be replaced oil {{{
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.config.neotree")
		end,
	},

	-- Theme: Atom One Dark {{{
	-- {
	--   'navarasu/onedark.nvim',
	--   priority = 1000,
	--   config = function()
	--     vim.cmd.colorscheme 'onedark'
	--   end,
	-- },
	-- }}}

	-- Theme: Catppuccin {{{
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	-- }}}
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
