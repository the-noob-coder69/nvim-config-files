local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
packer=require('packer')
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- A poggers statusline/tabline
  use {
      'vim-airline/vim-airline',
      config=function()
        -- powerline symbols
        vim.g.airline_left_sep = '??'
        vim.g.airline_left_alt_sep = '??'
        vim.g.airline_right_sep = '??'
        vim.g.airline_right_alt_sep = '??'
        vim.g.airline_symbols.branch = '??'
        vim.g.airline_symbols.colnr = ' ??:'
        vim.g.airline_symbols.readonly = '??'
        vim.g.airline_symbols.linenr = ' ??:'
        vim.g.airline_symbols.maxlinenr = '?? '
        vim.g.airline_symbols.dirty='??'
      end
  }

  -- LSP plugins
  use {
      {
        'neovim/nvim-lspconfig',
        cmd='lsp',
        config=function() 
            require'lspconfig'.pyright.setup{}
            local nvim_lsp = require('lspconfig')    
            -- use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end    
                --enable completion triggered by <c-x><c-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')    
                -- mappings.
                local opts = { noremap=true, silent=true }    
                --keymaps
                -- see `:help vim.lsp.*` for documentation on any of the below functions
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                buf_set_keymap('n', 'k', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
                buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
                buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
                buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
                buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
                buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)    
                -- It's config for lsp_signature
                require "lsp_signature".on_attach()    
                -- It's config for completion-nvim
                require'completion'.on_attach()
            end    
                -- use a loop to conveniently call 'setup' on multiple servers and
                -- map buffer local keybindings when the language server attaches
                local servers = { "pyright", "rust_analyzer", "tsserver" }
                for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    flags = {
                    debounce_text_changes = 150,
                    }
                }
                end
        end
      },
      {
        'kosayoda/nvim-lightbulb',
        cmd='lspbulb',
        config=function()
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
        end
      },

    -- highlights next variable inside a function
      {
        'ray-x/lsp_signature.nvim',
        cmd='lsp'
      },
      {
        'nvim-lua/completion-nvim',
        config=function()
            --keymaps
            vim.cmd([[
            " Use <Tab> and <S-Tab> to navigate through popup menu
            inoremap <expr> <Tab>   <Plug>(completion_smart_tab)
            inoremap <expr> <S-Tab> <Plug>(completion_smart_s_tab)

            " Set completeopt to have a better completion experience
            set completeopt=menuone,noinsert,noselect

            " Avoid showing message extra message when using completion
            set shortmess+=c

            let g:completion_enable_snippet = 'vim-vsnip'

            let g:completion_trigger_character = ['.', '::']

            let g:completion_matching_ignore_case = 1


            ]])
        end
      }
  }

  -- for getting code outline (variables and functions)
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

  -- for code reading
  use {
      'ray-x/navigator.lua',
      requires = {
          'ray-x/guihua.lua',
          run = 'cd lua/fzy && make'
      },
      config=function()
          require'navigator'.setup({
          on_attach= function(client, bufnr)
              -- It's config for lsp_signature
              require "lsp_signature".on_attach()    
              -- It's config for completion-nvim
              require'completion'.on_attach()    
          end
          })
      end
  }

  -- fuzzy finders
    -- uses fuzzy finding in everything
  use {
      {
          'amirrezaask/fuzzy.nvim',
      disable=true
  },
  {
      'nvim-telescope/telescope.nvim',
      requires = {
          {
              'nvim-lua/popup.nvim'
          },
          {
              'nvim-lua/plenary.nvim'
          }
      },
      config=function()
          --keymaps
          vim.cmd([[
          " Find files using Telescope command-line sugar.
          nnoremap <leader>ff <cmd>Telescope find_files<cr>
          nnoremap <leader>fg <cmd>Telescope live_grep<cr>
          nnoremap <leader>fb <cmd>Telescope buffers<cr>
          nnoremap <leader>fh <cmd>Telescope help_tags<cr>
          ]])
      end
  }
  }

  -- md preview
  use {
      {
          'npxbr/glow.nvim',
          disable=true
      },
      {
          'davidgranstrom/nvim-markdown-preview',
          disable=true
      }
  }

  -- treesitter!!
  use {
      {
          'nvim-treesitter/nvim-treesitter',
          run=':TSUpdate',
          config=function()
              require'nvim-treesitter.configs'.setup({
                  ensure_installed = {"bash", "comment", "html", "json", "lua", "python", "regex", "toml", "yaml"}
                  highlight = {
                      enable = true
                  },
                  incremental_selection = {
                      enable=true,
                      --keymaps
                      keymaps = {
                          init_selection = "gnn",
                          node_incremental = "grn",
                          scope_incremental = "grc",
                          node_decremental = "grm",
                      }
                  },
                  indent = {
                      enable=true
                  },
                  textobjects = {
                    select = {
                        enable = true,
                  
                        -- Automatically jump forward to textobj, similar to targets.vim 
                        lookahead = true,
                        --keymaps
                        keymaps = {
                          -- You can use the capture groups defined in textobjects.scm
                          ["af"] = "@function.outer",
                          ["if"] = "@function.inner",
                          ["ac"] = "@class.outer",
                          ["ic"] = "@class.inner",
                  
                          -- Or you can define your own textobjects like this
                          ["iF"] = {
                            python = "(function_definition) @function"
                              }
                          }
                      },
                      swap = {
                          enable=true,
                          swap_next = {
                              ["<leader>a"] = "@parameter.inner",
                          },
                          swap_previous = {
                              ["<leader>A"] = "@parameter.inner",
                          },
                      },
                      move = {
                          enable = true,
                          set_jumps = true, -- whether to set jumps in the jumplist
                          goto_next_start = {
                              ["]m"] = "@function.outer",
                              ["]]"] = "@class.outer",
                          },
                          goto_next_end = {
                              ["]M"] = "@function.outer",
                              ["]["] = "@class.outer",
                          },
                          goto_previous_start = {
                              ["[m"] = "@function.outer",
                              ["[["] = "@class.outer",
                          },
                          goto_previous_end = {
                              ["[M"] = "@function.outer",
                              ["[]"] = "@class.outer",
                          },
                      },
                      lsp_interop = {
                          enable = true,
                          border = 'none',
                          peek_definition_code = {
                              ["df"] = "@function.outer",
                              ["dF"] = "@class.outer",
                          },
                      },
                  },
                  textsubjects = {
                      enable = true,
                      keymaps = {
                          ['.'] = 'textsubjects-smart',
                          [';'] = 'textsubjects-container-outer',
                      }
                  },
              }
              vim.cmd([[
              set foldmethod=expr
              set foldexpr=nvim_treesitter#foldexpr()
              ]])
              )
          end
      },
      {
          'nvim-treesitter/nvim-treesitter-textobject'
      },
      {
          'rrethy/nvim-treesitter-textsubjects'
      }
  }

  -- Floating terminal!!
  use {
      "numtostr/fterm.nvim",
      config = function()
          require("fterm").setup({
              dimensions  = {
                  height = 0.8,
                  width = 0.8,
                  x = 0.5,
                  y = 0.5
              },
              border = 'single' -- or 'double'
          })
          local map = vim.api.nvim_set_keymap
          local opts = { noremap = true, silent = true  }
          --keymaps
          map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
          map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
      end
  }

  -- snippets!!
  use {
      {
          'hrsh7th/vim-vsnip',
          requires='hrsh7th/vim-vsnip-integ',
          config=function()
              --keymaps
              vim.cmd([[
                " NOTE: You can use other key to expand snippet.

                " Expand
                imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
                smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
                
                " Expand or jump
                imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
                smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
                
                " Jump forward or backward
                imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
                imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
                smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
                
                " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
                " See https://github.com/hrsh7th/vim-vsnip/pull/50
                nmap        s   <Plug>(vsnip-select-text)
                xmap        s   <Plug>(vsnip-select-text)
                nmap        S   <Plug>(vsnip-cut-text)
                xmap        S   <Plug>(vsnip-cut-text)
              ]])
          end
      },
      'rafamadriz/friendly-snippets',
      {
          'l3mon4d3/luasnip',
          disable=true
      }
  }

  -- registers
  use {
      {
          'tversteeg/registers.nvim'
      },
      {
          'gennaro-tedesco/nvim-peekup',
          config=function()
              --keymaps
              vim.cmd([[
              let g:peekup_open = '<leader>"'
              let g:peekup_paste_before = '<leader>P'
              let g:peekup_paste_after = '<leader>p'
              ]])
          end
      }
  }

  -- notes because why not
  use {
      'oberblastmeister/neuron.nvim'
      config=function()
        -- these are all the default values
        require'neuron'.setup {
            virtual_titles = true,
            mappings = true,
            run = nil, -- function to run when in neuron dir
            neuron_dir = "~/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
            leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
        }
        -- keymaps
        vim.cmd([[
            " click enter on \[\[my_link\]\] or \[\[\[my_link\]\]\] to enter it
            nnoremap <buffer> <CR> <cmd>lua require'neuron'.enter_link()<CR>
            
            " create a new note
            nnoremap <buffer> gzn <cmd>lua require'neuron/cmd'.new_edit(require'neuron'.config.neuron_dir)<CR>
            
            " find your notes, click enter to create the note if there are not notes that match
            nnoremap <buffer> gzz <cmd>lua require'neuron/telescope'.find_zettels()<CR>
            " insert the id of the note that is found
            nnoremap <buffer> gzZ <cmd>lua require'neuron/telescope'.find_zettels {insert = true}<CR>
            
            " find the backlinks of the current note all the note that link this note
            nnoremap <buffer> gzb <cmd>lua require'neuron/telescope'.find_backlinks()<CR>
            " same as above but insert the found id
            nnoremap <buffer> gzB <cmd>lua require'neuron/telescope'.find_backlinks {insert = true}<CR>
            
            " find all tags and insert
            nnoremap <buffer> gzt <cmd>lua require'neuron/telescope'.find_tags()<CR>
            
            " start the neuron server and render markdown, auto reload on save
            nnoremap <buffer> gzs <cmd>lua require'neuron'.rib {address = "127.0.0.1:8200", verbose = true}<CR>
            
            " go to next \[\[my_link\]\] or \[\[\[my_link\]\]\]
            nnoremap <buffer> gz] <cmd>lua require'neuron'.goto_next_extmark()<CR>
            " go to previous
            nnoremap <buffer> gz[ <cmd>lua require'neuron'.goto_prev_extmark()<CR>\]\]
            
        ]])
      end
  }

  -- some utilities
  use {
      'jghauser/mkdir.nvim',
      config = function()
          require('mkdir')
      end
  }

  use {
      'matbme/jabs.nvim'
  }

  use {
      'clojure-vim/jazz.nvim',
      disable=true
  }

  use {
      'pocco81/abbrevman.nvim',
      disable=true
  }

  use {
      'kyazdani42/nvim-web-devicons',
      config=function()
        require('nvim-web-devicons').setup()
      end
  }

  use {
      'yamatsum/nvim-nonicons'
  }

  use {
      'mfussenegger/nvim-dap',
      cmd='debug',
      requires={
          {
              'rcarriga/nvim-dap-ui',
              config=require("dapui").setup({
                icons = {
                  expanded = "▾",
                  collapsed = "▸"
                },
                mappings = {
                  -- Use a table to apply multiple mappings
                  expand = {"<CR>", "<2-LeftMouse>"},
                  open = "o",
                  remove = "d",
                  edit = "e",
                },
                sidebar = {
                  open_on_start = true,
                  elements = {
                    -- You can change the order of elements in the sidebar
                    "scopes",
                    "breakpoints",
                    "stacks",
                    "watches"
                  },
                  width = 40,
                  position = "left" -- Can be "left" or "right"
                },
                tray = {
                  open_on_start = true,
                  elements = {
                    "repl"
                  },
                  height = 10,
                  position = "bottom" -- Can be "bottom" or "top"
                },
                floating = {
                  max_height = nil, -- These can be integers or a float between 0 and 1.
                  max_width = nil   -- Floats will be treated as percentage of your screen.
                }
              })              
          },
          {
              'pocco81/dapinstall.nvim'
          }
      }
  }

  -- tabline
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

  -- statusline
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
      'famiu/feline.nvim',
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
      requires='nvim-lua/plenary.nvim',
      config=function()
        require('vgit').setup({
            debug = false,
            hunks_enabled = true,
            blames_enabled = true,
            diff_preference = 'horizontal',
            diff_strategy = 'remote',
            predict_hunk_signs = true,
            hls = {
                VGitBlame = {
                    bg = nil,
                    fg = '#b1b1b1',
                },
                VGitDiffAddSign = {
                    bg = '#3d5213',
                    fg = nil,
                },
                VGitDiffRemoveSign = {
                    bg = '#4a0f23',
                    fg = nil,
                },
                VGitDiffAddText = {
                    fg = '#6a8f1f',
                    bg = '#3d5213',
                },
                VGitDiffRemoveText = {
                    fg = '#a3214c',
                    bg = '#4a0f23',
                },
                VGitHunkAddSign = {
                    bg = '#3d5213',
                    fg = nil,
                },
                VGitHunkRemoveSign = {
                    bg = '#4a0f23',
                    fg = nil,
                },
                VGitHunkAddText = {
                    fg = '#6a8f1f',
                    bg = '#3d5213',
                },
                VGitHunkRemoveText = {
                    fg = '#a3214c',
                    bg = '#4a0f23',
                },
                VGitHunkSignAdd = {
                    fg = '#d7ffaf',
                    bg = '#4a6317',
                },
                VGitHunkSignRemove = {
                    fg = '#e95678',
                    bg = '#63132f',
                },
                VGitSignAdd = {
                    fg = '#d7ffaf',
                    bg = nil,
                },
                VGitSignChange = {
                    fg = '#7AA6DA',
                    bg = nil,
                },
                VGitSignRemove = {
                    fg = '#e95678',
                    bg = nil,
                },
                VGitHistoryIndicator = {
                    fg = '#a6e22e',
                    bg = nil,
                },
                VGitBorder = {
                    fg = '#a1b5b1',
                    bg = nil,
                },
                VGitBorderFocus = {
                    fg = '#7AA6DA',
                    bg = nil,
                },
            },
            blame = {
                hl = 'VGitBlame',
                window = {
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                },
                format = function(blame, git_config)
                    local config_author = git_config['user.name']
                    local author = blame.author
                    if config_author == author then
                        author = 'You'
                    end
                    local time = os.difftime(os.time(), blame.author_time) / (24 * 60 * 60)
                    local time_format = string.format('%s days ago', round(time))
                    local time_divisions = { { 24, 'hours' }, { 60, 'minutes' }, { 60, 'seconds' } }
                    local division_counter = 1
                    while time < 1 and division_counter ~= #time_divisions do
                        local division = time_divisions[division_counter]
                        time = time * division[1]
                        time_format = string.format('%s %s ago', round(time), division[2])
                        division_counter = division_counter + 1
                    end
                    local commit_message = blame.commit_message
                    if not blame.committed then
                        author = 'You'
                        commit_message = 'Uncommitted changes'
                        local info = string.format('%s • %s', author, commit_message)
                        return string.format(' %s', info)
                    end
                    local max_commit_message_length = 255
                    if #commit_message > max_commit_message_length then
                        commit_message = commit_message:sub(1, max_commit_message_length) .. '...'
                    end
                    local info = string.format('%s, %s • %s', author, time_format, commit_message)
                    return string.format(' %s', info)
                end
            },
            preview = {
                priority = 10,
                horizontal_window = {
                    title = t('preview/horizontal'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                current_window = {
                    title = t('preview/current'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                previous_window = {
                    title = t('preview/previous'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                signs = {
                    add = {
                        name = 'VGitDiffAddSign',
                        sign_hl = 'VGitDiffAddSign',
                        text_hl = 'VGitDiffAddText',
                        text = '+'
                    },
                    remove = {
                        name = 'VGitDiffRemoveSign',
                        sign_hl = 'VGitDiffRemoveSign',
                        text_hl = 'VGitDiffRemoveText',
                        text = '-'
                    },
                },
            },
            history = {
                indicator = {
                    hl = 'VGitHistoryIndicator'
                },
                horizontal_window = {
                    title = t('history/horizontal'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                current_window = {
                    title = t('history/current'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                previous_window = {
                    title = t('history/previous'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
                history_window = {
                    title = t('history/history'),
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                    border_focus_hl = 'VGitBorderFocus'
                },
            },
            hunk = {
                priority = 10,
                window = {
                    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
                    border_hl = 'VGitBorder',
                },
                signs = {
                    add = {
                        name = 'VGitHunkAddSign',
                        sign_hl = 'VGitHunkAddSign',
                        text_hl = 'VGitHunkAddText',
                        text = '+'
                    },
                    remove = {
                        name = 'VGitHunkRemoveSign',
                        sign_hl = 'VGitHunkRemoveSign',
                        text_hl = 'VGitHunkRemoveText',
                        text = '-'
                    },
                },
            },
            hunk_sign = {
                priority = 10,
                signs = {
                    add = {
                        name = 'VGitSignAdd',
                        hl = 'VGitSignAdd',
                        text = '│'
                    },
                    remove = {
                        name = 'VGitSignRemove',
                        hl = 'VGitSignRemove',
                        text = '│'
                    },
                    change = {
                        name = 'VGitSignChange',
                        hl = 'VGitSignChange',
                        text = '│'
                    },
                },
            },
            current_widget = {}
        })
        --keymaps
        vim.api.nvim_set_keymap('n', '<leader>gp', ':VGit hunk_preview<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gr', ':VGit hunk_reset<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<C-k>', ':VGit hunk_up<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<C-j>', ':VGit hunk_down<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gf', ':VGit buffer_preview<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gh', ':VGit buffer_history<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gu', ':VGit buffer_reset<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gd', ':VGit diff<CR>', {
            noremap = true,
            silent = true,
        })
        vim.api.nvim_set_keymap('n', '<leader>gq', ':VGit hunks_quickfix_list<CR>', {
            noremap = true,
            silent = true,
        })
        
      end
  }

  use {
      'gennaro-tedesco/nvim-jqx',
      disable=true
  }

  use {
      'b3nj5m1n/kommentary',
      config=function()
        --keymaps
        vim.api.nvim_set_keymap("n", "<leader>cic", "<Plug>kommentary_line_increase", {})
        vim.api.nvim_set_keymap("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
        vim.api.nvim_set_keymap("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
        vim.api.nvim_set_keymap("n", "<leader>cdc", "<Plug>kommentary_line_decrease", {})
        vim.api.nvim_set_keymap("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})
        vim.api.nvim_set_keymap("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

      end
  }

  use {
      'jbyuki/instant.nvim'
  }

  use {
      'kevinhwang91/nvim-bqf',
      disable=true
  }

  use {
      'michaelb/sniprun',
      run = 'bash ./install.sh',
      config=function()
          require'sniprun'.setup({
              display = {
                  "VirtualTextOk",
                  "VirtualTextErr"
              },
          })
      end
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
      disable=true,
      config=function()
        --keymaps
        vim.cmd([[
            nnoremap <leader>S :lua require('spectre').open()<CR>
            "search current word
            nnoremap <leader>sw viw:lua require('spectre').open_visual()<CR>
            vnoremap <leader>s :lua require('spectre').open_visual()<CR>
            "  search in current file
            nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
        ]])
      end
  }

  use {
      'ahmedkhalf/lsp-rooter.nvim',
      disable=true
  }

  use {
      'windwp/nvim-ts-autotag',
      ft={ "html", "tsx", "vue", "svelte", "php" }
      config=function()
        require'nvim-treesitter.configs'.setup {
            autotag = {
              enable = true,
            }
          }          
      end
  }

  use {
      'windwp/nvim-autopairs',
      disable=true,
      config=function()
        local remap = vim.api.nvim_set_keymap
        local npairs = require('nvim-autopairs')

        -- skip it, if you use another global object
        _G.MUtils= {}

        vim.g.completion_confirm_key = ""

        MUtils.completion_confirm=function()
          if vim.fn.pumvisible() ~= 0  then
            if vim.fn.complete_info()["selected"] ~= -1 then
            require'completion'.confirmCompletion()
            return npairs.esc("<c-y>")
            else
            vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
            require'completion'.confirmCompletion()
            return npairs.esc("<c-n><c-y>")
            end
          else
            return npairs.autopairs_cr()
          end
        end
        remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
    end
  }

  use {
      'jiangmiao/auto-pairs'
  }

  use {
      'p00f/nvim-ts-rainbow',
      config=function()
        require'nvim-treesitter.configs'.setup {
            rainbow = {
              enable = true,
              extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
              max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
              colors = {} -- table of hex strings
              termcolors = {} -- table of colour name strings
            }
          }
        end          
  }

  use {
      'pocco81/truezen.nvim',
      cmd='zen'
      config=function()
        local true_zen = require("true-zen")

        true_zen.setup({
            ui = {
                bottom = {
                    laststatus = 0,
                    ruler = false,
                    showmode = false,
                    showcmd = false,
                    cmdheight = 1,
                },
                top = {
                    showtabline = 0,
                },
                left = {
                    number = false,
                    relativenumber = false,
                    signcolumn = "no",
                },
            },
            modes = {
                ataraxis = {
                    left_padding = 32,
                    right_padding = 32,
                    top_padding = 1,
                    bottom_padding = 1,
                    ideal_writing_area_width = {0},
                    just_do_it_for_me = true,
                    keep_default_fold_fillchars = true,
                    custome_bg = "",
                    bg_configuration = true,
                    affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
                },
                focus = {
                    margin_of_error = 5,
                    focus_method = "experimental"
                },
            },
            integrations = {
                vim_gitgutter = false,
                galaxyline = false,
                tmux = false,
                gitsigns = false,
                nvim_bufferline = false,
                limelight = false,
                vim_airline = false,
                vim_powerline = false,
                vim_signify = false,
                express_line = false,
                lualine = false,
            },
            misc = {
                on_off_commands = false,
                ui_elements_commands = false,
                cursor_by_mode = false,
            }
        })
      end
  }
  
  use {
      'pocco81/autosave.nvim',
      config=function()
        local autosave = require("autosave")
        autosave.setup(
            {
                enabled = true,
                execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
                events = {"InsertLeave"},
                conditions = {
                    exists = true,
                    filetype_is_not = {},
                    modifiable = true
                },
                write_all_buffers = false,
                on_off_commands = true,
                clean_command_line_interval = 0,
                debounce_delay = 135
            }
        )
      end
  }

  use {
      'folke/zen-mode.nvim',
      cmd='zen2',
      disable=true
  }

  use {
      'haringsrob/nvim_context_vt'
  }

  use {
      'mizlan/iswap.nvim',
      config=function()
        require('iswap').setup()
      end
  }

  use {
      'nacro90/numb.nvim',
      config=function()
        require('numb').setup{
            show_numbers = true, -- Enable 'number' for the window while peeking
            show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
         }         
      end
  }

  use {
      {
          'mhartington/formatter.nvim',
          disable=true
      },
      {
          'lukas-reineke/format.nvim',
          disable=true
      }
  }

end)
