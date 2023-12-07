return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
          { "j-hui/fidget.nvim", config = true },
          "williamboman/mason.nvim",
          "williamboman/mason-lspconfig.nvim",
        },
        opts = {
          servers = {},
          setup = {},
          format = {
            timeout_ms = 3000,
          },
        },
        config = function(plugin, opts)
          require("helpers.servers").setup(plugin, opts)
        end,
      },
}