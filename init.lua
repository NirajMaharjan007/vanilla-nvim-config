local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.vim/plugged')

Plug('mason-org/mason.nvim')
Plug('dense-analysis/ale')
Plug('mattn/emmet-vim')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('preservim/nerdtree')
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
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })

vim.call('plug#end')

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
vim.cmd.colorscheme("catppuccin-mocha")

-- KEYMAPS
--vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>')
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

-- NERDTREE
vim.g.NERDTreeGitStatusWithFlags = 1
vim.g.NERDTreeIgnore = { '^node_modules$' }

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.cmd('NERDTree')
    end
})

function _G.IsNERDTreeOpen()
    return vim.t.NERDTreeBufName ~= nil and vim.fn.bufwinnr(vim.t.NERDTreeBufName) ~= -1
end

function _G.SyncTree()
    if vim.bo.modifiable
        and IsNERDTreeOpen()
        and vim.fn.expand('%') ~= ''
        and not vim.wo.diff then
        vim.cmd('NERDTreeFind')
        vim.cmd('wincmd p')
    end
end

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        SyncTree()
    end
})

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
