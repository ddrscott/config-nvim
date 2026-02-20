-- Gitsigns configuration (replaces vim-gitgutter)
local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
  return
end

gitsigns.setup({
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation (preserving gitgutter bindings)
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions (preserving gitgutter bindings)
    map('n', '<Leader>hs', gs.stage_hunk)
    map('n', '<Leader>hr', gs.reset_hunk)
    map('v', '<Leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    map('v', '<Leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    map('n', '<Leader>hS', gs.stage_buffer)
    map('n', '<Leader>hu', gs.undo_stage_hunk)
    map('n', '<Leader>hR', gs.reset_buffer)
    map('n', '<Leader>hp', gs.preview_hunk)
    map('n', '<Leader>hb', function() gs.blame_line({ full = true }) end)
    map('n', '<Leader>tb', gs.toggle_current_line_blame)
    map('n', '<Leader>hd', gs.diffthis)
    map('n', '<Leader>hD', function() gs.diffthis('~') end)
    map('n', '<Leader>td', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
})
