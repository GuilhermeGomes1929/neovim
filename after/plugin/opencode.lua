local status, opencode = pcall(require, "opencode")
if not status then
    return -- OpenCode não está instalado
end

-- Verificar se o binário opencode está disponível
local handle = io.popen("which opencode 2>/dev/null")
if handle then
    local result = handle:read("*a")
    handle:close()
    
    if result and result ~= "" then
        print("✅ OpenCode encontrado: " .. result:gsub("\n", ""))
    else
        print("⚠️  OpenCode não encontrado no PATH")
        print("   Para instalar: npm install -g @opencode/cli")
        print("   Ou visite: https://opencode.ai/")
        return
    end
end

---@type opencode.Opts
vim.g.opencode_opts = {
    -- Configuração do servidor
    server = {
        -- Se não houver servidor rodando, tenta iniciar automaticamente
        -- O binário 'opencode' deve estar no PATH
        start = function()
            -- Usa snacks.terminal se disponível, senão terminal padrão
            local snacks_ok, snacks = pcall(require, "snacks.terminal")
            if snacks_ok then
                return snacks.open("opencode --port", {
                    win = {
                        position = "right",
                        enter = false,
                    },
                })
            else
                -- Fallback: abre em uma nova janela de terminal
                vim.cmd("terminal opencode --port")
                vim.cmd("wincmd l")
            end
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

-- Configurar autocompletar para o OpenCode (opcional)
local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
    -- O OpenCode fornece um LSP in-process para autocompletar prompts
    -- Isso já é configurado automaticamente
end

-- Autocomandos para eventos do OpenCode
vim.api.nvim_create_autocmd("User", {
    pattern = "OpencodeEvent:*",
    callback = function(args)
        local event = args.data.event
        
        -- Exemplo: notificar quando o status mudar
        if event.type == "session.status" then
            vim.notify("OpenCode: " .. event.properties.status.type, vim.log.levels.INFO)
        end
        
        -- Exemplo: notificar quando houver edições
        if event.type == "file.edited" then
            vim.notify("OpenCode editou: " .. event.properties.path, vim.log.levels.INFO)
        end
    end,
})

print("✅ OpenCode.nvim configurado com sucesso!")
print("   Use <leader>oa para perguntar ao OpenCode")
print("   Use <leader>os para selecionar opções")
