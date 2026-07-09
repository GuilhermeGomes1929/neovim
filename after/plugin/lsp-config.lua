local status, mason = pcall(require, "mason")
if not status then
    return -- Para a execução se o mason não estiver instalado
end
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    "lua_ls", "csharp_ls", "eslint", "ts_ls", "html", "cssls", "rust_analyzer", "jdtls"
  },
})

-- Configurar capabilities
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
    return
end
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Usar a nova API vim.lsp.config() do Neovim v0.11+
-- Configuração para lua_ls
vim.lsp.config('lua_ls', {
	capabilities = capabilities,
})

-- Configuração para csharp_ls
vim.lsp.config('csharp_ls', {
	capabilities = capabilities,
})

-- Configuração para eslint
vim.lsp.config('eslint', {
	capabilities = capabilities,
})

-- Configuração para ts_ls
vim.lsp.config('ts_ls', {
	capabilities = capabilities,
})

-- Configuração para html
vim.lsp.config('html', {
	capabilities = capabilities,
})

-- Configuração para cssls
vim.lsp.config('cssls', {
	capabilities = capabilities,
})

-- Configuração para rust_analyzer
vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
})

-- Configuração para jdtls (Java)
vim.lsp.config('jdtls', {
    capabilities = capabilities,
    settings = {
        java = {
            configuration = {
                updateBuildConfiguration = "automatic",
            },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
        },
    },
})

-- Habilitar todos os servidores configurados
vim.lsp.enable('lua_ls')
vim.lsp.enable('csharp_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('ts_ls')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('jdtls')

-- Keymaps para LSP (apenas se não existirem)
if vim.fn.mapcheck("gi", "n") == "" then
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
end
if vim.fn.mapcheck("gd", "n") == "" then
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
end
if vim.fn.mapcheck("gr", "n") == "" then
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
end
if vim.fn.mapcheck("K", "n") == "" then
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
end
