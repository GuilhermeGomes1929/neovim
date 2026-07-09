local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
    return -- Para a execução se o autopairs não estiver instalado
end

autopairs.setup({
    check_ts = true, -- habilitar treesitter
    ts_config = {
        lua = {'string'}, -- não adicionar pares em string
        javascript = {'template_string'}, -- não adicionar pares em template strings
    },
    disable_filetype = {"TelescopePrompt", "spectre_panel"},
    fast_wrap = {
        map = '<M-e>',
        chars = {'{', '[', '(', '"', "'"},
        pattern = string.gsub([[ [%'%)%>%]%)%}%,] ]], '%s+', ''),
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
    },
})

-- integrar com nvim-cmp
local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )
end
