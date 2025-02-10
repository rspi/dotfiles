return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")
			local dap_python = require("dap-python").setup("<python venv path>")

			require("dapui").setup()
			table.insert(dap.configurations.python, {
				type = "debugpy",
				request = "attach",
				name = "Remote debugger",
				connect = {
					port = 5678,
					host = "127.0.0.1",
				},
				justMyCode = false,
				django = true,
				program = "${file}",
			})

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
