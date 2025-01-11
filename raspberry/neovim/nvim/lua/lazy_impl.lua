-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
            {"\nPress any key to exit..."}
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	  ui = {
    backdrop = 100,
  },
    spec = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = {"BufRead", "BufNewFile"} -- Lazy load treesitter on buffer read or new file
        }, {
            "nvim-tree/nvim-tree.lua",
            dependencies = {
                "nvim-tree/nvim-web-devicons" -- optional for file icons
            }

        }, -- LSP configuration
        "neovim/nvim-lspconfig", {"williamboman/mason.nvim"},
{
  "max397574/colortils.nvim",
  cmd = "Colortils",
  config = function()
    require("colortils").setup()
  end,
},

        -- Mason for managing LSP servers

        "williamboman/mason-lspconfig.nvim", -- Autocompletion plugin
        "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
        "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
        "hrsh7th/cmp-path", -- Path completion
        "hrsh7th/cmp-cmdline", -- Command-line completion
        -- Snippet engine (optional, for better completion support)
        "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", -- Snippet completions:w
        {"catppuccin/nvim", name = "catppuccin", priority = 1000}, {
            'nvim-lualine/lualine.nvim',
            "hrsh7th/cmp-calc", -- Calculator completions
            "hrsh7th/cmp-emoji", -- Emoji completions

            requires = {'nvim-tree/nvim-web-devicons', opt = true}
        }, {
            'romgrk/barbar.nvim',
            dependencies = {
                'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
                'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
            },
            init = function() vim.g.barbar_auto_setup = false end

        }, 'm4xshen/autoclose.nvim', {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = {'nvim-lua/plenary.nvim'}
        },
		 {
    'onsails/lspkind-nvim',
    event = 'InsertEnter', -- Lazy load when you start inserting text
  },

    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {colorscheme = {"catppuccin"}},
    -- automatically check for plugin updates
    checker = {enabled = true}
})
