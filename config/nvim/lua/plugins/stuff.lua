return {
	-- { dir = "~/dev/licorice", priority = 1000 },
	{
		"rspi/licorice.vim",
		priority = 1000,
		branch = "wip",
		config = function()
			vim.cmd("colorscheme licorice")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "numToStr/Comment.nvim", config = true },
	{ "kylechui/nvim-surround", config = true },
	"editorconfig/editorconfig-vim",
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				use_default_keymaps = false,
				keymaps = {
					["q"] = { "actions.close", mode = "n" },
					["<C-f><C-f>"] = { "actions.close", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-l>"] = "actions.select",
					["<C-h>"] = { "actions.parent", mode = "n" },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
				},
			})
			vim.keymap.set("n", "<C-f><C-f>", ":Oil<CR>", { silent = true, noremap = false })
		end,
	},
	{
		"rspi/silver.vim",
		config = function()
			vim.g.ag_command = "ag --smart-case"
		end,
	},
	{
		"rspi/git-stuff",
		dev = true,
		config = function()
			local git_stuff = require("git-stuff")
			vim.keymap.set("n", "]x", git_stuff.next_hunk, { desc = "Find files" })
		end,
	},
}
