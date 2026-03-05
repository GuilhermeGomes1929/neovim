vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
local undodir = os.getenv("UserProfile") 
    and (os.getenv("UserProfile") .. "\\AppData\\Local\\vim-data") -- Windows
    or (os.getenv("HOME") .. "/.vim/undodir")                     -- Linux/Mac

-- Cria o diretório caso ele não exista (evita erros de permissão)
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.undodir = undodir
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.g.airline_extensions_tabline_enabled = 1
vim.g["airline#extensions#tabline#formatter"] = 'unique_tail'
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_powerline_fonts = 1

vim.g.gruvbox_contrast_dark = "medium"

vim.opt.shellslash = true
