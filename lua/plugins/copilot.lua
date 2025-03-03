return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them

		keys = {
			{"<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "CopilotChat"},
			{"<leader>ze", ":CopilotChatExplain<CR>", mode = "v", desc = "CopilotChatExplain"},
			{"<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "CopilotChatReview"},
			{"<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "CopilotChatFix"},
			{"<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "CopilotChatOptimize"},
		},
  },

}
