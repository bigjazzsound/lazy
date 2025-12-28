return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    {
      "rlch/github-notifications.nvim",
      config = function()
        require("github-notifications.config")
      end,
    },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    local icons = LazyVim.config.icons

    require("lualine").setup({
      options = {
        theme = "catppuccin",
        section_separators = { "", "" },
        component_separators = { "", "" },
        icons_enabled = true,
        globalstatus = true,
      },

      sections = {
        lualine_a = {},
        lualine_b = {
          {
            "filename",
            path = 1,
            fmt = function(s)
              if vim.opt.buftype:get() == "terminal" then
                return vim.fs.basename(s)
              end

              return require("plenary.path"):new(s):shorten(8)
            end,
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_x = {
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          "overseer",
        },
        lualine_y = {
          require("github-notifications").statusline_notification_count,
        },
        lualine_z = {
          "branch",
        },
      },
    })
  end,
}
