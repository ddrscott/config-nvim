local ok, mod = pcall(require, 'llm')
if ok then
mod.setup({
  backend = "ollama", -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
  model = "deepseek-coder-v2",
  url = "http://localhost:11434", -- llm-ls uses "/api/generate"
  -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
  request_body = {
    -- Modelfile options for the model you use
    options = {
      temperature = 0.2,
      top_p = 0.95,
      keep_alive = '60m'
    }
  }
})
end
