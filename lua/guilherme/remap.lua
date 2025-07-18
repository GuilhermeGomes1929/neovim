vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("n", "<leader>vs", ":vsplit<Enter>")
vim.keymap.set("n", "<leader>hs", ":split<Enter>")

vim.keymap.set("n", "<leader>q", ":q<Enter>")
vim.keymap.set("n", "<tab>", ":bnext<Enter>")
vim.keymap.set("n", "<s-tab>", ":bprevious<Enter>")
vim.keymap.set("n", "<leader>bc", function ()
    vim.cmd("NERDTreeClose")
    vim.cmd("bp|bd#")
end)
vim.keymap.set("n", "<leader>sc", function ()
    vim.cmd("NERDTreeClose")
    vim.cmd("bd")
end)

vim.keymap.set("n", "<c-f>", ":NERDTreeToggle<CR>")

-- Terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
vim.keymap.set("t", "<C-r>", ":ToggleTermSetName<CR>")
vim.keymap.set("n", "<leader>tr", ":ToggleTermSetName<CR>")
vim.keymap.set("n", "<leader>ts", ":TermSelect<CR>")
vim.keymap.set("n", "<leader>te", function ()
  local exec = vim.fn.input("Command > ")
  vim.cmd("TermExec cmd=\"" .. exec .. "\"")
end)
vim.keymap.set("n", "<leader>tv", ":ToggleTermSendVisualLines<CR>")
vim.keymap.set("n", "<leader>tl", ":ToggleTermSendCurrentLine<CR>")

-- Lsp
vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
end, {})
vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
end, {})
vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
end, {})
vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
end, {})
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
end, {})
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
end, {})
vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, {})
vim.keymap.set("n", "<leader>vrr", function()
    vim.lsp.buf.references()
end, {})
vim.keymap.set("n", "<leader>vrf", function()
    vim.lsp.buf.rename()
end, {})
vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end, {})
vim.keymap.set("n", "<leader>bf", function ()
    vim.lsp.buf.format()
end)

-- Snippets
local ls = require("luasnip")

vim.keymap.set("i", "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})


-- Close Buffers
vim.keymap.set("n", "<leader>ba", function()
	vim.cmd("Bdelete all")
end)
vim.keymap.set("n", "<leader>bh", function()
	vim.cmd("Bdelete hidden")
end)
vim.keymap.set("n", "<leader>bo", function()
	vim.cmd("Bdelete other")
end)
