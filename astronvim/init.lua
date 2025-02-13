local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "gruvbox-material",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require("default_theme.colors")

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      autoread = true,
      clipboard = "unnamed",
      swapfile = false,
      encoding = "utf-8",
      termguicolors = true,
      relativenumber = true,
      hlsearch = false,
      textwidth = 80,
      shiftwidth = 4,
      tabstop = 4,
      expandtab = true,
      splitright = true,
      wildmenu = true,
      wildmode = {
        "longest",
        "full",
      },
      wildignore = {
        "*.o",
        "*~",
        "*.pyc",
      },
      undofile = true,
      undodir = "/tmp",
      wrap = true,
    },
    g = {
      mapleader = " ",
      rust_recommended_style = 0,
      rustfmt_autosave = 1,
      rustfmt_autosave_if_config_present = 1,
      gruvbox_material_transparent_background = 1,
      lightline = {
        tabline_separator = {
          left = "",
          right = ""
        },
        tabline_subseparator = {
          left = "",
          right = ""
        },
        colorscheme = "gruvbox_material",
        active = {
          left = {
            { "mode", "paste" },
            { "readonly", "filename", "modified" },
            { "gitbranch" },
          }
        },
        component_function = {
          gitbranch = "FugitiveHead"
        }
      },
    },
  },

  header = {
    ""
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      ["akinsho/bufferline.nvim"] = { disable = true },
      ["p00f/nvim-ts-rainbow"] = { disable = true },
      ["norcalli/nvim-colorizer.lua"] = { disable = true },
      ["feline-nvim/feline.nvim"] = { disable = true },
      ["declancm/cinnamon.nvim"] = { disable = true },
      ["rcarriga/nvim-notify"] = { disable = true},

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },

      { "euugenechou/gruvbox-material" },
      { "itchyny/lightline.vim" },
      { "fatih/vim-go" },
      { "Glench/Vim-Jinja2-Syntax" },
      { "rust-lang/rust.vim" },
      { "tpope/vim-abolish" },
      { "tpope/vim-commentary" },
      { "tpope/vim-eunuch" },
      { "tpope/vim-fugitive" },
      { "tpope/vim-repeat" },
      { "tpope/vim-surround" },
      { "tpope/vim-unimpaired" },
      { "wellle/targets.vim" },
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.rufo,
        -- Set a linter
        null_ls.builtins.diagnostics.rubocop,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = {
        "c",
        "cpp",
        "go",
        "python",
        "rust",
        "latex",
        "lua",
        "yaml"
      },
    },
    ["nvim-lsp-installer"] = {
      ensure_installed = {
        "sumneko_lua",
        "pyright",
        "gopls"
      },
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
    indent_blankline = {
      show_current_context = false,
      show_first_indent_level = false,
    }
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- Modify which-key registration
  ["which-key"] = {
    -- Add bindings
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
        },
      },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without lsp-installer
    servers = {
      "rust_analyzer",
      "clangd",
      "texlab",
      "pyright",
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = false,
    underline = false,
  },

  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      ["<C-s>"] = { ":w!<cr>", desc = "Save file" },
      ["<C-h>"] = { "<<", desc = "Unindent" },
      ["<C-j>"] = { ":m .+1<cr>==", desc = "Move line down" },
      ["<C-k>"] = { ":m .-2<cr>==", desc = "Move line up" },
      ["<C-l>"] = { ">>", desc = "Indent" },
      ["<Leader>q"] = { ":q!<cr>", desc = "Quit file" },
      ["<Leader>w"] = { ":w<cr>", desc = "Save file" },
      ["<Leader>s"] = { ":x<cr>", desc = "Save and quit file" },
      ["cp"] = { "yap<S-}>p", desc = "Copy and paste paragraph" },
      ["Y"] = { "y$", desc = "Yank until end of line" },
    },
    v = {
      ["<C-j>"] = { ":m '>+1<cr>gv=gv", desc = "Move line down" },
      ["<C-k>"] = { ":m '<-2<cr>gv=gv", desc = "Move line down" },
    },
    x = {
      ["<C-j>"] = { ":move'>+<cr>gv", desc = "Move line down" },
      ["<C-k>"] = { ":move-2<cr>gv", desc = "Move line up" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Trim whitespace",
      pattern = "*",
      command = "%s/\\s\\+$//e",
    })
    vim.api.nvim_create_autocmd("FileWritePre", {
      desc = "Trim whitespace",
      pattern = "*",
      command = "%s/\\s\\+$//e",
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Fix indent color",
      pattern = "*",
      command = "highlight IndentBlanklineChar guifg=#544c45 gui=nocombine",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "c",
      command = "setl commentstring=//\\ %s",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cpp",
      command = "setl commentstring=//\\ %s",
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
