vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"

function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    'neoclide/coc.nvim',
    branch = "master",
    lazy = false,
    build = 'npm ci'
  },
    {
        'sphamba/smear-cursor.nvim',
        lazy = false,
        build = 'npm ci',
    },
    {
        'github/copilot.vim',
        branch = "release",
        lazy = false,
        build = 'npm ci',
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        build = 'npm ci',
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = "master",
        lazy = false,
        build = 'npm ci',
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'hrsh7th/cmp-cmdline'},      -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional
            {'j-hui/fidget.nvim'},
        },
    },
  { import = "plugins" },
}, lazy_config)
-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require ('mason').setup ({PATH = 'prepend'})
require ('mason-lspconfig').setup {
  ensure_installed = {
    "lua_ls",
    "eslint",
    "rust_analyzer",
    "clangd",
    "pyright",
    "ts_ls",
  },
  automatic_installation = true,
}
require ('nvim-treesitter.install').compilers = { 'zig' }

local lspconfig = require ('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.ts_ls.setup ({})
lspconfig.lua_ls.setup ({capabilities = lsp_capabilities})
require "options"
require "nvchad.autocmds"

require("oil").setup()

require("CopilotChat").setup ({
    sticky = {
        '#files',
    },
    model = 'claude-3.7-sonnet-thought',
    agent = 'copilot',
})


Map("n", "<leader>pn", "<cmd>CopilotChat<CR>")
Map("n", "<leader>pp", "<cmd>CopilotChatToggle<CR>")

vim.keymap.set("v", "J", ":m \'>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m \'<-2<CR>gv=gv")

local set = vim.opt
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

vim.schedule(function()
  require "mappings"
end)
