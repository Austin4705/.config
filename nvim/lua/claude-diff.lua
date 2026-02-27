-- claude-diff.lua
-- Intercepts claudecode.nvim's split diff view and converts it to an inline
-- diff display using extmarks.  Accept/reject still go through claudecode's
-- own resolution machinery so the WebSocket protocol stays intact.

local M = {}
local ns = vim.api.nvim_create_namespace("claude_inline_diff")

-- original_bufnr → { proposed_bufnr }
local active = {}
-- proposed_bufnr → original_bufnr
local reverse = {}

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

-- Find and convert any split diff currently on screen to inline
local function find_and_convert()
  local candidates = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and not reverse[buf] then
      local dominated = false
      local reason = ""

      if vim.b[buf].claudecode_diff_tab_name then
        dominated = true
        reason = "buf_var:" .. tostring(vim.b[buf].claudecode_diff_tab_name)
      end

      if not dominated then
        local name = vim.api.nvim_buf_get_name(buf)
        local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if (bt == "nofile" or bt == "acwrite") and (name:match("%(proposed%)") or name:match("%(New%)") or name:match("%(NEW FILE")) then
          dominated = true
          reason = "name:" .. vim.fn.fnamemodify(name, ":t") .. " bt:" .. bt
        end
      end

      if dominated then
        table.insert(candidates, { buf = buf, reason = reason })
      end

      if dominated then
        -- Find the window showing this proposed buffer
        local proposed_win = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == buf then
            proposed_win = win
            break
          end
        end
        if proposed_win then
          -- Find the original buffer (another window in diff mode)
          local original_bufnr = nil
          local original_win = nil
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if win ~= proposed_win then
              local ok_d, in_diff = pcall(vim.api.nvim_get_option_value, "diff", { win = win })
              if ok_d and in_diff then
                local b = vim.api.nvim_win_get_buf(win)
                local bt2 = vim.api.nvim_get_option_value("buftype", { buf = b })
                if bt2 == "" then
                  original_bufnr = b
                  original_win = win
                  break
                end
              end
            end
          end

          if original_bufnr and original_win then
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

            local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(original_bufnr), ":t")
            vim.notify("Claude diff: " .. fname, vim.log.levels.INFO)
          end
        end
      end
    end
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

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = grp,
    callback = setup_highlights,
  })

  -- Monkey-patch claudecode.nvim's diff functions to trigger inline conversion
  -- after the split view is created. This is more reliable than autocommand detection.
  local ok_diff, diff_mod = pcall(require, "claudecode.diff")
  if ok_diff and diff_mod then
    local patched = {}
    for _, fn_name in ipairs({ "open_diff", "_open_native_diff", "open_diff_blocking", "create_diff_view" }) do
      if diff_mod[fn_name] then
        local orig = diff_mod[fn_name]
        diff_mod[fn_name] = function(...)
          vim.notify("[claude-diff] " .. fn_name .. " called", vim.log.levels.DEBUG)
          vim.defer_fn(find_and_convert, 200)
          vim.defer_fn(find_and_convert, 500)
          vim.defer_fn(find_and_convert, 1000)
          return orig(...)
        end
        table.insert(patched, fn_name)
      end
    end
    vim.notify("[claude-diff] patched: " .. table.concat(patched, ", "), vim.log.levels.INFO)
  end

  -- Fallback: autocommand-based detection for any code path we didn't patch
  vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew", "TabNew" }, {
    group = grp,
    callback = function()
      vim.defer_fn(find_and_convert, 200)
    end,
  })

  -- Also scan when diff option is set on any window
  vim.api.nvim_create_autocmd("OptionSet", {
    group = grp,
    pattern = "diff",
    callback = function()
      vim.defer_fn(find_and_convert, 200)
    end,
  })

  -- Clean up if the original buffer is deleted while a diff is active
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

  -- Override claudecode's built-in diff commands
  vim.api.nvim_create_user_command("ClaudeCodeDiffAccept", function()
    M.accept()
  end, { desc = "Accept Claude diff (inline)", force = true })

  vim.api.nvim_create_user_command("ClaudeCodeDiffDeny", function()
    M.reject()
  end, { desc = "Deny Claude diff (inline)", force = true })

  vim.keymap.set("n", "<leader>aa", function()
    M.accept()
  end, { desc = "Accept Claude diff" })
  vim.keymap.set("n", "<leader>ad", function()
    M.reject()
  end, { desc = "Deny Claude diff" })

  vim.notify("claude-diff loaded (inline mode)", vim.log.levels.INFO)
end

return M
