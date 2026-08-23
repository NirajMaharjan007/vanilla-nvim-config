local vim = vim
local Plug = vim.fn['plug#']

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_exec_autocmds("User", { pattern = "PluginsLoaded" })


vim.call('plug#begin', '~/.vim/plugged')

Plug('gbprod/yanky.nvim')
Plug('tpope/vim-unimpaired')

Plug('kevinhwang91/promise-async')
Plug('kevinhwang91/nvim-ufo')

Plug('ibhagwan/fzf-lua')

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')

Plug('windwp/nvim-autopairs')
Plug('lewis6991/gitsigns.nvim')
Plug('hedyhli/outline.nvim')

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

require("yanky").setup({
  ring = {
    history_length = 100,
    storage = "shada",
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
    sync_with_numbered_registers = true,
    cancel_event = "update",
    ignore_registers = { "_" },
    update_register_on_cycle = false,
    permanent_wrapper = nil,
  },
  picker = {
    select = {
      action = nil, -- nil to use default put action
    },
    telescope = {
      use_default_mappings = true, -- if default mappings should be used
      mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
    },
  },
  system_clipboard = {
    sync_with_ring = true,
    clipboard_register = nil,
  },
  highlight = {
    on_put = true,
    on_yank = true,
    timer = 500,
  },
  preserve_cursor_position = {
    enabled = true,
  },
  textobj = {
   enabled = false,
  },
})

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

require('gitsigns').setup {
    on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal { ']c', bang = true }
            else
                gitsigns.nav_hunk 'next'
            end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal { '[c', bang = true }
            else
                gitsigns.nav_hunk 'prev'
            end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
            { desc = 'git [s]tage hunk' })
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
            { desc = 'git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
        map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end,
            { desc = 'git hunk [Q]uickfix list (all files in repo)' })
        map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end,
}

require('nvim-autopairs').setup()

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

local navic = require("nvim-navic")

vim.lsp.config('omnisharp', {
    cmd = { "omnisharp" },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentSymbolProvider = true
        navic.attach(client, bufnr)
    end,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
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
vim.lsp.enable('omnisharp')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')

require("mason-lspconfig").setup({
    -- List of language servers you want automatically installed
    ensure_installed = { "lua_ls", "ts_ls", "pyright", "omnisharp" },
    automatic_installation = true, -- Installs servers when you open a matching file
})


local fzf = require("fzf-lua")

fzf.setup({
    winopts = {
        width = 0.8,
        height = 0.8,
        border = "rounded",
    },
    files = {
        prompt = "Files> ",
    },
    grep = {
        prompt = "Grep> ",
    },
})

local ufo = require("ufo")
local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = ''
}

ufo.setup({
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
        json = { 'array' },
        c = { 'comment', 'region' }
    },
    close_fold_current_line_for_ft = {
        default = true,
        c = false
    },
    preview = {
        win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>',
            jumpTop = '[',
            jumpBot = ']'
        }
    },
    provider_selector = function(bufnr, filetype, buftype)
        -- if you prefer treesitter provider rather than lsp,
        -- return ftMap[filetype] or {'treesitter', 'indent'}
        return ftMap[filetype]

        -- refer to ./doc/example.lua for detail
    end
})

require("outline").setup({
    outline_window = {
        position = 'right',
    }
})

-- Keymaps

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "<C-b>", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

vim.keymap.set('n', 'zs', 'zc', { desc = 'Fold current block' })
vim.keymap.set('n', 'za', 'zo', { desc = 'Unfold current block' })
vim.keymap.set('n', 'zr', ufo.closeAllFolds, { desc = 'Fold All' })
vim.keymap.set('n', 'zm', ufo.openAllFolds, { desc = 'Unfold All' })
vim.keymap.set('n', 'zK', ufo.closeAllFolds, { desc = 'Fold All' })
vim.keymap.set('n', 'zk', ufo.openAllFolds, { desc = 'Unfold All' })

vim.keymap.set('n', 'K', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = 'Peek / Hover' })

-- Basic fzf-lua keymaps
vim.keymap.set('n', '<leader>ff', function() fzf.files() end)
vim.keymap.set('n', '<leader>fg', function() fzf.live_grep() end)
vim.keymap.set('n', '<leader>fb', function() fzf.buffers() end)
vim.keymap.set('n', '<leader>fh', function() fzf.help_tags() end)
vim.keymap.set('n', '<leader>fr', function() fzf.oldfiles() end)
vim.keymap.set('n', '<leader>fc', function() fzf.commands() end)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf })
        local client = vim.lsp.get_client_by_id(args.data.client_id)
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

_G.Snacks = require('snacks')

Snacks.setup({
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
    terminal = { enabled = true }
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
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<M-q>', vim.diagnostic.setloclist)

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
