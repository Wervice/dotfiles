require("lazy_impl")
require("packer")
require("plug")

vim.o.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- NVim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.opt.number = true
local function nvim_tree_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file/folder"))
    vim.keymap.set("n", "<+>", api.node.open.edit, opts("Open file/folder"))
end
require("nvim-tree").setup {
	on_attach = nvim_tree_attach,
	actions = {
		open_file = {
			quit_on_open = true
		},
	},
	sort = {
		sorter = "extension",
	},
}
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- Barbar
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferPrevious<CR>", {noremap = true, silent = true})

-- Autocomplete
require("mason").setup({})
require("mason-lspconfig").setup(
    {
        ensure_installed = {}
    }
)
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require "lspconfig"

-- Rust LSP
lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module"
                },
                prefix = "self"
            },
            cargo = {
                buildScripts = {
                    enable = true,
                    invocationStrategy = "cargo check --quiet --message-format=json"
                },
                autoreload = false,
                allTargets = false
            },
            check = {
                invocationStrategy = "cargo check --quiet --message-format=json"
            },
            procMacro = {
                enable = true
            },
            cachePriming = {
                enable = false,
                numThreads = 8
            },
            assist = {
                termSearch = {
                    fuel = 10
                }
            }
        }
    },
    capabilities = lsp_capabilities
}

-- TypeScript and JavaScript LSP
lspconfig.ts_ls.setup(
    {
        capabilities = lsp_capabilities,
        settings = {
            exclude = {"**/node_modules/**"}
        }
    }
)

-- Bash LSP
lspconfig.bashls.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Dockerfile LSP
lspconfig.dockerls.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Docker Compose LSP
lspconfig.docker_compose_language_service.setup(
	{
		capabilities = lsp_capabilities
	}
)

-- HTML LSP
lspconfig.html.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Tailwind CSS LSP
lspconfig.tailwindcss.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Clangd (C/C++ LSP)
lspconfig.clangd.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- CSS/HTML
lspconfig.cssls.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Python LSP
lspconfig.basedpyright.setup(
    {
        capabilities = lsp_capabilities
    }
)

-- Intelephense (PHP LSP)
lspconfig.intelephense.setup(
	{
		capabilities = lsp_capabilities
	}
)

local cmp = require("cmp")
cmp.setup(
    {
        confirmation = {completeopt = "menu,menuone,noinsert"},
        snippet = {
            expand = function(args)
                require "luasnip".lsp_expand(args.body)
            end
        },
        mapping = {
            ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
            ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
            ["<CR>"] = cmp.mapping.confirm(
                {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }
            )
        },
        sources = {
            {name = "nvim_lsp"},
            {name = "path"},
            {name = "luasnip"},
            {name = "nvim_lua"},
            {name = "emoji", max_item_count = 5}
        },
        window = {
            completion = cmp.config.window.bordered(
                {
                    max_height = 10, -- Adjust this to set the height of the completion window
                    scrollbar = false -- Disable the scrollbar for a cleaner UI
                }
            ),
            documentation = cmp.config.window.bordered({})
        },
    formatting = {
    format = require("lspkind").cmp_format({
      mode = 'text_symbol', -- show only symbol annotations
      maxwidth = {
        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        -- can also be a function to dynamically calculate max width such as
        -- menu = function() return math.floor(0.45 * vim.o.columns) end,
        menu = 50, -- leading text (labelDetails)
        abbr = 50, -- actual suggestion item
      },
      ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      show_labelDetails = true, -- show labelDetails in menu. Disabled by default
symbol_map = {
      Text = "󰊄",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰓼",
      Variable = "λ",
      Class = "󰋃",
      Interface = "",
      Module = "󰭤",
      Property = "󰓼",
      Unit = "󰍘",
      Value = "π",
      Enum = "󰱐",
      Keyword = "",
      Snippet = "󰗧",
      Color = "󱍜",
      File = "",
      Reference = "󰕞",
      Folder = "",
      EnumMember = "󰿈",
      Constant = "g",
      Struct = "󰙅",
      Event = "󱐋",
      Operator = "󰆕",
      TypeParameter = "",
    },

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        -- ...
        return vim_item
      end
    })
  }
}
)

-- Add beautiful inline diagnostics
require("tiny-inline-diagnostic").setup({
	preset = "simple", -- Can be: "modern", "classic", "minimal", "powerline", ghost", "simple", "nonerdfont", "amongus"
	hi = {
		error = "DiagnosticError",
		warn = "DiagnosticWarn",
		info = "DiagnosticInfo",
		hint = "DiagnosticHint",
		arrow = "NonText",
		background = "#0B0B13", -- Can be a highlight or a hexadecimal color (#RRGGBB)
		mixing_color = "None", -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
	},
	options = {
		-- Show the source of the diagnostic.
		show_source = false,

		-- Use your defined signs in the diagnostic config table.
		use_icons_from_diagnostic = false,

		-- Throttle the update of the diagnostic when moving cursor, in milliseconds.
		-- You can increase it if you have performance issues.
		-- Or set it to 0 to have better visuals.
		throttle = 20,

		-- The minimum length of the message, otherwise it will be on a new line.
		softwrap = 30,

		-- If multiple diagnostics are under the cursor, display all of them.
		multiple_diag_under_cursor = true,

		-- Enable diagnostic message on all lines.
		multilines = true,

		-- Show all diagnostics on the cursor line.
		show_all_diags_on_cursorline = false,

		-- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
		enable_on_insert = false,

		overflow = {
			-- Manage the overflow of the message.
			--    - wrap: when the message is too long, it is then displayed on multiple lines.
			--    - none: the message will not be truncated.
			--    - oneline: message will be displayed entirely on one line.
			mode = "wrap",
		},

		-- Format the diagnostic message.
		-- Example:
		-- format = function(diagnostic)
		--     return diagnostic.message .. " [" .. diagnostic.source .. "]"
		-- end,
		format = nil,

		--- Enable it if you want to always have message with `after` characters length.
		break_line = {
			enabled = true,
			after = 50,
		},

		virt_texts = {
			priority = 2048,
		},

		-- Filter by severity.
		severity = {
			vim.diagnostic.severity.ERROR,
			vim.diagnostic.severity.WARN,
			vim.diagnostic.severity.INFO,
			vim.diagnostic.severity.HINT,
		},

		-- Overwrite events to attach to a buffer. You should not change it, but if the plugin
		-- does not works in your configuration, you may try to tweak it.
		overwrite_events = nil,
	},
})

vim.diagnostic.config({ virtual_text = false })

-- Looks

-- Catppuccin
require("catppuccin").setup(
    {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
            -- :h background
            light = "latte",
            dark = "mocha"
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0 -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = {
            -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = {"italic"}, -- Change the style of comments
            conditionals = {},
            loops = {},
            functions = {"bold"},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {}
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {enabled = true, indentscope_color = ""}
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        }
    }
)

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = true,
    comments = true,
    operators = false,
    folds = false,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

vim.cmd.colorscheme "catppuccin-mocha"

require("lualine").setup({})
require("autoclose").setup({})
require'barbar'.setup {
  icons = {
	separator = { left = ' ', right = ' ' },
  }
}
vim.cmd([[
  highlight BufferCurrent       guibg=NONE guifg=white
  highlight BufferCurrentMod    guibg=NONE guifg=yellow
  highlight BufferCurrentSign   guibg=NONE guifg=white
  highlight BufferCurrentTarget guibg=NONE guifg=red

  highlight BufferVisible       guibg=NONE guifg=gray
  highlight BufferVisibleMod    guibg=NONE guifg=yellow
  highlight BufferVisibleSign   guibg=NONE guifg=gray
  highlight BufferVisibleTarget guibg=NONE guifg=red

  highlight BufferInactive      guibg=NONE guifg=gray
  highlight BufferInactiveMod   guibg=NONE guifg=yellow
  highlight BufferInactiveSign  guibg=NONE guifg=gray
  highlight BufferInactiveTarget guibg=NONE guifg=red
  highlight TabLineFill guibg=#030303
]])


vim.api.nvim_set_keymap("n", "<C-t>", ":Telescope find_files<CR>", {noremap = true, silent = true})

vim.o.termguicolors = true

