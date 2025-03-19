return {
	{
		"3rd/image.nvim",
		opts = {},
		config = function()
			local image = require("image")
			image.setup({
				backend = "kitty",
				processor = "magick_rock", -- or "magick_cli"
				integrations = {
					markdown = {
						resolve_image_path = function(document_path, image_path, fallback)
							local img_dir = "/home/ris8z/file/2brain/5_images"
							local full_path = img_dir .. "/" .. image_path

							local function file_exists(path)
								local file = io.open(path, "r")
								if file then
									file:close()
									return true
								else
									return false
								end
							end

							if file_exists(full_path) then
								return full_path
							end

							return fallback(document_path, image_path)
						end,
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						floating_windows = false, -- if true, images will be rendered in floating markdown windows
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
					neorg = {
						enabled = true,
						filetypes = { "norg" },
					},
					typst = {
						enabled = true,
						filetypes = { "typst" },
					},
					html = {
						enabled = false,
					},
					css = {
						enabled = false,
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
				editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
				tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
				hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
			})
		end,
	},
}
