return {
	{
		dir = "~/.config/nvim/lua/plugins/",
		name = "42Header",
		lazy = true,
		event = "BufReadPost",

		config = function()

		local function Insert42Header()
		  local filename = vim.fn.expand("%:t") -- Get the current file name
		  local user = os.getenv("USER") or "user"
		  local git_email = vim.fn.system("git config user.email"):gsub("[\n\r]", "")
		  local email = git_email ~= "" and git_email or user .. "@student.42.fr"
		
		  local filename_padding = 51 - #filename -- Adjust padding dynamically
		  local email_padding = 40 - (#user + #email) -- Adjust padding after email
		  local created_user_padding = 18 - #user -- Padding for "Created by"
		  local updated_user_padding = 17 - #user -- Padding for "Updated by"
		
		  -- Ensure padding values are not negative
		  filename_padding = math.max(1, filename_padding)
		  email_padding = math.max(1, email_padding)
		  created_user_padding = math.max(1, created_user_padding)
		  updated_user_padding = math.max(1, updated_user_padding)
		
		  local header = string.format(
			[[
		/* ************************************************************************** */
		/*                                                                            */
		/*                                                        :::      ::::::::   */
		/*   %s%s:+:      :+:    :+:   */
		/*                                                    +:+ +:+         +:+     */
		/*   By: %s <%s>%s+#+  +:+       +#+        */
		/*                                                +#+#+#+#+#+   +#+           */
		/*   Created: %s by %s%s#+#    #+#             */
		/*   Updated: %s by %s%s###   ########.fr       */
		/*                                                                            */
		/* ************************************************************************** */
		]],
			filename,
			string.rep(" ", filename_padding),
			user,
			email,
			string.rep(" ", email_padding),
			os.date("%Y/%m/%d %H:%M:%S"),
			user,
			string.rep(" ", created_user_padding),
			os.date("%Y/%m/%d %H:%M:%S"),
			user,
			string.rep(" ", updated_user_padding)
		  )
		
		  vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(header, "\n"))
		end
		
		-- Function to update the "Updated:" field in the header
		function UpdateLastModified()
		  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		  local user = os.getenv("USER") or "user"
		  local updated_user_padding = 17 - #user -- Separate padding for "Updated by"
		
		  updated_user_padding = math.max(1, updated_user_padding) -- Ensure non-negative
		
		  local updated = false
		  for i, line in ipairs(lines) do
			if line:match("^%s*/%*%s+Updated:") then
			  lines[i] = string.format(
				"/*   Updated: %s by %s%s###   ########.fr       */",
				os.date("%Y/%m/%d %H:%M:%S"),
				user,
				string.rep(" ", updated_user_padding)
			  )
			  updated = true
			  break -- Stop after finding the first match
			end
		  end
		
		  if updated then
			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines) -- Write back modified lines
		  end
		end
		
		-- Keybind to insert the header
		vim.api.nvim_set_keymap("n", "<C-S-h>", ":lua Insert42Header()<CR>", { noremap = true, silent = true })
		
		-- Autocommand to update the timestamp on save
		vim.api.nvim_create_autocmd("BufWritePre", {
		  pattern = "*",
		  callback = function()
			UpdateLastModified()
		  end,
		})
	end
	}
}