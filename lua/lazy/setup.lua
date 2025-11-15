-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp -- runtime path
rtp:prepend(lazypath)

require('lazy').setup({
  -- loads in order
  -- start with misc
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  require 'lazy.plugins.gitsigns',
  require 'lazy.plugins.autopairs',
  require 'lazy.plugins.oil',
  require 'lazy.plugins.markdown_render',
  require 'lazy.plugins.which_key',
  require 'lazy.plugins.telescope',
  require 'lazy.plugins.todo-comments',

  -- LSP
  require 'lazy.plugins.lsp.lazydev',
  require 'lspconfig.nvim-lspconfig',
  require 'lazy.plugins.lsp.typescript_tools',

  -- Post-LSP
  require 'lazy.plugins.autoformat',
  require 'lazy.plugins.blink',
  require 'lazy.plugins.treesitter',
  require 'lazy.plugins.ufo',

  -- Theme
  require 'lazy.plugins.themes.tokyo-night',

  -- Suite
  require 'lazy.plugins.mini',
}, require 'lazy.ui')

-- post-initialization
require('oil').setup()
