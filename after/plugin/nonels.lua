local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.csharpier,
        null_ls.builtins.formatting.prettier,
	},
})

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
	vim.cmd("w")
end, {})
