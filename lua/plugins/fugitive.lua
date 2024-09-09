return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

      local fugitive_group = vim.api.nvim_create_augroup("FugitiveGroup", {})
      local autocmd = vim.api.nvim_create_autocmd

      autocmd("BufWinEnter", {
        group = fugitive_group,
        pattern = "*",
        callback = function()
          if vim.bo.ft ~= "fugitive" then
            return
          end

          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }

          local function git_add_all()
            vim.cmd.Git('add --all')
          end

          local function reload_fugitive_index()
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd.edit()
            end)
          end

          local function git_commit(commit_msg, verify)
            if commit_msg == nil or commit_msg == "" then
              vim.print("No commit message provided aborting...")
              return
            end



            -- We make sure to check if we want to verify to prevent hooks from running
            -- vim.cmd.Git('commit' .. (verify and "" or " --no-verify") .. ' -S -am \"' .. commit_msg .. '\"')
            vim.cmd.Git('commit' .. (verify and "" or " --no-verify") .. ' -am \"' .. commit_msg .. '\"')
            reload_fugitive_index()
          end

          local function git_push(force)
            local branch = vim.fn.systemlist('git branch --show-current')[1]

            vim.cmd.Git('push origin ' .. branch .. (force and " --force-with-lease" or ""))
            reload_fugitive_index()
            -- We are deleting the buffer since it's not needed anymore
            vim.api.nvim_buf_delete(bufnr, { force = false })
          end

          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('pull --rebase')
          end, opts)

          vim.keymap.set("n", "<leader>ga", function()
            git_add_all()
          end, opts)

          vim.keymap.set("n", "<leader>cm", function()
            require("gitmoji").open_floating(
              function(message)
                return git_commit(message, false)
              end)
          end, opts)

          vim.keymap.set("n", "<leader>cv", function()
            require("gitmoji").open_floating(
              function(message)
                return git_commit(message, true)
              end)
          end, opts)

          vim.keymap.set("n", "<leader>pp", function()
            git_push(false)
          end, opts)

          vim.keymap.set("n", "<leader>pf", function()
            git_push(true)
          end, opts)
        end,
      })

      vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
      vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
  } }
