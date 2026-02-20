local ok, mod = pcall(require, 'chatgpt')
if ok then
  mod.setup({
      api_host_cmd = 'echo -n "http://localhost:11434"',

      -- this config assumes you have OPENAI_API_KEY environment variable set
      openai_params = {
        model = "qwen2.5-coder",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      }
    })
  -- vim.keymap.set({ 'n', 'v' }, '<leader>l', ':Gen<CR>')
end
