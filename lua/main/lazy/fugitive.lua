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

          local function reload_fugitive_index()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd.edit() -- refresh the buffer
            end)
          end

          function GitPush()
            vim.print("Pushing to origin")
            vim.fn.jobstart('git push origin `git branch --show-current`', {
              on_error = function()
                vim.print("Error pushing to origin")
              end,
              on_exit = function()
                reload_fugitive_index()
                vim.print("Pushed to origin")
              end
            })
          end

          function GitCommit(is_pushing)
            -- Adding all files to stage
            vim.cmd.Git('add --all')

            -- Retrieving commit message
            local commit_msg = vim.fn.input('Message: ')
            if commit_msg == nil or commit_msg == "" then
              vim.print("No commit message provided aborting...")
              return
            end

            -- Check if the git folder is a certain name
            local git_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
            local repo_name = vim.fn.fnamemodify(git_dir, ":t")
            local home = vim.fn.expand("$HOME")
            local pre_commit_script_path = home .. "/bin/.local/scripts/" .. repo_name .. "-pre-commit"

            if vim.fn.filereadable(pre_commit_script_path) == 1 then
              vim.print("Running pre-commit scripts for " .. repo_name .. " ...")
              -- Detached with jobstart (for shell commands)
              vim.fn.jobstart("sh " .. pre_commit_script_path, {
                on_exit = function()
                  vim.print("Running git commit -sam \"" .. commit_msg .. "\" ...")
                  vim.cmd("bufdo! silent! write")
                  vim.fn.jobstart('git commit -sam \"' .. commit_msg .. "\"", {
                    on_exit = function()
                      if is_pushing then
                        GitPush()
                      end
                    end
                  })
                end
              })
            else
              -- Commit the changes when the process is done
              vim.cmd.Git('commit -sam \"' .. commit_msg .. '\"')
              if is_pushing then
                GitPush()
              end
            end
          end


          local bufnr = vim.api.nvim_get_current_buf()
          local opts = { buffer = bufnr, remap = false }

          vim.keymap.set("n", "<leader>p", function()
            GitPush()
          end, opts)


          vim.keymap.set("n", "<leader>io", function()
            local floating_menu = require("neo-gitmoji").open_floating
            local hi = floating_menu()
            print(hi)
          end, opts)

          -- Rebase always
          vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git('pull --rebase')
          end, opts)

          vim.keymap.set("n", "<leader>cm", function()
            GitCommit(false)
          end, opts)

          vim.keymap.set("n", "<leader>amp", function()
            GitCommit(true)
          end, opts)
        end,
      })


      vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
      vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
  } }
