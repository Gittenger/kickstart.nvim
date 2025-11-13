-- NOTE: User Functions
-- Use OSC52 clipboard integration for headless environments (WSL2, SSH, etc.)
if vim.fn.executable 'xclip' == 1 and os.getenv 'DISPLAY' then
  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  -- vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
  -- end)
else
  vim.g.clipboard = {
    name = 'osc52',
    copy = {
      ['+'] = function(lines, _)
        require('vim.ui.clipboard.osc52').copy(lines)
      end,
      ['*'] = function(lines, _)
        require('vim.ui.clipboard.osc52').copy(lines)
      end,
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste,
      ['*'] = require('vim.ui.clipboard.osc52').paste,
    },
  }
  -- vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
  -- end)
end
