local vim = vim
local Plug = vim.fn['plug#']

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.api.nvim_exec_autocmds("User", { pattern = "PluginsLoaded" })


vim.call('plug#begin', '~/.vim/plugged')

Plug('mason-org/mason.nvim')
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
Plug('vim-airline/vim-airline')
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

-- AIRLINE
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'base16_twilight'
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'default'

-- ALE
vim.g.ale_completion_enabled = 0
vim.g.ale_linters = {
    python = { 'flake8', 'pylint' },
    javascript = { 'eslint' },
}

vim.g.airline_theme = "onedark"

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
