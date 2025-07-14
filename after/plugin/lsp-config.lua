require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    "lua_ls", "csharp_ls", "eslint", "ts_ls", "html", "cssls", "rust_analyzer"
  },
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
lspconfig.ts_ls.setup({
	capabilities = capabilities,
})
lspconfig.html.setup({
	capabilities = capabilities,
})
lspconfig.cssls.setup({
	capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
})
