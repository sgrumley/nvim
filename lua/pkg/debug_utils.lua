local M = {}

-- TreeSitter queries
local tests_query = [[
(function_declaration
  name: (identifier) @testname
  parameters: (parameter_list
    . (parameter_declaration
      type: (pointer_type) @type) .)
  (#match? @type "*testing.(T|M)")
  (#match? @testname "^Test.+$")) @parent
]]

local subtests_query = [[
(call_expression
  function: (selector_expression
    operand: (identifier)
    field: (field_identifier) @run)
  arguments: (argument_list
    (interpreted_string_literal) @testname
    [
     (func_literal)
     (identifier)
    ])
  (#eq? @run "Run")) @parent
]]

function M.run_go_table_test()
	-- Get the current line
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	-- Find the string under cursor (between quotes)
	local before = line:sub(1, col + 1):reverse()
	local after = line:sub(col + 1)

	local s1 = before:find('"')
	local s2 = after:find('"')

	if not s1 or not s2 then
		vim.notify("No string found under cursor", vim.log.levels.ERROR)
		return
	end

	-- Extract case name without quotes and trim whitespace
	local case_name = line:sub(col + 2 - s1, col + s2 - 1):gsub('"', "")

	local current_func = M.get_closest_test()

	-- Format full test name for dap-go
	local full_test_name = string.format("%s/%s", current_func, case_name)
	require("noice").notify("Debugging test: " .. full_test_name, "info", {
		title = "Go Test Debug",
		timeout = 2000,
	})

	local dir_path = M.get_test_path()
	local ok, dap = pcall(require, "dap")
	assert(ok, string.format("dap-go dependency error: %s not installed", "dap"))

	local config = {
		type = "go",
		name = full_test_name,
		request = "launch",
		mode = "test",
		program = dir_path,
		args = { "-test.run", "^" .. full_test_name .. "$" },
		-- outputMode is what allows REPL to show the logs
		outputMode = "remote",
	}

	-- verbose mode adds extra text e.g. test meta
	local extra_args = { "-test.v" }
	table.move(extra_args, 1, #extra_args, #config.args + 1, config.args)

	dap.run(config)
end

local function is_parent(dest, source)
	if not (dest and source) then
		return false
	end
	if dest == source then
		return false
	end

	local current = source
	while current ~= nil do
		if current == dest then
			return true
		end
		current = current:parent()
	end
	return false
end

local function format_subtest(testcase, test_tree)
	local parent
	if testcase.parent then
		for _, curr in pairs(test_tree) do
			if curr.name == testcase.parent then
				parent = curr
				break
			end
		end
		return string.format("%s/%s", format_subtest(parent, test_tree), testcase.name)
	else
		return testcase.name
	end
end

local function get_closest_above_cursor(test_tree)
	local result
	for _, curr in pairs(test_tree) do
		if not result then
			result = curr
		else
			local node_row1, _, _, _ = curr.node:range()
			local result_row1, _, _, _ = result.node:range()
			if node_row1 > result_row1 then
				result = curr
			end
		end
	end
	if result then
		return format_subtest(result, test_tree)
	end
	return nil
end

function M.get_test_path()
	local test_dir = vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
	return "./" .. test_dir
end

function M.get_closest_test()
	local stop_row = vim.api.nvim_win_get_cursor(0)[1]
	local ft = vim.api.nvim_buf_get_option(0, "filetype")
	assert(ft == "go", "can only find test in go files, not " .. ft)
	local parser = vim.treesitter.get_parser(0)
	local root = (parser:parse()[1]):root()

	local test_tree = {}

	local test_query = vim.treesitter.query.parse(ft, tests_query)
	assert(test_query, "could not parse test query")
	for _, match, _ in test_query:iter_matches(root, 0, 0, stop_row, { all = true }) do
		local test_match = {}
		for id, nodes in pairs(match) do
			for _, node in ipairs(nodes) do
				local capture = test_query.captures[id]
				if capture == "testname" then
					local name = vim.treesitter.get_node_text(node, 0)
					test_match.name = name
				end
				if capture == "parent" then
					test_match.node = node
				end
			end
		end
		table.insert(test_tree, test_match)
	end

	local subtest_query = vim.treesitter.query.parse(ft, subtests_query)
	assert(subtest_query, "could not parse test query")
	for _, match, _ in subtest_query:iter_matches(root, 0, 0, stop_row, { all = true }) do
		local test_match = {}
		for id, nodes in pairs(match) do
			for _, node in ipairs(nodes) do
				local capture = subtest_query.captures[id]
				if capture == "testname" then
					local name = vim.treesitter.get_node_text(node, 0)
					test_match.name = string.gsub(string.gsub(name, " ", "_"), '"', "")
				end
				if capture == "parent" then
					test_match.node = node
				end
			end
		end
		table.insert(test_tree, test_match)
	end

	table.sort(test_tree, function(a, b)
		return is_parent(a.node, b.node)
	end)

	for _, parent in ipairs(test_tree) do
		for _, child in ipairs(test_tree) do
			if is_parent(parent.node, child.node) then
				child.parent = parent.name
			end
		end
	end

	return get_closest_above_cursor(test_tree)
end

return M
