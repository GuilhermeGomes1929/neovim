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

-- vim.notify("✅ OpenCode encontrado: " .. opencode_path, vim.log.levels.INFO)

---@type opencode.Opts
vim.g.opencode_opts = {
    -- Configuração do servidor
    -- Você deve iniciar manualmente: opencode --port
    server = {
        -- Usar servidor local na porta padrão
        -- start = nil - Não iniciar automaticamente
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

-- Handle OpenCode events
-- Manipular eventos do OpenCode
vim.api.nvim_create_autocmd("User", {
    pattern = "OpencodeEvent:*", -- Opcionalmente filtrar tipos de eventos
    callback = function(args)
        ---@type opencode.server.Event
        local event = args.data.event
        ---@type string
        local url = args.data.url

        -- Para debug: ver os tipos e propriedades do evento
        -- vim.notify(vim.inspect(event), vim.log.levels.DEBUG)
        
        -- Do something useful
        if event.type == "session.status" then
            if event.properties and event.properties.status and event.properties.status.type then
                vim.notify("OpenCode status: " .. event.properties.status.type, vim.log.levels.INFO)
            end
        end
        
        -- Notificar sobre edições
        if event.type == "file.edited" then
            if event.properties and event.properties.path then
                vim.notify("OpenCode editou: " .. event.properties.path, vim.log.levels.INFO)
            else
                vim.notify("OpenCode editou arquivo", vim.log.levels.INFO)
            end
        end
    end,
})

-- Recommended/example keymaps
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select OpenCode…" })

vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Append range to OpenCode", expr = true })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })

vim.keymap.set("n", "<A-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll OpenCode up" })
vim.keymap.set("n", "<A-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })

/-- vim.notify("✅ OpenCode.nvim configurado com sucesso!", vim.log.levels.INFO)
/-- vim.notify("   Inicie manualmente: opencode --port", vim.log.levels.INFO)
/-- vim.notify("   Use <leader>oa para perguntar ao OpenCode", vim.log.levels.INFO)
/-- vim.notify("   Use <leader>os para selecionar opções", vim.log.levels.INFO)
