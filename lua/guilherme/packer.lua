-- lua/guilherme/packer.lua

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Usa um pcall para não quebrar se o packer falhar ao carregar
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return packer.startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        version = "*",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("nvim-telescope/telescope-ui-select.nvim")
    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    })
    use("Asheq/close-buffers.vim")
    use("goolord/alpha-nvim")
    use("nvim-tree/nvim-web-devicons")
    use("nvimtools/none-ls.nvim")
    use("Mofiqul/dracula.nvim")
    use("morhetz/gruvbox")
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
    })
    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("tpope/vim-surround")
    use("windwp/nvim-ts-autotag")
    use("ryanoasis/vim-devicons")
    use("preservim/nerdtree")
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
    })
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    use("windwp/nvim-autopairs")
    
    -- UI improvements - dressing.nvim (comandos em popup)
    use({
        "stevearc/dressing.nvim",
        config = function()
            local current_theme = vim.g.colors_name or "dracula"
            
            require("dressing").setup({
                input = {
                    enabled = true,
                    default_prompt = "➤ ",
                    -- Posicionamento: centralizado na tela
                    prefer_width = 60,
                    min_width = 40,
                    max_width = 80,
                    -- Aparece no meio da tela, não no cursor
                    override = function(conf)
                        -- Calcular posição central
                        local width = math.min(vim.o.columns, conf.max_width or 80)
                        local height = 1
                        conf.col = math.floor((vim.o.columns - width) / 2)
                        conf.row = math.floor((vim.o.lines - height) / 2)
                        conf.relative = "editor"
                        conf.anchor = "NW"  -- anchor válido: NW, NE, SW, SE
                        return conf
                    end,
                    -- Estilo:
                    border = "rounded",
                    -- Sem transparência
                    win_options = {
                        winblend = 0,
                        winhighlight = "NormalFloat:" .. current_theme .. ",FloatBorder:" .. current_theme .. "Special",
                    },
                    prompt_pos = "top",
                    title_pos = "center",
                    title = " Comando ",
                },
                select = {
                    enabled = true,
                    backend = { "telescope", "builtin" },
                    -- Estilo do dropdown
                    telescope = require("telescope.themes").get_dropdown({
                        border = true,
                        previewer = false,
                        prompt_title = false,
                    }),
                },
            })
            
            -- Substituir o comando padrão por versão mais visual
            vim.api.nvim_create_user_command("Command", function()
                vim.ui.input({ prompt = "➤ " }, function(input)
                    if input then
                        vim.cmd("" .. input)
                    end
                end)
            end, {})
            
            -- Atalho para Command
            vim.keymap.set("n", ";", ":<C-u>Command<CR>", { desc = "Command em popup" })
        end,
    })
    
    -- OpenCode - IA pair programming
    use({
        "nickjvandyke/opencode.nvim",
        version = "*",
        config = function()
            ---@type opencode.Opts
            vim.g.opencode_opts = {
                -- Configurações padrão - pode ser customizado depois
            }
            
            vim.o.autoread = true -- Necessário para o events.reload
            
            -- Keymaps recomendados
            vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode..." })
            vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Select OpenCode..." })
            
            vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end, { desc = "Append range to OpenCode", expr = true })
            vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Append line to OpenCode", expr = true })
            
            vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll OpenCode up" })
            vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
        end,
    })
    
    if packer_bootstrap then
        require('packer').sync()
    end
end)
