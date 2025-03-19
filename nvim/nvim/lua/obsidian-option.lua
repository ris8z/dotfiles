-- ui
vim.opt.conceallevel = 1

-- navigate to the brain 
--
vim.keymap.set("n", "<leader>oo", ":cd ~/file/2brain<cr>")



--formatting:
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>")

-- strip date from note title and replace dashes with spaces
-- must have cursor on title
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")



--Reviweing:
--
-- move file in the main folder
vim.keymap.set("n", "<leader>ok", ":!mv '%:p' ~/file/2brain/4_main<cr>:bd<cr>")

-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
