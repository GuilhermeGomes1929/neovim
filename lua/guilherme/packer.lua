vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
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
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")
    use("nvim-treesitter/playground")
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
        config = function()
            require("toggleterm").setup()
        end,
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

    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
end)
