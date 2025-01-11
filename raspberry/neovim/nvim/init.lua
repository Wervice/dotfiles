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
local function my_on_attach(bufnr)
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

    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open file/folder'))

end
require("nvim-tree").setup {on_attach = my_on_attach}
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>',
                        {noremap = true, silent = true})

-- Barbar
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferNext<CR>',
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferPrevious<CR>',
                        {noremap = true, silent = true})

-- Autocomplete
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls", "rust_analyzer", "tailwindcss"
	}
})
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require'lspconfig'

-- Rust LSP
lspconfig.rust_analyzer.setup{on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
					invocationStrategy = "cargo check --quiet --message-format=json"
                },
				autoreload = false,
				allTargets = false,

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
					fuel = 3600
				}
			}
        }
    }
	,  capabilities = lsp_capabilities,

}


-- TypeScript and JavaScript LSP
lspconfig.ts_ls.setup({
	  capabilities = lsp_capabilities,
settings = {
    exclude = { "**/node_modules/**" }
  }

})

-- Bash LSP
lspconfig.bashls.setup({
	  capabilities = lsp_capabilities,
})

-- Dockerfile LSP
lspconfig.dockerls.setup({
	  capabilities = lsp_capabilities,
})

-- Docker Compose LSP
lspconfig.docker_compose_language_service.setup({})

-- Elixir LSP
lspconfig.elixirls.setup({
    cmd = {"elixir-ls"} -- Ensure this points to your Elixir language server executable
})

-- Harper LSP
lspconfig.harper_ls.setup({
	filetypes = { 'markdown' },
	capabilities = lsp_capabilities
})

-- HTML LSP
lspconfig.html.setup({
	capabilities = lsp_capabilities
})

-- Python (Pylyzer) LSP
lspconfig.pylsp.setup({
	capabilities = lsp_capabilities
})

-- Tailwind CSS LSP
lspconfig.tailwindcss.setup({
	  capabilities = lsp_capabilities,
})

-- Clangd (C/C++ LSP)
lspconfig.clangd.setup({
	capabilities = lsp_capabilities
})

-- CSS/HTML
lspconfig.cssls.setup({
	capabilities = lsp_capabilities
})
lspconfig.ast_grep.setup({
	capabilities = lsp_capabilities
})

-- Intelephense (PHP LSP)
lspconfig.intelephense.setup({})

local cmp = require('cmp')
cmp.setup({
    confirmation = { completeopt = 'menu,menuone,noinsert' },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = "luasnip" },
        { name = 'nvim_lua' },
        { name = 'emoji', max_item_count = 5 },
    },
    window = {
        completion = cmp.config.window.bordered({
            max_height = 10,  -- Adjust this to set the height of the completion window
            scrollbar = false -- Disable the scrollbar for a cleaner UI
        }),
        documentation = cmp.config.window.bordered({}),
    },
    formatting = {
        format = function(entry, vim_item)
            -- Remove the LSP signature and show only the entry
            vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
            vim_item.menu = nil  -- This hides the source menu, adjust if needed
            return vim_item
        end
    }
})

require('lspkind').init({
    mode = 'symbol_text', -- Show symbol and text (use 'symbol' for icons only)
    preset = 'default',
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = ""
    },
})


-- Looks
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha"
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0 -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = {"italic"}, -- Change the style of comments
        conditionals = {"italic"},
        loops = {},
        functions = {},
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
})

vim.cmd.colorscheme "catppuccin"

require("lualine").setup({})
require("autoclose").setup({})
require("barbar").setup({})

vim.api.nvim_set_keymap('n', '<C-t>', ':Telescope find_files<CR>',
                        {noremap = true, silent = true})


require("colortils").setup({
    register = "+",
    color_preview =  " %s",
    default_format = "hex",
    default_color = "#ffffff",
    border = "rounded",
    mappings = {
        -- increment values
        increment = "<Right>",
        -- decrement values
        decrement = "<Left>",
        -- increment values with bigger steps
        increment_big = "<S-Right>",
        -- decrement values with bigger steps
        decrement_big = "<S-Left>",
        -- set values to the minimum
        min_value = "0",
        -- set values to the maximum
        max_value = "$",
        -- save the current color in the register specified above with the format specified above
        set_register_default_format = "<cr>",
        -- save the current color in the register specified above with a format you can choose
        set_register_choose_format = "g<cr>",
        -- replace the color under the cursor with the current color in the format specified above
        replace_default_format = "<m-cr>",
        -- replace the color under the cursor with the current color in a format you can choose
        replace_choose_format = "g<m-cr>",
        -- export the current color to a different tool
        export = "E",
        -- set the value to a certain number (done by just entering numbers)
        set_value = "c",
        -- toggle transparency
        transparency = "T",
        -- choose the background (for transparent colors)
        choose_background = "B",
    }
})

vim.api.nvim_set_keymap('n', '<C-c>', ':Colortils picker #000000<CR>',
                        {noremap = true, silent = true})



vim.o.termguicolors = true
