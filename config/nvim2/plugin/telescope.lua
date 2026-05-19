vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "telescope-fzf-native.nvim" then
      vim.notify("Compiling fzf-native...", vim.log.levels.INFO)
      vim.fn.system({ "make", "-C", ev.data.path })
    end
  end,
})

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
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
})

telescope.load_extension("fzf")

local function get_branch_files()
  local base = vim.fn.systemlist({ "git", "rev-parse", "--abbrev-ref", "origin/HEAD" })[1]
  if vim.v.shell_error ~= 0 or not base or base:match("origin/HEAD") then
    base = "HEAD"
  end
  local merge_base = vim.fn.systemlist({ "git", "merge-base", "HEAD", base })[1]
  return vim.fn.systemlist({ "git", "diff", merge_base, "--name-only" })
end

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

local function branch_files_picker(opts)
  local results = get_branch_files()

  if #results == 0 or (results[1] and results[1]:match("^fatal")) then
    vim.notify("No changes found or not a git repo.", vim.log.levels.INFO)
    return
  end

  require("telescope.pickers").new(opts or {}, {
    prompt_title = "Git Branch Files",
    finder = require("telescope.finders").new_table(results),
    sorter = require("telescope.config").values.generic_sorter(opts),
  }):find()
end

vim.keymap.set("n", "<C-f><C-f>", builtin.resume, { desc = "Telescope resume" })
vim.keymap.set("n", "<C-f><C-p>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<C-f><C-g>", branch_files_picker, { desc = "Find files on branch" })
vim.keymap.set("n", "<C-f><C-r>", builtin.live_grep, { desc = "Find with Ripgrep" })
vim.keymap.set("v", "<C-f><C-w>", grep_visual_selection, { desc = "Search current selection" })
vim.keymap.set("n", "<C-f><C-w>", builtin.grep_string, { desc = "Search current word" })

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.opt_local.number = true
  end,
})

