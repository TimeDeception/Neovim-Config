-- ~/.config/nvim/lua/plugins/dap.lua
-- Debug Adapter Protocol for Python debugging
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
			{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
			{ "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
			{ "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup DAP UI
			dapui.setup()

			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Python debugger setup
			require("dap-python").setup("python3")

			-- Custom signs
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "debugPC", numhl = "" })
		end,
	},
}
