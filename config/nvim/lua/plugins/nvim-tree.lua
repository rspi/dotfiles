return {
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			view = {
				mappings = {
					list = {
						{ key = "u", action = "dir_up" },
						{ key = "<C-e>", action = "" },
						{ key = "<C-y>", action = "" },
					},
				},
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			renderer = {
				group_empty = true,
				icons = {
					symlink_arrow = " -> ",
					show = {
						file = false,
						folder = false,
						git = false,
					},
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_closed = "▸",
							arrow_open = "▾",
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-tree").setup(opts)
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.api.nvim_set_keymap("n", "<C-f><C-f>", ":NvimTreeToggle<CR>", { silent = true, noremap = false })
			vim.api.nvim_set_keymap("n", "<C-f><C-r>", ":NvimTreeFindFile<CR>zz", { silent = true, noremap = false })
		end,
	},
}
