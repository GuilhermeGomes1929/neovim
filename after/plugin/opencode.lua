local status, opencode = pcall(require, "opencode")
if not status then
    return -- OpenCode não está instalado
end

-- Verificar se o binário opencode está disponível
local function check_opencode_binary()
    local handle = io.popen("which opencode 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        
        if result and result ~= "" then
            return true, result:gsub("\n", "")
        end
    end
    return false, nil
end

local opencode_found, opencode_path = check_opencode_binary()

if not opencode_found then
    vim.notify("⚠️  OpenCode não encontrado no PATH", vim.log.levels.WARN)
    vim.notify("   Para instalar: npm install -g @opencode/cli", vim.log.levels.WARN)
    vim.notify("   Ou visite: https://opencode.ai/", vim.log.levels.WARN)
    return
end

vim.notify("✅ OpenCode encontrado: " .. opencode_path, vim.log.levels.INFO)

---@type opencode.Opts
vim.g.opencode_opts = {
    -- Configuração do servidor
    server = {
        -- Se não houver servidor rodando, tenta iniciar automaticamente
        -- O binário 'opencode' deve estar no PATH
        start = function()
            vim.notify("🚀 Iniciando OpenCode...", vim.log.levels.INFO)
            
            -- Abre um split vertical na direita
            vim.cmd("botright vsplit")
            vim.cmd("wincmd l")
            vim.cmd("enew")
            
            -- Definir buffer como terminal
            vim.cmd("setlocal buftype=terminal")
            
            -- Iniciar o terminal com opencode
            vim.fn.termopen("opencode --port", {
                on_exit = function(job_id, exit_code, event_type)
                    if exit_code ~= 0 then
                        vim.notify("❌ OpenCode falhou ao iniciar (código: " .. exit_code .. ")", vim.log.levels.ERROR)
                        vim.schedule(function()
                            vim.cmd("close")
                        end)
                    else
                        vim.notify("✅ OpenCode iniciado com sucesso!", vim.log.levels.INFO)
                    end
                end,
            })
            
            -- Configurar opções do buffer
            vim.api.nvim_buf_set_option(0, "buflisted", false)
            vim.cmd("setlocal nospell")
            vim.cmd("setlocal number")
            vim.cmd("setlocal colorcolumn=")
            vim.cmd("setlocal signcolumn=no")
            vim.cmd("setlocal nobuflisted")
            
            -- Voltar para a janela original
            vim.cmd("wincmd h")
            
            return true
        end,
    },
    
    -- Configuração de eventos
    events = {
        reload = true,  -- Recarregar buffer quando OpenCode editar arquivo
    },
    
    -- Configuração de prompts
    prompts = {
        custom = {}
    },
}

-- Autocomandos para eventos do OpenCode
vim.api.nvim_create_autocmd("User", {
    pattern = "OpencodeEvent:*",
    callback = function(args)
        local event = args.data and args.data.event
        if not event or not event.type then
            return
        end
        
        -- Exemplo: notificar quando o status mudar
        if event.type == "session.status" then
            if event.properties and event.properties.status and event.properties.status.type then
                vim.notify("OpenCode: " .. tostring(event.properties.status.type), vim.log.levels.INFO)
            end
        end
        
        -- Exemplo: notificar quando houver edições
        if event.type == "file.edited" then
            if event.properties and event.properties.path then
                vim.notify("OpenCode editou: " .. tostring(event.properties.path), vim.log.levels.INFO)
            else
                vim.notify("OpenCode editou arquivo", vim.log.levels.INFO)
            end
        end
    end,
})

vim.notify("✅ OpenCode.nvim configurado com sucesso!", vim.log.levels.INFO)
vim.notify("   Use <leader>oa para perguntar ao OpenCode", vim.log.levels.INFO)
vim.notify("   Use <leader>os para selecionar opções", vim.log.levels.INFO)
