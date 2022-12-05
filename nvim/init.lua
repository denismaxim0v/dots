-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
vim.cmd [[set t_8f=\e[38;2;%lu;%lu;%lum]]
vim.cmd [[set t_8b=\e[48;2;%lu;%lu;%lum]]


vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager
    use 'tpope/vim-fugitive' -- Git commands in nvim
	use 'savq/melange'
    use 'phha/zenburn.nvim'
    use 'morhetz/gruvbox'
    use 'd11wtq/subatomic256.vim'
    use 'folke/tokyonight.nvim'
    use 'denismaxim0v/minsolarized.nvim'
    use 'tjdevries/colorbuddy.vim'
    use 'tjdevries/gruvbuddy.nvim'
    use 'base16-project/base16-vim'
    use 'navarasu/onedark.nvim'
    use 'jpo/vim-railscasts-theme'
    use 'sainnhe/everforest'
    use 'drsooch/gruber-darker-vim'
	use({
	    "catppuccin/nvim",
    	as = "catppuccin"
    })
    use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use 'windwp/nvim-autopairs'
    -- use 'Raimondi/delimitMate'
	use {
    	"mcchrish/zenbones.nvim",
    	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
    	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    	-- In Vim, compat mode is turned on as Lush only works in Neovim.
    	requires = "rktjmp/lush.nvim"
	}
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
	use({
    'rose-pine/neovim',
    as = 'rose-pine',
}) 
    use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
    -- UI to select things (files, grep results, open buffers...)
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    use 'eemed/sitruuna.vim'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'}
    }
    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter'
    -- Additional textobjects for treesitter
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
	use 'L3MON4D3/LuaSnip'
end)

-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'
vim.o.ruler = true

-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.wo.number = true
vim.o.cursorline = true
vim.o.cursorcolumn=false

-- Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true
vim.o.wrap=true
vim.o.linebreak=true
-- vim.bo.filetype=on

-- Save undo history
vim.opt.undofile = true
vim.o.relativenumber = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.autoindent = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.splitright = true;

vim.opt.clipboard = unnamedplus

vim.o.showtabline=2

require('colorbuddy').colorscheme('gruvbuddy')

--- AUTO CLOSE PAIRS
require('nvim-autopairs').setup{}

-- Setup statusline
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'catppuccin',
    disabled_filetypes = {},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path=1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', {
    noremap = true,
    silent = true
})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- better window navidation
map("n","<C-h>", "<C-w>h" , opt)
map("n","<C-j>", "<C-w>j" , opt)
map("n","<C-k>", "<C-w>k" , opt)
map("n","<C-l>", "<C-w>l" , opt)

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
    noremap = true,
    expr = true,
    silent = true
})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
    noremap = true,
    expr = true,
    silent = true
})

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', {
    noremap = true
})

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = {
            hl = 'GitGutterAdd',
            text = '+'
        },
        change = {
            hl = 'GitGutterChange',
            text = '~'
        },
        delete = {
            hl = 'GitGutterDelete',
            text = '_'
        },
        topdelete = {
            hl = 'GitGutterDelete',
            text = '‾'
        },
        changedelete = {
            hl = 'GitGutterChange',
            text = '~'
        }
    }
}

-- Telescope
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false
            }
        }
    }
}
-- Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>sf',
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], {
        noremap = true,
        silent = true
    })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], {
    noremap = true,
    silent = true
})
vim.api.nvim_set_keymap('n', '<leader>so',
    [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], {
        noremap = true,
        silent = true
    })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], {
    noremap = true,
    silent = true
})

vim.api.nvim_set_keymap('n', '<C-t>n', [[:tabn<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>p', [[:tabp<CR>]], {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>t', [[:tabnew<CR>]], {noremap = true, silent = true})

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
    ensure_installed = { "rust" },
    indent = {
        enable = true
    },
    highlight = {
        enable = true, -- false will disable the whole extension },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = 'gnn',
                node_incremental = 'grn',
                scope_incremental = 'grc',
                node_decremental = 'grm'
            }
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner'
                }
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer'
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer'
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer'
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer'
                }
            }
        }
    }
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {
        noremap = true,
        silent = true
    }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api
        .nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, {scope = "line"})<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so',
        [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local config = {
	on_attach = on_attach,
	capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            lens = {
                enable = true
            },
            cargo = {
                loadOutDirsFromCheck = true,
                allFeatures = true
            },
            procMacro = {
                enable = true
            },
            diagnostics = {
                disabled = {
                    "unresolved-proc-macro",
                }
            }
        }
    },
}

nvim_lsp.rust_analyzer.setup(config)
nvim_lsp.pyright.setup(config)
nvim_lsp.tsserver.setup(config)
nvim_lsp.gopls.setup(config)

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        -- ['<Tab>'] = function(fallback)
        --     if vim.fn.pumvisible() == 1 then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        --     elseif luasnip.expand_or_jumpable() then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
        --     else
        --         fallback()
        --     end
        -- end,
        -- ['<S-Tab>'] = function(fallback)
        --     if vim.fn.pumvisible() == 1 then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        --     elseif luasnip.jumpable(-1) then
        --         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
        --     else
        --         fallback()
        --     end
        -- end
    },
    sources = {{
        name = 'nvim_lsp'
    }, {
        name = 'luasnip'
    }}
}
