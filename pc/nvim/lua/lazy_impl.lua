-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out =
        vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            lazyrepo,
            lazypath
        }
    )
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
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
require("lazy").setup(
    {
        ui = {
            backdrop = 100
        },
        spec = {
             {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    },{
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
},
            {
                "nvim-tree/nvim-tree.lua",
                dependencies = {
                    "nvim-tree/nvim-web-devicons" -- optional for file icons
                }
            }, -- LSP configuration
            "neovim/nvim-lspconfig",
            {"williamboman/mason.nvim"},
            -- Mason for managing LSP servers

            "williamboman/mason-lspconfig.nvim", -- Autocompletion plugin
			"kevinhwang91/nvim-ufo",
			"kevinhwang91/promise-async",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path", -- Path completion
            "hrsh7th/cmp-cmdline", -- Command-line completion
            "L3MON4D3/LuaSnip", -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippet completions
			{"catppuccin/nvim", name = "catppuccin", priority = 1000},
			{"ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
			{
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
},
            {
                "nvim-lualine/lualine.nvim",
                "hrsh7th/cmp-calc", -- Calculator completions
                "hrsh7th/cmp-emoji", -- Emoji completions
                requires = {"nvim-tree/nvim-web-devicons", opt = true}
            },
            {
                "tiagovla/tokyodark.nvim",
                opts = {
                    transparent_background = true, -- set background to transparent
                    gamma = 1.00, -- adjust the brightness of the theme
                    styles = {
                        comments = {italic = true}, -- style for comments
                        keywords = {italic = true}, -- style for keywords
                        identifiers = {italic = true}, -- style for identifiers
                        functions = {}, -- style for functions
                        variables = {} -- style for variables
                    },
                    custom_highlights = {} or function(highlights, palette)
                            return {}
                        end, -- extend highlights
                    custom_palette = {} or function(palette)
                            return {}
                        end, -- extend palette
                    terminal_colors = true -- enable terminal colors
                }
            },
            {
                "romgrk/barbar.nvim",
                dependencies = {
                    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
                    "nvim-tree/nvim-web-devicons" -- OPTIONAL: for file icons
                },
                init = function()
                    vim.g.barbar_auto_setup = false
                end
            },
            "m4xshen/autoclose.nvim",
            {
                "nvim-telescope/telescope.nvim",
                tag = "0.1.8",
                dependencies = {"nvim-lua/plenary.nvim"}
            },
            {
                "onsails/lspkind-nvim",
                event = "InsertEnter" -- Lazy load when you start inserting text
            },
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
			{
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
		preset = {
		header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
I use  by the way
]]},
  sections = {
    {
      section = "header",
    },
    {
      pane = 2,
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    },
  },
}
  }
},
{
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = true, -- prevent barbecue from updating itself automatically
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        -- "BufModifiedSet",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)

