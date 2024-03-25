return function()
	require("modules.utils").load_plugin("ibl", {
		enabled = true,
		debounce = 200,
		indent = {
			char = "│",
			tab_char = "│",
			smart_indent_cap = true,
			priority = 2,
		},
		whitespace = { remove_blankline_trail = true },
		-- Note: Scope requires treesitter to be set up
		scope = {
			enabled = true,
			char = "┃",
			show_start = false,
			show_end = false,
			injected_languages = true,
			priority = 1000,
			include = {
				node_type = {
					["*"] = {
						"argument_list",
						"arguments",
						"assignment_statement",
						"Block",
						-- "chunk",
						"class",
						"ContainerDecl",
						"dictionary",
						"do_block",
						"do_statement",
						"element",
						"except",
						"FnCallArguments",
						"for",
						"for_statement",
						"function",
						"function_declaration",
						"function_definition",
						"if_statement",
						"IfExpr",
						"IfStatement",
						"import",
						"InitList",
						"list_literal",
						"method",
						"object",
						"ParamDeclList",
						"repeat_statement",
						"selector",
						"SwitchExpr",
						"table",
						"table_constructor",
						"try",
						"tuple",
						"type",
						"var",
						"while",
						"while_statement",
						"with",
					},
				},
			},
		},
		exclude = {
			filetypes = {
				"", -- for all buffers without a file type
				"aerial",
				"alpha",
				"big_file_disabled_ft",
				"dashboard",
				"dotooagenda",
				"flutterToolsOutline",
				"fugitive",
				"git",
				"gitcommit",
				"help",
				"json",
				"log",
				"markdown",
				"NvimTree",
				"peekaboo",
				"startify",
				"TelescopePrompt",
				"todoist",
				"txt",
				"undotree",
				"vimwiki",
				"vista",
			},
			buftypes = { "terminal", "nofile", "quickfix", "prompt" },
		},
	})
end
