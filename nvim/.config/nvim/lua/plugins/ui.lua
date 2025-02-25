return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      -- Custom Lualine component to show attached language server
      local clients_lsp = function()
        local bufnr = vim.api.nvim_get_current_buf()

        local clients = vim.lsp.buf_get_clients(bufnr) -- Don't change, breaks the function
        if next(clients) == nil then
          return ""
        end

        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return " " .. table.concat(c, "&")
      end

      -- Custom component to show macro recording status
      local macro_recording = function()
        local recording_register = vim.fn.reg_recording()
        if recording_register ~= "" then
          return " Recording @" .. recording_register -- Show the register being recorded
        end
        return "" -- Empty string when not recording
      end

      local custom_osaka = require("lualine.themes.auto")

      -- Custom colours
      custom_osaka.normal.b.fg = "#cad3f5"
      custom_osaka.insert.b.fg = "#cad3f5"
      custom_osaka.visual.b.fg = "#cad3f5"
      custom_osaka.replace.b.fg = "#cad3f5"
      custom_osaka.command.b.fg = "#cad3f5"
      custom_osaka.inactive.b.fg = "#cad3f5"
      custom_osaka.normal.c.fg = "#6e738d"
      custom_osaka.normal.c.bg = "NONE"

      require("lualine").setup({
        options = {
          theme = custom_osaka,
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "alpha" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "", right = "" }, icon = "" },
          },
          lualine_b = {
            {
              "filetype",
              icon_only = true,
              padding = { left = 1, right = 0 },
            },
            "filename",
          },
          lualine_c = {
            {
              "branch",
              icon = "",
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
              colored = false,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = { error = " ", warn = " ", info = " ", hint = "" },
              update_in_insert = true,
            },
          },
          lualine_y = {
            clients_lsp,
            {
              macro_recording,
              color = { fg = "#FFA500" }, -- Apply orange color here
            },
          },
          lualine_z = {
            { "location", separator = { left = "", right = "" }, icon = "" },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        extensions = { "toggleterm", "trouble" },
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
            ⠀⠀⠀⠀⣾⣄⣸⣌⣇⣈⣦⣝⣆⠀⠀⠀⠀⠀⠹⢧⠘⣆⠀⡇⠀⠠⠊⢀⣀⣀⣀⣠⣶⣐⣲⣶⣿⣤⠙⣾⣿⣷⣾⠒⡆⠀⠀⠀⠀⠀
            ⠀⠀⢠⠀⣿⡆⡄⠘⢿⣄⠀⠈⠙⠳⣄⠀⠀⠀⠀⢀⢧⢸⢦⣰⠀⠀⠊⠁⣶⣾⣿⣿⠿⠿⣿⡿⠿⠿⣿⠏⠀⠀⡏⢀⡇⡼⠀⠀⠀⠀
            ⠀⠀⠈⡇⢹⢠⠀⠀⠀⠻⣟⠂⠀⠀⠈⠢⡀⠀⠀⠈⢮⣿⠀⠙⢣⠀⠀⠔⠛⣿⣿⡟⢋⣹⠟⠀⠀⠀⠃⠀⠀⢠⠃⣼⠞⠁⠀⠀⠀⠀
            ⠀⠀⠀⢳⢸⣿⢰⣶⣷⣶⣾⣷⣾⣶⣤⡀⠈⢣⡀⠀⠀⠙⣷⡀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⡼⣼⠃⠀⠀⠀⡄⠀⠀
            ⠀⠀⠀⣈⣮⣿⣿⣿⠟⠛⢻⣿⣿⣿⣭⣽⠷⠄⢱⣖⢄⡀⠘⡟⠢⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡰⢠⡿⡏⠀⠀⠀⠘⠀⠀⠀
            ⠀⠀⢠⠀⠘⣿⣿⣿⣆⠀⠀⠉⠓⠒⠛⠋⠀⠀⠀⢿⠀⠈⠓⢼⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡟⢀⠇⠀⠀⣼⠀⠀⠀⠀
            ⢠⠀⠀⢳⡄⠈⢻⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⢀⠀⠸⠀⠀⠀⠀⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⡸⠀⢀⡾⠃⠀⠀⣰⠃
            ⠃⠀⠀⢸⠈⠳⢄⣹⣿⣿⡀⠀⠀⠀⠀⠀⢀⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⢠⠃⣠⠊⠀⠀⠀⠀⠁⠀
         █████╗ ██╗     ███████╗███████╗███████╗███████╗███████╗██╗███╗   ██╗ ██████╗ 
        ██╔══██╗██║     ██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝██║████╗  ██║██╔═══██╗
        ███████║██║     █████╗  █████╗  ███████╗███████╗███████╗██║██╔██╗ ██║██║   ██║
        ██╔══██║██║     ██╔══╝  ██╔══╝  ╚════██║╚════██║╚════██║██║██║╚██╗██║██║   ██║
        ██║  ██║███████╗███████╗███████╗███████║███████║███████║██║██║ ╚████║╚██████╔╝
        ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
     ]],
        },
      },
    },
  },
}
