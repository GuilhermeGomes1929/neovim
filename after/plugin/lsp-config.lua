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

-- Setup único para nvim-jdtls plugin (opcional - apenas se quiser usar o plugin nvim-jdtls)
local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
  -- Se o plugin nvim-jdtls não estiver instalado, usar apenas config neovim nativa
end

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

-- Configuração COMPLETA para jdtls (Java) - Otimizado para projetos Gradle/Maven
vim.lsp.config('jdtls', {
	capabilities = capabilities,
	
	-- Commande e argumentos
	cmd = {
    'jdtls',
    '-data', vim.fn.stdpath('cache') .. '/jdtls_workspace',
	},

	-- Detectar raiz do projeto (Gradle ou Maven)
	root_dir = function(fname)
    local root = vim.fs.root(fname, {'gradlew', 'build.gradle', 'build.gradle.kts', 'pom.xml', '.git'})
    return root
	end,

	-- Configurações específicas do Eclipse JDT Language Server
	settings = {
    java = {
			-- Nível da linguagem e versão do Java
			configuration = {
				runtimes = {
					{
						name = "JavaSE-21",
						path = "/usr/lib/jvm/java-21-openjdk-amd64",
						default = true,
					},
					-- Adicione mais runtimes conforme necessário:
					-- { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk-amd64" },
					-- { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk-amd64" },
				},
			},

			-- Configurações de Javadoc e documentação
			doc = {
				tags = {
					enabled = true,
					extract = true,
				},
				content = {
					enabled = true,
					extract = true,
				},
			},

			-- Autocomplete inteligente com snippets
			completion = {
				importOrder = {
					"java",
					"javax",
					"org",
					"com",
					"io",
					"br",
					"",
				},
				favorites = {
					{
						name = "java.util.Arrays",
						packages = { "java.util" },
						members = { "Arrays.asList", "Arrays.stream" },
					},
					{
						name = "java.util.Collections",
						packages = { "java.util" },
						members = { "Collections.emptyList", "Collections.singletonList" },
					},
				},
			},

			-- Configurações de formatação
			format = {
				settings = {
					url = vim.fn.stdpath('config') .. "/.vim/java-formatter.xml",
					profile = "GoogleStyle",
				},
				comments = {
					enabled = true,
				},
			},

			-- Organização de imports
			sources = {
				organizeImports = {
					starThreshold = 999,
					staticStarThreshold = 999,
					-- Custom import order
					filepatterns = {
						["java"] = {
							"java",
							"javax",
							"org",
							"com",
							"io",
							"br",
							"",
						},
					},
				},
			},

			-- Configurações avançadas
			signatureHelp = {
				enabled = true,
				description = {
					enabled = true,
				},
				parameter = {
					enabled = true,
				},
			},

			contentProvider = {
				preferred = "fernflower",
			},

			-- Configurações de projeto
			project = {
				referencedLibraries = {},
				resourceFilters = {
					"node_modules",
					".git",
					"build",
					"target",
				},
			},

			-- Lookup de dependências
			dependency = {
				downloadSources = true,
				downloadJavadocs = true,
				maven = {
					downloadSources = true,
					downloadJavadocs = true,
				},
				gradle = {
					downloadSources = true,
					downloadJavadocs = true,
				},
			},

			-- Análise de código
			typeHierarchy = {
				enabled = true,
			},

			inlayHints = {
				parameterNames = {
					enabled = "all",
					exclusions = {},
				},
			},

			-- Renomeação e refatoração
			rename = {
				enabled = true,
				fileOperations = {
					enabled = true,
				},
				extractSuperclass = {
					enabled = true,
				},
				types = {
					enabled = true,
				},
			},
		},
	},
	
	-- Opções de inicialização (incluindo bundles para debugging)
	init_options = {
		-- Bundles vazios por padrão - adicione caminhos para debug/test se necessário
		bundles = {},
		-- Bundles para debugging podem ser adicionados conforme:
		-- local bundles = {
		--   vim.fn.glob("~/path/to/java-debug/com.microsoft.java.debug.plugin-*.jar", 1),
		--   vim.fn.glob("~/path/to/vscode-java-test/server/*.jar", 1),
		-- }
		
		-- Workspace folders
		workspaceFolders = {},
	},

	-- Mensagens em português (ou "en" para inglês)
	-- language = "pt", -- Este plugin não suporta tradução direta

	-- Tipos MIME para contexto Java
	filetypes = { "java" },

	-- Habilitar globalmente
	single_file_support = false,
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

-- Mapeamentos de teclas adicionais para funcionalidades específicas do Java (opcional)
-- Se quiser usar o plugin nvim-jdtls, descomente isto:
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "java",
--     callback = function()
--         local bufopts = { silent = true, buffer = true }
--         vim.keymap.set("n", "<leader>lo", jdtls.organize_imports, bufopts)
--         vim.keymap.set("n", "<leader>lv", jdtls.extract_variable, bufopts)
--         vim.keymap.set("v", "<leader>lv", function()
--             jdtls.extract_variable(true)
--         end, bufopts)
--         vim.keymap.set("n", "<leader>lc", jdtls.extract_constant, bufopts)
--         vim.keymap.set("v", "<leader>lc", function()
--             jdtls.extract_constant(true)
--         end, bufopts)
--         vim.keymap.set("v", "<leader>lm", function()
--             jdtls.extract_method(true)
--         end, bufopts)
--         vim.keymap.set("n", "<leader>cb", jdtls.compile, bufopts)
--     end,
-- })
