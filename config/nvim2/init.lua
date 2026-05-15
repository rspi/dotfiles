
-- Options

vim.g.mapleader = ","

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.exrc = true -- Loads local project config files

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.laststatus = 0 -- hide status line
vim.opt.ruler = false -- hide right side line/column number

vim.opt.scrolloff = 2

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.linebreak = true


vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keymaps

vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

vim.keymap.set({ 'n', 'v' }, '<C-e>', '2<C-e>')
vim.keymap.set({ 'n', 'v' }, '<C-y>', '2<C-y>')

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<C-c>', '<Cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-h>', 'gT')
vim.keymap.set('n', '<C-l>', 'gt')
vim.keymap.set('n', 'gT', '<Cmd>-tabmove<CR>')
vim.keymap.set('n', 'gt', '<Cmd>+tabmove<CR>')


vim.keymap.set('n', '*', function()
  local word = vim.fn.expand('<cword>')
  vim.fn.setreg('/', '\\<' .. word .. '\\>')
  vim.v.hlsearch = 1
end)


-- Commands

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(event)
    vim.keymap.set('n', 'q', '<Cmd>q<CR>', { buffer = event.buf, silent = true })
  end,
})

-- Resize splits when the window is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function() vim.cmd("wincmd =") end,
})
