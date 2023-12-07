--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {
    -- Git {{{
      {'tpope/vim-fugitive'},
      {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
      },
      {
          -- Adds git related signs to the gutter, as well as utilities for managing changes
          'lewis6991/gitsigns.nvim',
          config = function()
            require "extensions.gitsigns"
          end
        },
    --  }}}

  -- WhichKey {{{
    { 
      'folke/which-key.nvim',
      config = function()
        require "extensions.whichkey"
      end
    },
  -- }}}

  -- Notifications?{{
    {
      "folke/noice.nvim",
      dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      },
      event = "VeryLazy",
      enabled = true,
      opts = {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              find = "%d+L, %d+B",
            },
            view = "mini",
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      },
      --stylua: ignore
      keys = {
        { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
        { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
        { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
      },
    },
  -- }}

  -- UI {{{
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
          vim.keymap.set("n", "<leader>uo", 
          "<cmd>SymbolsOutline<CR>", 
          {
            noremap = true, 
            silent = true, 
            desc = "Toggle Symbol [O]utline"
          })
        end
      }, 
      {
      -- MINIMAP
      "gorbit99/codewindow.nvim",
      config = function()
        require("codewindow").setup({
          auto_enable = true,
          use_treesitter = true,           -- disable to lose colours
          exclude_filetypes = {
            "Outline", "neo-tree", "qf", "packer", "help", "noice",
            "Trouble"
          }
        })
        vim.keymap.set("n", "<leader>um",
          "<cmd>lua require('codewindow').toggle_minimap()<CR>",
          {
            noremap = true,
            silent = true,
            desc = "Toggle minimap"
          })
      end
    },
  -- }}}

  -- Quality Of Life {{{
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
        "nvim-tree/nvim-web-devicons", -- optional dependency
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
      'rmagatti/goto-preview',
      config = function()
        require "extensions.goto"
      end
    },
    -- auto pairs
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {}, -- this is equalent to setup({}) function
    },
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },
    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      main = 'ibl',
      opts = {},
    },
  -- }}}

  -- Status Line {{{
    {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
        options = {
          icons_enabled = true,
          theme = 'catppuccin',
          component_separators = '|',
          section_separators = '',
        },
      },
    },
  -- }}}

  -- Neo Tree {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require "extensions.neotree"
    end
  },
  -- }}}

  -- Telescope {{{
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require "extensions.telescope"
    end
  },
  -- }}}

  --- Terminal {{{
  {'akinsho/toggleterm.nvim', version = "*", opts = {}},
  -- }}}

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
    'catppuccin/nvim',
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
    -- }}}

}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
