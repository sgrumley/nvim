return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			tailwindcss = {
				filetypes = { "templ", "astro", "javascript", "typescript", "react" },
				settings = {
					tailwindCSS = {
						includeLanguages = {
							temp = "html",
						},
					},
				},
			},
		},
	},
}
