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
	-- syntax, replace with tree-sitter?
	"pangloss/vim-javascript",
	"othree/html5.vim",
	"jbyuki/quickmath.nvim",
	"hail2u/vim-css3-syntax",
	{
		"vim-python/python-syntax",
		config = function()
			vim.g.python_highlight_all = 1
		end,
	},
	"peitalin/vim-jsx-typescript",
	"ekalinin/Dockerfile.vim",
	--
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
				keymaps = {
					["<C-f><C-f>"] = { "actions.close", mode = "n" },
					["q"] = { "actions.close", mode = "n" },
					["<C-u>"] = { "actions.parent", mode = "n" },
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
