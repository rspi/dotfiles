return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, bufnr)
					return name == ".."
				end,
			},
			use_default_keymaps = false,
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-l>"] = "actions.select",
				["<C-h>"] = { "actions.parent", mode = "n" },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
			},
		})
		vim.keymap.set("n", "<C-f><C-o>", ":Oil<CR>", { silent = true, noremap = false })
	end,
}
