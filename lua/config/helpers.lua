-- Alias for function, that set new keybindings
local map = vim.api.nvim_set_keymap

-- Normal mode keybinding setter
function nmap(keys, func, desc)
	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

-- Input mode keybinding setter
function imap(keys, func, desc)
	vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
end

-- Visual mode keybinding setter
function vmap(keys, func, desc)
	vim.keymap.set("v", keys, func, { buffer = bufnr, desc = desc })
end

-- Terminal mode keybinding setter
function tmap(keys, func, desc)
	vim.keymap.set("t", keys, func, { buffer = bufnr, desc = desc })
end

-- goto diagnostic severities
function diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
