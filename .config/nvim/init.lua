
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

-- whitespace
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

require("config.lazy")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when Yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true}),
  callback = function()
    vim.highlight.on_yank()
  end,
})
