vim.opt.relativenumber=true
vim.opt.number=true
vim.opt.scrolloff=12
vim.opt.expandtab=true
vim.opt.smarttab=true
vim.opt.shiftwidth=2
vim.opt.tabstop=2

-- Linebreak on 500 characters
vim.opt.linebreak=true
vim.opt.textwidth=500
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.wrap=true
vim.opt.cursorline=true
vim.opt.ignorecase=true
vim.opt.history=500

-- Turn on the Wild menu
vim.opt.wildmenu=true

-- Plugins
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'dhruvasagar/vim-table-mode'
Plug 'mxw/vim-jsx'
Plug 'preservim/NERDTree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Press `+` to expand the visual selection and `-` to shrink it
Plug 'terryma/vim-expand-region'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

Plug('morhetz/gruvbox', {
  ['do'] = function()
    vim.opt.termguicolors = true
    vim.cmd('colorscheme gruvbox')
  end
})

vim.call('plug#end')

vim.cmd('colorscheme gruvbox')

