return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signcolumn = false,
			preview_config = { border = "none" },
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				vim.keymap.set("n", "]g", gs.next_hunk)
				vim.keymap.set("n", "[g", gs.prev_hunk)
				vim.api.nvim_buf_create_user_command(bufnr, "Signs", function(_)
					gs.toggle_signs()
				end, { desc = "Toggle git signs" })
				vim.api.nvim_buf_create_user_command(bufnr, "Blame", function(_)
					gs.blame_line({ full = true })
				end, { desc = "Git blame line" })
			end,
		},
	},
	{
		"tpope/vim-fugitive",
		config = function()
			vim.api.nvim_create_autocmd(
				"FileType",
				{ pattern = { "fugitiveblame" }, command = "nnoremap <buffer><silent> q :quit<CR>" }
			)
		end,
	},
}
