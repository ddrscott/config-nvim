local ok, mod = pcall(require, 'CopilotChat')
if ok then
  mod.setup({
      debug = true,
      show_help = "yes",
      prompts = {
        Explain = "Explain how it works by Japanese language.",
        Review = "Review the following code and provide concise suggestions.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
        Refactor = "Refactor the code to improve clarity and readability.",
      },
      build = function()
        vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
      end,
      event = "VeryLazy",
    })
  vim.cmd [[
nnoremap <leader>ccb <cmd>CopilotChatBuffer<cr>
nnoremap <leader>cce <cmd>CopilotChatExplain<cr>
nnoremap <leader>cct <cmd>CopilotChatTests<cr>
xnoremap <leader>ccv :CopilotChatVisual<cr>
xnoremap <leader>ccx :CopilotChatInPlace<cr>
]]

  -- vim.keymap.set({ 'n', 'v' }, '<leader>l', ':Gen<CR>')
end
