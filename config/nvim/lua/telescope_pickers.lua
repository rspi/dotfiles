local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

local files_from_git_cmd = function(cmd)
	local handle = io.popen(cmd)
	local files = {}
	if handle == nil then
		print("could not run specified command")
		return files
	end
	local result = handle:read("*a")
	handle:close()

	for token in string.gmatch(result, "[^%c]+") do
		files[token] = true
	end
	return files
end

function M.branch_files(opts)
	opts = opts or {}

	local branch_name = opts.branch_name or "origin/prod"
	local branch_files = files_from_git_cmd(
		"git diff --name-only $(git merge-base HEAD " .. branch_name .. " 2>/dev/null).. 2>/dev/null"
	)
	local diff_files = files_from_git_cmd("git diff HEAD --name-only 2>/dev/null")
	local results = vim.tbl_keys(vim.tbl_extend("keep", branch_files, diff_files))

	pickers
		.new(opts, {
			prompt_title = "Git branch files + diff",
			finder = finders.new_table(results),
			sorter = conf.generic_sorter(opts),
		})
		:find()
end

return M
