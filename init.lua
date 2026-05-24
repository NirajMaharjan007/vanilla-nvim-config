local vim = vim
local Plug = vim.fn['plug#']

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_exec_autocmds("User", { pattern = "PluginsLoaded" })


vim.call('plug#begin', '~/.vim/plugged')

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')

Plug('akinsho/bufferline.nvim')
Plug('dense-analysis/ale')
Plug('mattn/emmet-vim')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('nvim-tree/nvim-tree.lua')
Plug('Xuyuanp/nerdtree-git-plugin')
Plug('tiagofumo/vim-nerdtree-syntax-highlight')
Plug('ryanoasis/vim-devicons')
Plug('airblade/vim-gitgutter')
Plug('ctrlpvim/ctrlp.vim')
Plug('preservim/nerdcommenter')
Plug('christoomey/vim-tmux-navigator')
Plug('sheerun/vim-polyglot')
Plug('morhetz/gruvbox')
Plug('rafi/awesome-vim-colorschemes')
Plug('nvim-lualine/lualine.nvim')
Plug('SmiteshP/nvim-navic')
Plug('Yggdroot/indentLine')
Plug('HerringtonDarkholme/yats.vim')
Plug('sheerun/vim-polyglot')
Plug('tomasiser/vim-code-dark')
Plug('frazrepo/vim-rainbow')
Plug('ryanoasis/vim-devicons')
Plug('stevearc/conform.nvim')
Plug('lambdalisue/vim-nerdfont')
Plug('nvim-lua/plenary.nvim')
Plug('nvimdev/dashboard-nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('folke/trouble.nvim')
Plug('folke/snacks.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('folke/edgy.nvim')
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })

vim.call('plug#end')

package.preload['lazy.stats'] = function()
    return {
        status = function() return {} end,
        -- Add other mock functions as needed
    }
end

local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.snippet.expand(args.body)            -- For native neovim snippets (Neovim v0.10+)
            vim.fn["vsnip#anonymous"](args.body)     -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.

            -- For `mini.snippets` users:
            -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            -- insert({ body = args.body }) -- Insert at cursor
            -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            -- require("cmp.config").set_onetime({ sources = {} })
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- This makes Enter confirm selection instead of adding new line
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Keep Tab for normal completion cycling
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        -- { name = 'buffer' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
   sources = cmp.config.sources({
     { name = 'git' },
   }, {
     { name = 'buffer' },
   })
})
require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
vim.lsp.config('<YOUR_LSP_SERVER>', {
    capabilities = capabilities
})

require('telescope').setup({
    defaults = {
        file_ignore_patterns = { "node_modules", ".git" },
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.8,
            height = 0.8,
        },
    },
    extensions = {},
})

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } }
        }
    }
})

vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' }
})

vim.lsp.config('csharp-ls', {
    cmd = { 'csharp-ls' },
    filetypes = { 'cs' },
    -- This tries .sln FIRST, then falls back to .csproj
    root_dir = function(fname)
        local root = vim.fs.root(fname, function(name)
            return name:match('%.sln$') ~= nil
        end)
        if root then return root end

        root = vim.fs.root(fname, function(name)
            return name:match('%.csproj$') ~= nil
        end)
        return root
    end,
})

vim.lsp.enable('csharp-ls')

vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')

require("mason-lspconfig").setup({
    -- List of language servers you want automatically installed
    ensure_installed = { "lua_ls", "ts_ls", "pyright" },
    automatic_installation = true, -- Installs servers when you open a matching file
})



-- Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf })
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            -- Attach navic to get breadcrumbs
            require('nvim-navic').attach(client, args.buf)

            -- Optional: Update breadcrumbs on cursor move
            vim.api.nvim_create_autocmd('CursorMoved', {
                buffer = args.buf,
                callback = function()
                    vim.cmd('redrawstatus') -- Refresh winbar on cursor move
                end
            })
        end
    end
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        cs = { "csharpier" },
        -- Add more as needed
    },

    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true, -- Use LSP formatting if no formatter found
    },
})

require("snacks").setup({
    dashboard = { enabled = false },
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
})

require("bufferline").setup({
    options = {
        modified_icon = "●",
        left_trunc_marker = "",
        right_trunc_marker = "",
        -- This is the magic setting: it makes the tabs look like files, not Vim windows [citation:5]
        mode = "buffers",

        -- Makes the tabs show only the filename, not the whole path
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,

        -- How the tabs look
        separator_style = "slant",     -- Use "slant" for VS Code's angled separator look
        always_show_bufferline = true, -- Keeps the bar visible even with one file open
        diagnostics = "nvim_lsp",      -- Shows LSP error/warning icons on the tabs [citation:3]

        -- This is for VS Code-style tab closing. Bdelete! closes the buffer without breaking the window.
        -- close_command = "Bdelete! %d",
        -- right_mouse_command = "Bdelete! %d",
    }
})
-- Key bindings (optional, but nice to have)
-- These let you switch tabs with Ctrl+Tab, just like a browser
vim.api.nvim_set_keymap('n', '<C-Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.api.nvim_set_keymap('n', '<C-S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            -- tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },

    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },

    winbar = {
        lualine_a = {},
        lualine_b = {
            { 'filename', path = 1 } -- Shows "Main.cs" or "Assets/Scripts/Main.cs"
        },
        lualine_c = {
            {
                function()
                    local navic = require('nvim-navic')
                    if navic.is_available() then
                        local location = navic.get_location()
                        if location and location ~= '' then
                            return '   ' .. location -- Arrow separator
                        end
                    end
                    return ''
                end,
                cond = function()
                    return require('nvim-navic').is_available()
                end
            }
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' }
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = { { 'filename' } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'quickfix' }
}


require("nvim-tree").setup({
    -- Your config options
    view = {
        width = 30,
        side = "left",
    },
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    callback = function()
        vim.opt_local.statuscolumn = "" -- Remove the column with `|`
        vim.opt_local.signcolumn = "no" -- Also remove sign column
        vim.cmd [[highlight EndOfBuffer guifg=bg]]
    end,
})

vim.g.indentLine_fileTypeExclude = { 'dashboard' }
vim.g.indentLine_bufTypeExclude = { 'terminal', 'nofile' }


require('dashboard').setup({
    theme = 'doom',
    config = {
        header = {
            "",
            "     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        },
        vertical_center = true,
        center = {
            { icon = "  ", desc = " New File", action = "ene" },
            { icon = "  ", desc = " Find File", action = "Telescope find_files" },
            { icon = "  ", desc = " Find Word", action = "Telescope live_grep" },
            { icon = "  ", desc = " Recent Files", action = "Telescope oldfiles" },
            { icon = " 󰒲 ", desc = " Mason", action = "Mason" },
            { icon = "  ", desc = " Quit", action = "qa" },
        },
        footer = {
            "",
            "   Niraj Maharjan     vanilla-nvim-config",
            "   github.com/NirajMaharjan007/vanilla-nvim-config",
            "",
        },
    }
})

require("edgy").setup()
require("trouble").setup()

vim.g.rainbow_active = 1

vim.g.rainbow_guifgs = {
    'RoyalBlue3',
    'DarkOrange3',
    'DarkOrchid3',
    'FireBrick'
}

vim.g.rainbow_ctermfgs = {
    'lightblue',
    'lightgreen',
    'yellow',
    'red',
    'magenta'
}

-- BASIC SETTINGS
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.hidden = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.encoding = 'utf-8'
vim.opt.history = 5000
vim.opt.clipboard = 'unnamedplus'
vim.opt.cindent = true
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'
vim.opt.laststatus = 2

-- vim.cmd('colorscheme codedark')
vim.cmd.colorscheme("catppuccin")

-- KEYMAPS
--vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('v', '++', '<plug>NERDCommenterToggle')
vim.keymap.set('n', '++', '<plug>NERDCommenterToggle')

vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('n', '<C-Q>', ':wq<CR>')

vim.keymap.set('n', '<M-Right>', ':bn<CR>')
vim.keymap.set('n', '<M-Left>', ':bp<CR>')
vim.keymap.set('n', '<C-x>', ':bp | bd #<CR>')

-- Better wrapped line movement
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


-- CTRLP
vim.g.ctrlp_user_command = {
    '.git/',
    'git --git-dir=%s/.git ls-files -oc --exclude-standard'
}

-- COC
vim.g.coc_global_extensions = {
    'coc-snippets',
    'coc-pairs',
    'coc-tsserver',
    'coc-eslint',
    'coc-prettier',
    'coc-json',
    'coc-python',
}

vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

vim.keymap.set('n', '<F2>', '<Plug>(coc-rename)')

vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

vim.keymap.set('n', '<space>a', ':CocList diagnostics<CR>', { silent = true })
vim.keymap.set('n', '<space>e', ':CocList extensions<CR>', { silent = true })
vim.keymap.set('n', '<space>c', ':CocList commands<CR>', { silent = true })
vim.keymap.set('n', '<space>o', ':CocList outline<CR>', { silent = true })
vim.keymap.set('n', '<space>s', ':CocList -I symbols<CR>', { silent = true })

-- TAB COMPLETION
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

vim.keymap.set('i', '<TAB>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-n>'
    elseif check_back_space() then
        return '<TAB>'
    else
        return vim.fn['coc#refresh']()
    end
end, { expr = true, silent = true })

vim.keymap.set('i', '<S-TAB>', function()
    if vim.fn.pumvisible() == 1 then
        return '<C-p>'
    else
        return '<C-h>'
    end
end, { expr = true })


-- ALE
vim.g.ale_completion_enabled = 0
vim.g.ale_linters = {
    python = { 'flake8', 'pylint' },
    javascript = { 'eslint' },
}

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.g.ale_sign_error = ''
vim.g.ale_sign_warning = ''
vim.g.ale_sign_info = ''
vim.g.ale_lint_on_text_changed = 'always'
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_set_highlights = 1
vim.g.ale_fix_on_save = 1

vim.cmd([[
highlight DiagnosticUnderlineError gui=undercurl guisp=#ff0000
highlight DiagnosticUnderlineWarn gui=undercurl guisp=#ffaa00
highlight DiagnosticUnderlineInfo gui=undercurl guisp=#00aaff
highlight DiagnosticUnderlineHint gui=undercurl guisp=#00ff99
]])

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})
