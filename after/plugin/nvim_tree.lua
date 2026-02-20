-- nvim-tree configuration (replaces NERDTree)
local ok, nvim_tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

-- Disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
  view = {
    width = 30,
    side = 'left',
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        folder = {
          arrow_closed = '>',
          arrow_open = 'v',
        },
        git = {
          unstaged = '~',
          staged = '+',
          unmerged = '!',
          renamed = 'R',
          untracked = '?',
          deleted = '-',
          ignored = 'I',
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.cache' },
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
      },
    },
  },
})

-- Keymaps (preserving NERDTree bindings)
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>n', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '-', ':NvimTreeFindFile<CR>', opts)
