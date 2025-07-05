return {
  -- align
  { "junegunn/vim-easy-align" },

  -- explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<F3>", "<leader>E", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "toggle_node",
          ["o"] = "open",
          ["<C-t>"] = "open_tabnew",
          ["I"] = "toggle_hidden",
          ["<C-s>"] = "open_split",
          ["<C-]>"] = "open_vsplit",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,

  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>xt", "<cmd>TodoTelescope<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    -- { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
  },
}
