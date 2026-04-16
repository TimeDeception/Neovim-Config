local M = {}

function M.pick()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local projects = require("core.workspace.projects").get_projects()

	pickers.new({}, {
		prompt_title = "Projects",
		finder = finders.new_table({
			results = projects,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.name,
					ordinal = entry.name,
				}
			end,
		}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)

				local selection = action_state.get_selected_entry()
				local project = selection.value
				local path = vim.fn.expand(project.path)

				-- 🔥 THE IMPORTANT PART
				vim.cmd("cd " .. path)
        vim.cmd("lcd " .. path)

				vim.notify("Switched to " .. project.name)

				-- Open Telescope inside project
				require("telescope.builtin").find_files({
					cwd = path,
				})
			end)

			return true
		end,
	}):find()
end

return M
