vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use ({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
  })
  use 'Mofiqul/dracula.nvim'
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('vim-airline/vim-airline')
  use('vim-airline/vim-airline-themes')
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('ryanoasis/vim-devicons')
  use('preservim/nerdtree')
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end}
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {'williamboman/mason.nvim'},           -- Optional
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},     -- Required
		  {'hrsh7th/cmp-buffer'},     -- Required
		  {'hrsh7th/cmp-path'},     -- Required
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'}, -- Required
		  {'hrsh7th/cmp-nvim-lua'}, -- Required


		  --Snippets
		  {'L3MON4D3/LuaSnip'},     -- Required
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}

end)
