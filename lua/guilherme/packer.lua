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
            require("dressing").setup({
                input = {
                    enabled = true,
                    default_prompt = "➤ ",
                    -- Estilo do popup
                    border = "rounded", -- bordas arredondadas
                    relative = "cursor",  -- posição relativa ao cursor
                    prefer_width = 60,    -- largura preferida
                    min_width = 40,      -- largura mínima
                    -- Caixa de sugestões abaixo
                    win_options = {
                        winblend = 10,   -- transparência
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                    prompt_pos = "top",  -- prompt no topo
                    title_pos = "center", -- título centralizado
                    title = " Comando ",   -- título do popup
                },
                select = {
                    enabled = true,
                    backend = { "telescope", "builtin" },
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
    
    -- OpenCode - IA pair programming    use({
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
