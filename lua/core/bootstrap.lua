local workspace = require("core.workspace.manager")

-- Save session on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		local path = workspace.detect_root()
		require("core.workspace.sessions").save(path)
	end,
})

-- Auto load workspace on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			local ws = workspace.detect_root()
			workspace.register(ws)
			require("core.workspace.sessions").load(ws)
		end
	end,
})
