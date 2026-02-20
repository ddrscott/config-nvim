-- Telescope configuration (replaces FZF)
local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local actions = require('telescope.actions')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
      n = {
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-t>'] = actions.select_tab,
      },
    },
    file_ignore_patterns = {
      'node_modules',
      '.git/',
      'target/',
      'vendor/',
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
        },
      },
    },
  },
})

-- Keymaps (preserving FZF bindings)
local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }

-- File finding
vim.keymap.set('n', '<Leader><Leader>', builtin.find_files, opts)
vim.keymap.set('n', '<Leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<Leader>fh', builtin.oldfiles, opts)
vim.keymap.set('n', '<Leader>fm', builtin.marks, opts)
vim.keymap.set('n', '<Leader>ft', builtin.tags, opts)
vim.keymap.set('n', '<Leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<Leader>ls', builtin.buffers, opts)

-- Search
vim.keymap.set('n', '<Leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<Leader>fw', builtin.grep_string, opts)

-- LSP integration
vim.keymap.set('n', '<Leader>fs', builtin.lsp_document_symbols, opts)

-- Git (replaces SinceDev)
vim.keymap.set('n', '<Leader>fd', function()
  builtin.git_status()
end, opts)
