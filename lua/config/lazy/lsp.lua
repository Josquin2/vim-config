return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    require("conform").setup({
      formatters_by_ft = {},
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range (in visual mode)" })
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "vue_ls",
        "eslint",
        "ts_ls",
        "cssls"
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

      },


    })

    vim.lsp.config('ts_ls', {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = "/opt/homebrew/lib/node_modules/@vue/typescript-plugin", -- macos
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
    })

    vim.lsp.config('vue_ls', {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Enter>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- For luasnip users.
      }, {
        { name = "buffer" },
      }),
    })

    vim.diagnostic.config({
      virtual_text = {
        prefix = '■',
        spacing = 2,
      },
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
