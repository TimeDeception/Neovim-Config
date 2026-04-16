local M = {}

local session_dir = vim.fn.stdpath("data") .. "/sessions/"

local function session_path(path)
	return session_dir .. path:gsub("[/:]", "%%") .. ".vim"
end

local function ensure()
	if vim.fn.isdirectory(session_dir) == 0 then
		vim.fn.mkdir(session_dir, "p")
	end
end

function M.save(path)
	ensure()
	vim.cmd("mksession! " .. session_path(path))
end

function M.load(path)
	local file = session_path(path)
	if vim.fn.filereadable(file) == 1 then
		vim.cmd("silent source " .. file)
		return true
	end
	return false
end

return M
