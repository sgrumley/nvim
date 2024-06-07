-- TODO: this needs to be able to get the go package name or test name to pass in.
-- needs some work to get running
local function run_go_tests()
	-- Get the current buffer's file name
	local file_name = vim.fn.expand("%")
	-- Define the Go test command for the current file
	local go_test_cmd = "go test -run " .. file_name .. " -json | tparse"

	-- Execute the Go test command and capture the output
	vim.fn.jobstart(go_test_cmd, {
		on_stdout = function(_, data)
			-- Create a new buffer for the test output or switch to it if it already exists
			local buffer_name = "GoTestOutput"
			local bufnr = vim.fn.bufnr(buffer_name)
			if bufnr == -1 then
				-- Buffer does not exist, create it
				vim.cmd("new " .. buffer_name)
				bufnr = vim.api.nvim_get_current_buf()
				vim.api.nvim_buf_set_name(bufnr, buffer_name)
			else
				-- Switch to the existing buffer
				vim.cmd(bufnr .. "buffer")
			end

			-- If data is not nil or empty, append it to the buffer
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { line })
					end
				end
			end
		end,
		on_stderr = function(_, data)
			-- Handle potential errors (similar to stdout handling)
			if data then
				local bufnr = vim.fn.bufnr("GoTestOutput")
				if bufnr ~= -1 then
					for _, line in ipairs(data) do
						if line ~= "" then
							vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { line })
						end
					end
				end
			end
		end,
		stdout_buffered = true,
		stderr_buffered = true,
	})
end

-- Register the function as a Neovim command
vim.api.nvim_create_user_command("GoTestCurrentFile", run_go_tests, {})
