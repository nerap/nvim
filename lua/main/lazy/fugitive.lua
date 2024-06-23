return {
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


        function GitPush()
          vim.print("Pushing to origin")
          vim.fn.jobstart('git push origin `git branch --show-current`', {
            on_error = function()
              vim.print("Error pushing to origin")
            end,
            on_exit = function()
              vim.print("Pushed to origin")
            end
          })
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
          GitPush()
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git('pull --rebase')
        end, opts)



        -- create a map from name to vim.cmd
        local repo_pre_commit_mapping = {
          ["may"] = "yarn lint-staged",
        }

        vim.keymap.set("n", "<leader>amp", function()
          -- Adding all files to stage
          vim.cmd.Git('add --all')

          -- Retrieving commit message
          local commit_msg = vim.fn.input('Commit message: ')
          if commit_msg == nil or commit_msg == "" then
            vim.print("No commit message provided aborting...")
            return
          end

          -- Check if the git folder is a certain name
          local git_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
          local git_dir_name = vim.fn.fnamemodify(git_dir, ":t")
          local cmd = repo_pre_commit_mapping[git_dir_name]
          if cmd ~= nil then
            vim.print("Running " .. cmd .. " ...")
            -- Detached with jobstart (for shell commands)
            vim.fn.jobstart(cmd, {
              on_exit = function()
                vim.print("Running git commit -sam " .. commit_msg .. " ...")
                vim.fn.jobstart('git commit -sam ' .. commit_msg, {
                  on_exit = function()
                    GitPush()
                  end
                })
              end
            })
          else
            -- Commit the changes when the process is done
            vim.cmd.Git('commit -sam ' .. commit_msg)
            GitPush()
          end
        end, opts)
      end,
    })


    vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
    vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
  end
}
