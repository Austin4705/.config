-- claude-diff.lua
-- Intercepts claudecode.nvim's split diff view and converts it to inline.

local M = {}
local ns = vim.api.nvim_create_namespace("claude_inline_diff")

local active = {}  -- original_bufnr → { proposed_bufnr }
local reverse = {} -- proposed_bufnr → original_bufnr

local function setup_highlights()
  vim.api.nvim_set_hl(0, "ClaudeDiffDelete", { bg = "#3c1f1f" })
  vim.api.nvim_set_hl(0, "ClaudeDiffAdd", { bg = "#1f3c1f" })
  vim.api.nvim_set_hl(0, "ClaudeDiffSignDel", { fg = "#e06c75" })
  vim.api.nvim_set_hl(0, "ClaudeDiffSignAdd", { fg = "#98c379" })
end

local function render_inline(original_bufnr, proposed_lines)
  vim.api.nvim_buf_clear_namespace(original_bufnr, ns, 0, -1)
  local original_lines = vim.api.nvim_buf_get_lines(original_bufnr, 0, -1, false)
  local old_text = table.concat(original_lines, "\n") .. "\n"
  local new_text = table.concat(proposed_lines, "\n") .. "\n"
  if old_text == new_text then
    return
  end

  local ok, hunks = pcall(vim.diff, old_text, new_text, { result_type = "indices" })
  if not ok or not hunks or #hunks == 0 then
    return
  end

  local line_count = #original_lines
  local win_width = 120
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == original_bufnr then
      win_width = vim.api.nvim_win_get_width(win)
      break
    end
  end

  for _, hunk in ipairs(hunks) do
    local sa, ca, sb, cb = hunk[1], hunk[2], hunk[3], hunk[4]
    if ca > 0 then
      for i = sa, sa + ca - 1 do
        local idx = i - 1
        if idx >= 0 and idx < line_count then
          vim.api.nvim_buf_set_extmark(original_bufnr, ns, idx, 0, {
            line_hl_group = "ClaudeDiffDelete",
            sign_text = "▎",
            sign_hl_group = "ClaudeDiffSignDel",
            priority = 1000,
          })
        end
      end
    end
    if cb > 0 then
      local virt = {}
      for i = sb, sb + cb - 1 do
        local text = proposed_lines[i] or ""
        local pad = string.rep(" ", math.max(0, win_width - vim.fn.strdisplaywidth(text)))
        table.insert(virt, { { text .. pad, "ClaudeDiffAdd" } })
      end
      local anchor, above
      if ca > 0 then
        anchor = sa + ca - 2
        above = false
      elseif sa > 0 then
        anchor = sa - 1
        above = false
      else
        anchor = 0
        above = true
      end
      anchor = math.max(0, math.min(anchor, line_count - 1))
      vim.api.nvim_buf_set_extmark(original_bufnr, ns, anchor, 0, {
        virt_lines = virt,
        virt_lines_above = above,
        priority = 1000,
      })
    end
  end
end

local function find_and_convert()
  local candidates = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not vim.api.nvim_buf_is_valid(buf) or reverse[buf] then
      goto continue
    end

    local dominated = false
    if vim.b[buf].claudecode_diff_tab_name then
      dominated = true
    end
    if not dominated then
      local name = vim.api.nvim_buf_get_name(buf)
      local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
      if
        (bt == "nofile" or bt == "acwrite")
        and (name:match("%(proposed%)") or name:match("%(New%)") or name:match("%(NEW FILE"))
      then
        dominated = true
      end
    end
    if dominated then
      table.insert(candidates, buf)
    end

    ::continue::
  end

  for _, buf in ipairs(candidates) do
    local proposed_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == buf then
        proposed_win = win
        break
      end
    end
    if not proposed_win then
      goto next_cand
    end

    local original_bufnr = nil
    local original_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if win ~= proposed_win then
        local ok_d, in_diff = pcall(vim.api.nvim_get_option_value, "diff", { win = win })
        if ok_d and in_diff then
          local b = vim.api.nvim_win_get_buf(win)
          local bt = vim.api.nvim_get_option_value("buftype", { buf = b })
          if bt == "" then
            original_bufnr = b
            original_win = win
            break
          end
        end
      end
    end

    if not original_bufnr or not original_win then
      goto next_cand
    end

    local proposed_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    active[original_bufnr] = { proposed_bufnr = buf }
    reverse[buf] = original_bufnr

    pcall(vim.api.nvim_set_option_value, "bufhidden", "hide", { buf = buf })
    pcall(vim.api.nvim_win_close, proposed_win, true)

    if vim.api.nvim_win_is_valid(original_win) then
      vim.api.nvim_win_call(original_win, function()
        vim.cmd("diffoff")
      end)
      pcall(vim.api.nvim_set_current_win, original_win)
    end

    render_inline(original_bufnr, proposed_lines)

    ::next_cand::
  end
end

function M.accept()
  local bufnr = vim.api.nvim_get_current_buf()
  local info = active[bufnr]
  if not info then
    return
  end
  local proposed_bufnr = info.proposed_bufnr
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  active[bufnr] = nil
  reverse[proposed_bufnr] = nil

  if vim.api.nvim_buf_is_valid(proposed_bufnr) then
    vim.api.nvim_exec_autocmds("BufWriteCmd", { buffer = proposed_bufnr })
  end

  vim.defer_fn(function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("checktime")
      end)
    end
    if vim.api.nvim_buf_is_valid(proposed_bufnr) then
      pcall(vim.api.nvim_buf_delete, proposed_bufnr, { force = true })
    end
  end, 800)
end

function M.reject()
  local bufnr = vim.api.nvim_get_current_buf()
  local info = active[bufnr]
  if not info then
    return
  end
  local proposed_bufnr = info.proposed_bufnr
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  active[bufnr] = nil
  reverse[proposed_bufnr] = nil

  if vim.api.nvim_buf_is_valid(proposed_bufnr) then
    pcall(vim.api.nvim_buf_delete, proposed_bufnr, { force = true })
  end
end

function M.setup()
  setup_highlights()
  local grp = vim.api.nvim_create_augroup("ClaudeInlineDiff", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = setup_highlights })

  local ok_diff, diff_mod = pcall(require, "claudecode.diff")
  if ok_diff and diff_mod then
    for _, fn_name in ipairs({ "open_diff", "_open_native_diff", "open_diff_blocking", "create_diff_view" }) do
      if diff_mod[fn_name] then
        local orig = diff_mod[fn_name]
        diff_mod[fn_name] = function(...)
          vim.defer_fn(find_and_convert, 200)
          vim.defer_fn(find_and_convert, 600)
          vim.defer_fn(find_and_convert, 1200)
          return orig(...)
        end
      end
    end
  end

  vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew", "TabNew" }, {
    group = grp,
    callback = function()
      vim.defer_fn(find_and_convert, 250)
    end,
  })

  vim.api.nvim_create_autocmd("OptionSet", {
    group = grp,
    pattern = "diff",
    callback = function()
      vim.defer_fn(find_and_convert, 250)
    end,
  })

  vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
    group = grp,
    callback = function(args)
      local info = active[args.buf]
      if info then
        active[args.buf] = nil
        reverse[info.proposed_bufnr] = nil
        if vim.api.nvim_buf_is_valid(info.proposed_bufnr) then
          pcall(vim.api.nvim_buf_delete, info.proposed_bufnr, { force = true })
        end
      end
    end,
  })

  vim.api.nvim_create_user_command("ClaudeCodeDiffAccept", function() M.accept() end, { desc = "Accept Claude diff (inline)", force = true })
  vim.api.nvim_create_user_command("ClaudeCodeDiffDeny", function() M.reject() end, { desc = "Deny Claude diff (inline)", force = true })
  vim.keymap.set("n", "<leader>aa", function() M.accept() end, { desc = "Accept Claude diff" })
  vim.keymap.set("n", "<leader>ad", function() M.reject() end, { desc = "Deny Claude diff" })
end

return M
