return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			require("dap-python").setup()

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

			local onOpen = function()
				dap.repl.open()
				vim.keymap.set("n", "<leader>c", dap.run_to_cursor)
				vim.keymap.set("n", "<up>", dap.step_back)
				vim.keymap.set("n", "<down>", dap.step_over)
				vim.keymap.set("n", "<right>", dap.step_into)
				vim.keymap.set("n", "<left>", dap.step_out)
				vim.keymap.set("n", "<CR>", dap.continue)
			end

			local onClose = function()
				dap.repl.close()
				vim.keymap.del("n", "<leader>c")
				vim.keymap.del("n", "<up>")
				vim.keymap.del("n", "<down>")
				vim.keymap.del("n", "<right>")
				vim.keymap.del("n", "<left>")
				vim.keymap.del("n", "<CR>")
			end

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
			dap.listeners.before.attach.dapui_config = onOpen
			dap.listeners.before.launch.dapui_config = onOpen
			dap.listeners.before.event_terminated.dapui_config = onClose
			dap.listeners.before.event_exited.dapui_config = onClose
		end,
	},
}
