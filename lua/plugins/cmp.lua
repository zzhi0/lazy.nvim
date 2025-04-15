return {
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",

    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
          ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<tab>"] = function(fallback)
            return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
          end,
        }),
        sources = cmp.config.sources({
          { name = "lazydev" },
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        experimental = {
          -- only show ghost text when we show ai completions
          ghost_text = vim.g.ai_cmp and {
            hl_group = "CmpGhostText",
          } or false,
        },
        sorting = defaults.sorting,
      }
    end,

    ------@param opts cmp.ConfigSchema
    ---opts = function(_, opts)
    ---  local has_words_before = function()
    ---    unpack = unpack or table.unpack
    ---    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    ---    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    ---  end
    ---
    ---  local luasnip = require("luasnip")
    ---  local cmp = require("cmp")
    ---
    ---  opts.mapping = vim.tbl_extend("force", opts.mapping, {
    ---    ["<Tab>"] = cmp.mapping(function(fallback)
    ---      if cmp.visible() then
    ---        cmp.select_next_item()
    ---        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    ---        -- this way you will only jump inside the snippet region
    ---      elseif luasnip.expand_or_jumpable() then
    ---        luasnip.expand_or_jump()
    ---      elseif has_words_before() then
    ---        cmp.complete()
    ---      else
    ---        fallback()
    ---      end
    ---    end, { "i", "s" }),
    ---    ["<S-Tab>"] = cmp.mapping(function(fallback)
    ---      if cmp.visible() then
    ---        cmp.select_prev_item()
    ---      elseif luasnip.jumpable(-1) then
    ---        luasnip.jump(-1)
    ---      else
    ---        fallback()
    ---      end
    ---    end, { "i", "s" }),
    ---  })
    ---end,
  },
}
