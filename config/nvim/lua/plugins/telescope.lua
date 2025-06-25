return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-lua/plenary.nvim" },
	},
	opts = {
		defaults = {
			layout_strategy = "vertical",
			layout_config = { prompt_position = "top", preview_cutoff = 0 },
			sorting_strategy = "ascending",
			selection_caret = "  ",
			scroll_strategy = "limit",
			mappings = {
				i = { ["<C-e>"] = "preview_scrolling_down", ["<C-y>"] = "preview_scrolling_up" },
			},
		},
		pickers = {
			lsp_definitions = {
				show_line = false,
			},
			lsp_references = {
				show_line = false,
			},
			find_files = {
				previewer = false,
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local custom_pickers = require("telescope_pickers")
		telescope.setup(opts)
		telescope.load_extension("fzf")
		local builtin = require("telescope.builtin")

		local function get_visual_selection()
			local current_clipboard_content = vim.fn.getreg('"')
			vim.cmd('noau normal! "vy"')
			local text = vim.fn.getreg("v")
			vim.fn.setreg("v", {})
			vim.fn.setreg('"', current_clipboard_content)
			text = string.gsub(text, "\n", "")
			if #text > 0 then
				return text
			else
				return ""
			end
		end

		local function grep_visual_selection()
			local text = get_visual_selection()
			builtin.grep_string({ search = text })
		end

		vim.keymap.set("n", "<C-f><C-p>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<C-f><C-g>", custom_pickers.branch_files, { desc = "Find files on branch" })
		vim.keymap.set({ "v" }, "<C-f><C-w>", grep_visual_selection, { desc = "Search current selection" })
		vim.keymap.set({ "n" }, "<C-f><C-w>", builtin.grep_string, { desc = "Search current word" })
		vim.api.nvim_create_autocmd("User", { pattern = "TelescopePreviewerLoaded", command = "setlocal number" })
	end,
}
