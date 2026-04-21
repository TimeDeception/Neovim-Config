local M = {}

function M.open_project(path)
	local expanded = vim.fn.expand(path)

	-- 🔥 THIS is the missing core behavior
	vim.cmd("cd " .. expanded)
	vim.cmd("lcd " .. expanded)

	vim.notify("Switched to project: " .. expanded)

	-- open file picker in new root
	require("telescope.builtin").find_files({
		cwd = expanded,
	})
end

return M
