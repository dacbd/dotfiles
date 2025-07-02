return {
  {
    -- Set things like shiftwidth/tabstop etc based on .editorconfig files
    "tpope/vim-sleuth",
    enabled = true,
    config = function()
      -- nothing needed here
    end
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  'farmergreg/vim-lastplace', -- Open files at last cusror position
}

