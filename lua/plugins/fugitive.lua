return {
  {
    "APZelos/blamer.nvim",
    config = function()
      vim.g.blamer_enabled = true
      vim.g.blamer_delay = 1000
      vim.g.blamer_prefix = ""
      vim.g.blamer_relative_time = true
      vim.g.blamer_template = "<author>, • <summary>"
    end
  },
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

          local function git_add()
            vim.cmd.Git('add --all')
          end

          local function reload_fugitive_index()
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd.edit() -- refresh the buffer
            end)
          end
          local function git_commit(commit_msg, verify)
            vim.cmd.Git('add .');
            vim.fn.jobstart('git commit' .. (verify and "" or " --no-verify") .. ' -S -m \"' .. commit_msg .. '\"', {
              on_exit = function()
                reload_fugitive_index()
              end
            })
          end


          local function git_commit_flow(message, verify)
            if message == nil or message == "" then
              vim.print("No commit message provided aborting...")
              return
            end
            git_commit(message, verify)
          end

          local function git_push()
            vim.print("Pushing to origin")
            vim.fn.jobstart('git push origin `git branch --show-current`', {
              on_error = function()
                vim.print("Error pushing to origin")
              end,
              on_exit = function()
                reload_fugitive_index()
                vim.print("Pushed to origin")
                vim.api.nvim_buf_delete(bufnr, { force = false })
              end
            })
          end

          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('pull --rebase')
          end, opts)

          vim.keymap.set("n", "<leader>gA", function()
            git_add()
          end, opts)

          vim.keymap.set("n", "<leader>cm", function()
            require("gitmoji").open_floating(git_commit_flow, false)
          end, opts)

          vim.keymap.set("n", "<leader>cv", function()
            require("gitmoji").open_floating(git_commit_flow, true)
          end, opts)

          vim.keymap.set("n", "<leader>p", function()
            git_push()
          end, opts)

          vim.keymap.set("n", "<leader>st", function()
            vim.cmd.Git('stash')
          end, opts)

          vim.keymap.set("n", "<leader>sp", function()
            vim.cmd.Git('stash pop')
          end, opts)
        end,
      })

      vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
      vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
  } }
