return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A poggers statusline/tabline
  use 'vim-airline/vim-airline'

  -- LSP plugins
  use {
      'neovim/nvim-lspconfig',
      'kosayoda/nvim-lightbulb',

  }
    -- Highlights next variable inside a function
  use {
      'ray-x/lsp_signature.nvim',
      disable=true
  }

  -- For getting code outline (variables and functions)
  use {
      {
          'liuchengxu/vista.vim',
          disable=true
      },
      {
          'simrat39/symbols-outline.nvim',
          disable=true
      },
      {
          'stevearc/aerial.nvim',
          disable=true
      }
  }

  -- For code reading
  use {
      'ray-x/navigator.lua',
      disabled=true
  }

  -- Fuzzy finders
    -- uses fuzzy finding in everything
  use {
      'amirrezaask/fuzzy.nvim',
      disable=true
  }

  use {
      'nvim-telescope/telescope.nvim',
      requires = {
          {
              'nvim-lua/popup.nvim'
          },
          {
              'nvim-lua/plenary.nvim'
          }
      }
  }

  --Code completors
  use {
      'nvim-lua/completion-nvim'
  }

  -- md preview
  use {
      {
          'npxbr/glow.nvim',
          disable=true
      }
      {
          'davidgranstrom/nvim-markdown-preview'
      }
  }

  -- TreeSitter!!
  use {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobject',
      'RRethy/nvim-treesitter-textsubjects'
  }

  -- Floating window!!
  use {
      "numtostr/FTerm.nvim",
      config = function()
          require("FTerm").setup()
      end
  }

  -- Snippets!!
  use {
      {
          'hrsh7th/vim-vsnip',
          requires='hrsh7th/vim-vsnip'
      },
      'rafamadriz/friendly-snippets',
      {
          'L3MON4D3/LuaSnip',
          disable=true
      }
  }

  -- Registers
  use {
      'tversteeg/registers.nvim',
      'gennaro-tedesco/nvim-peekup'
  }

  -- NOTES because why not
  use {
      'oberblastmeister/neuron.nvim'
  }

  -- Some utilities
  use {
      'jghauser/mkdir.nvim'
  }

  use {
      'matbme/JABS.nvim'
  }

  use {
      'clojure-vim/jazz.nvim',
      disable=true
  }

  use {
      'Pocco81/AbbrevMan.nvim'
  }

  use {
      'kyazdani42/nvim-web-devicons'
  }

  use {
      'yamatsum/nvim-nonicons'
  }

  use {
      'mfussenegger/nvim-dap',
      requires={
          {
              'rcarriga/nvim-dap-ui'
          },
          {
              'Pocco81/DAPInstall.nvim'
          }
      }
  }

  -- Tabline
  use {
      'romgrk/barbar.nvim',
      disable=true
  }

  use {
      'akinsho/nvim-bufferline.lua',
      disable=true
  }

  use {
      'crispgm/nvim-tabline',
      disable=true
  }

  use {
      'alvarosevilla95/luatab.nvim',
      disable=true
  }

  use {
      'johann2357/nvim-smartbufs',
      disable=true
  }

  -- Statusline
  use {
      'glepnir/galaxyline.nvim',
      disable=true
  }

  use {
      'tjdevries/express_line.nvim',
      disable=true
  }

  use {
      'hoob3rt/lualine.nvim',
      disable=true
  }

  use {
      'adelarsq/neoline.vim',
      disable=true
  }

  use {
      'ojroques/nvim-hardline',
      disable=true
  }

  use {
      'datwaft/bubbly.nvim',
      disable=true
  }

  use {
      'beauwilliams/statusline.lua',
      disable=true
  }

  use {
      'tamton-aquib/staline.nvim',
      disable=true
  }

  use {
      'Famiu/feline.nvim',
      disable=true
  }

  use {
      'windwp/windline.nvim',
      disable=true
  }

  use {
      'lukas-reineke/indent-blankline.nvim'
  }

  use {
      'kyazdani42/nvim-tree.lua',
  }

  use {
      'tanvirtin/vgit.nvim',
      requires='nvim-lua/plenary.nvim'
  }

  use {
      'gennaro-tedesco/nvim-jqx',
      disable=true
  }

  use {
      'b3nj5m1n/kommentary'
  }

  use {
      'b3nj5m1n/kommentary'
  }

  use {
      'jbyuki/instant.nvim'
  }

  use {
      'kevinhwang91/nvim-bqf'
  }

  use {
      'michaelb/sniprun',
  }

  use {
      'kevinhwang91/nvim-hlslens',
      disable=true
  }

  use {
      'dstein64/nvim-scrollview',
      disable=true
  }

  use {
      'windwp/nvim-spectre',
      disable=true
  }

  use {
      'ahmedkhalf/lsp-rooter.nvim',
      disable=true
  }

  use {
      'windwp/nvim-ts-autotag',
      disable=true
  }

  use {
      'windwp/nvim-autopairs'
  }

  use {
      'p00f/nvim-ts-rainbow'
  }

  use {
      'Pocco81/TrueZen.nvim'
  }
  
  use {
      'Pocco81/AutoSave.nvim'
  }

  use {
      'folke/zen-mode.nvim'
  }

  use {
      'haringsrob/nvim_context_vt'
  }

  use {
      'mizlan/iswap.nvim'
  }

  use {
      'nacro90/numb.nvim'
  }

  use {
      {
          'mhartington/formatter.nvim',
          disable=true
      }
      'lukas-reineke/format.nvim'
  }
