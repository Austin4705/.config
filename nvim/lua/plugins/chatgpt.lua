return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        yank_register = "+",

        -- Session settings should be at the top level, not inside edit_with_instructions
        sessions_window = {
          active_sign = "▶",
          inactive_sign = "◀",
          current_line_sign = "●",
        },

        -- Storage path should be at the top level
        session_directory = vim.fn.stdpath("data") .. "/chatgpt-sessions/",

        edit_with_instructions = {
          diff = false,
          keymaps = {
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
          },
        },

        chat = {
          welcome_message = "Hi, I am Version 1 of E.R.I.C., or Enormously Retarded Integrated Chatbot. How can I E.R.I.C. you today?",
          loading_text = "Loading, please wait ...",
          question_sign = "🙂",
          answer_sign = "🤖",
          max_line_length = 120,
          sessions_window = {
            border = {
              style = "rounded",
              text = {
                top = " Sessions ",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
          },
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            submit = "<CR>",
          },
        },

        openai_params = {
          model = "gpt-4-1106-preview",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },

        openai_edit_params = {
          model = "gpt-4-1106-preview",
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
      })

      -- Define keybindings AFTER setup
      vim.keymap.set("n", "<leader>Cc", "<cmd>ChatGPT<CR>", { desc = "Open ChatGPT chat" })
      vim.keymap.set("n", "<leader>Ce", "<cmd>ChatGPTEditWithInstructions<CR>", { desc = "Edit with ChatGPT" })
      vim.keymap.set("n", "<leader>Ca", "<cmd>ChatGPTActAs<CR>", { desc = "ChatGPT act as..." })
      vim.keymap.set("n", "<leader>Cr", "<cmd>ChatGPTRun ", { desc = "ChatGPT run command" })
      vim.keymap.set("n", "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar correction" })
      vim.keymap.set("n", "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
      vim.keymap.set("n", "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
      vim.keymap.set("n", "<leader>Ci", "<cmd>ChatGPTRun improve<CR>", { desc = "Improve writing" })
      vim.keymap.set("n", "<leader>Cd", "<cmd>ChatGPTRun doc<CR>", { desc = "Generate documentation" })
      vim.keymap.set("n", "<leader>Co", "<cmd>ChatGPTRun optimize<CR>", { desc = "Optimize code" })
      vim.keymap.set("n", "<leader>Cf", "<cmd>ChatGPTRun fix<CR>", { desc = "Fix code" })
      vim.keymap.set("n", "<leader>Cl", "<cmd>ChatGPTRun explain<CR>", { desc = "Explain code" })

      -- Visual mode mappings
      vim.keymap.set(
        "v",
        "<leader>Ce",
        "<cmd>ChatGPTEditWithInstructions<CR>",
        { desc = "Edit selection with ChatGPT" }
      )
      vim.keymap.set("v", "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", { desc = "Grammar correction" })
      vim.keymap.set("v", "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", { desc = "Translate" })
      vim.keymap.set("v", "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", { desc = "Summarize" })
      vim.keymap.set("v", "<leader>Ci", "<cmd>ChatGPTRun improve<CR>", { desc = "Improve writing" })
      vim.keymap.set("v", "<leader>Cd", "<cmd>ChatGPTRun doc<CR>", { desc = "Generate documentation" })
      vim.keymap.set("v", "<leader>Co", "<cmd>ChatGPTRun optimize<CR>", { desc = "Optimize code" })
      vim.keymap.set("v", "<leader>Cf", "<cmd>ChatGPTRun fix<CR>", { desc = "Fix code" })
      vim.keymap.set("v", "<leader>Cl", "<cmd>ChatGPTRun explain<CR>", { desc = "Explain code" })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
