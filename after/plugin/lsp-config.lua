require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "csharp_ls", "eslint" },
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	capabilities = capabilities,
})
lspconfig.csharp_ls.setup({
	capabilities = capabilities,
})
lspconfig.eslint.setup({
	capabilities = capabilities,
})
