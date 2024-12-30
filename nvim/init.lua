vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.opt.relativenumber = true
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Check if 'pwsh' is executable and set the shell accordingly
if vim.fn.executable "pwsh" == 1 then
  vim.o.shell = "pwsh"
else
  vim.o.shell = "powershell"
end

-- Setting shell command flags
--vim.o.shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';'

-- Setting shell redirection
--vim.o.shellredir = '2>&1 | %{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
--vim.o.shellpipe = '2>&1 | %{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
--vim.o.shellquote = ''
--vim.o.shellxquote = ''
require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require "options"
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = function(lang, buf)
    --local max_filesize = 100 * 1024 -- 100 KB
    --local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --if ok and stats and stats.size > max_filesize then
    --return true
    --end
    --end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
--require("nvim-treesitter.configs").setup { auto_install = true, highlight = { enable = true } }
require "nvchad.autocmds"
vim.schedule(function()
  require "mappings"
end)
require("smoothcursor").setup {
  type = "default", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

  cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
  texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
  linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.

  fancy = {
    enable = true, -- enable fancy mode
    head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil }, -- false to disable fancy head
    body = {
      { cursor = "󰝥", texthl = "SmoothCursorRed" },
      { cursor = "󰝥", texthl = "SmoothCursorOrange" },
      { cursor = "●", texthl = "SmoothCursorYellow" },
      { cursor = "●", texthl = "SmoothCursorGreen" },
      { cursor = "•", texthl = "SmoothCursorAqua" },
      { cursor = ".", texthl = "SmoothCursorBlue" },
      { cursor = ".", texthl = "SmoothCursorPurple" },
    },
    tail = { cursor = nil, texthl = "SmoothCursor" }, -- false to disable fancy tail
  },

  matrix = { -- Loaded when 'type' is set to "matrix"
    head = {
      -- Picks a random character from this list for the cursor text
      cursor = require "smoothcursor.matrix_chars",
      -- Picks a random highlight from this list for the cursor text
      texthl = {
        "SmoothCursor",
      },
      linehl = nil, -- No line highlight for the head
    },
    body = {
      length = 6, -- Specifies the length of the cursor body
      -- Picks a random character from this list for the cursor body text
      cursor = require "smoothcursor.matrix_chars",
      -- Picks a random highlight from this list for each segment of the cursor body
      texthl = {
        "SmoothCursorGreen",
      },
    },
    tail = {
      -- Picks a random character from this list for the cursor tail (if any)
      cursor = nil,
      -- Picks a random highlight from this list for the cursor tail
      texthl = {
        "SmoothCursor",
      },
    },
    unstop = false, -- Determines if the cursor should stop or not (false means it will stop)
  },

  autostart = true, -- Automatically start SmoothCursor
  always_redraw = true, -- Redraw the screen on each update
  flyin_effect = nil, -- Choose "bottom" or "top" for flying effect
  speed = 25, -- Max speed is 100 to stick with your current position
  intervals = 35, -- Update intervals in milliseconds
  priority = 10, -- Set marker priority
  timeout = 3000, -- Timeout for animations in milliseconds
  threshold = 3, -- Animate only if cursor moves more than this many lines
  max_threshold = nil, -- If you move more than this many lines, don't animate (if `nil`, deactivate check)
  disable_float_win = false, -- Disable in floating windows
  enabled_filetypes = nil, -- Enable only for specific file types, e.g., { "lua", "vim" }
  disabled_filetypes = nil, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
  -- Show the position of the latest input mode positions.
  -- A value of "enter" means the position will be updated when entering the mode.
  -- A value of "leave" means the position will be updated when leaving the mode.
  -- `nil` = disabled
  show_last_positions = nil,
}
