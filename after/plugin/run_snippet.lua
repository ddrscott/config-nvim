local output_line = 0
local pending = ''

local function on_output(_, data, _)
  if #data == 0 then
    return
  end
  
  data[1] = pending .. data[1]
  pending = data[#data]
  
  local lines = vim.list_slice(data, 1, #data - 1)
  if #lines > 0 then
    local commented = vim.tbl_map(function(line)
      return '# ' .. line
    end, lines)
    vim.api.nvim_buf_set_lines(0, output_line, output_line, false, commented)
    output_line = output_line + #lines
  end
end

local function on_exit(_, _, _)
  if pending ~= '' then
    vim.api.nvim_buf_set_lines(0, output_line, output_line, false, { '# ' .. pending })
    output_line = output_line + 1
    pending = ''
  end
  vim.api.nvim_buf_set_lines(0, output_line, output_line, false, { '# ----' })
end

local function strip_output_block(script)
  local lines = vim.fn.split(script, '\n')
  local clean_lines = {}
  for _, line in ipairs(lines) do
    if line == '# ----' then
      break
    end
    table.insert(clean_lines, line)
  end
  return table.concat(clean_lines, '\n')
end

local function find_output_block(start_0idx)
  local total_lines = vim.api.nvim_buf_line_count(0)
  local check = start_0idx
  
  -- Skip blank lines
  while check < total_lines do
    local line = vim.api.nvim_buf_get_lines(0, check, check + 1, false)[1]
    if line ~= '' then break end
    check = check + 1
  end
  
  if check >= total_lines then return nil end
  
  -- Check for opening delimiter
  local first = vim.api.nvim_buf_get_lines(0, check, check + 1, false)[1]
  if first ~= '# ----' then return nil end
  
  -- Find closing delimiter
  for i = check + 1, total_lines - 1 do
    local line = vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
    if line == '# ----' then
      return { start = check, finish = i }
    end
  end
  
  return nil
end

local function run_paragraph_async()
  pending = ''
  
  vim.cmd('normal! yip}')
  local script = vim.fn.trim(vim.fn.getreg('"'))
  script = strip_output_block(script)
  local tmpfile = '/tmp/vimexec.sh'
  
  vim.fn.writefile(vim.fn.split(script, '\n'), tmpfile)
  
  local insert_at = vim.fn.line('.') -- conveniently equals 0-indexed position for next line
  
  -- Check for existing output block and delete it
  local block = find_output_block(insert_at)
  if block then
    vim.api.nvim_buf_set_lines(0, block.start, block.finish + 1, false, {})
    insert_at = block.start
  end
  
  -- Insert opening delimiter
  vim.api.nvim_buf_set_lines(0, insert_at, insert_at, false, { '# ----' })
  output_line = insert_at + 1
  
  vim.fn.jobstart({ vim.env.SHELL, tmpfile }, {
    on_stdout = on_output,
    on_stderr = on_output,
    on_exit = on_exit,
    stdout_buffered = false,
    stderr_buffered = false,
    pty = true,
  })
end

vim.keymap.set('n', '<leader>rp', run_paragraph_async)
