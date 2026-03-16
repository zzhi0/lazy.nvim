--

return {
  { "weilbith/nvim-lsp-smag" },

  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        -- "flake8",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",

    opts = {
      servers = {
        clangd = {},
        pyright = {},
        eslint = {},
        ts_ls = {},
      },

      setup = {
        -- fix clangd offset encoding
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
}
