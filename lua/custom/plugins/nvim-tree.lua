return {
	"nvim-tree/nvim-tree.lua",
	requires = "nvim-tree/nvim-web-devicons",
	config = function()
		local status_ok, nvim_tree = pcall(require, "nvim-tree")
		if not status_ok then
			return
		end
		nvim_tree.setup({
			disable_netrw = true,
			hijack_netrw = true,
			--[[ open_on_setup = false, ]]
			--[[ ignore_ft_on_setup = { ]]
			--[[ 	"startify", ]]
			--[[ 	"dashboard", ]]
			--[[ 	"alpha", ]]
			--[[ }, ]]
			-- auto_close = true,
			open_on_tab = false,
			hijack_cursor = false,
			update_cwd = true,
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 500,
			},
			view = {
				width = 30,
				--[[ height = 30, ]]
				-- hide_root_folder = false,
				side = "left",
				number = false,
				relativenumber = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
			renderer = {
				root_folder_modifier = ":t",
				highlight_git = true,
				icons = {
					show = {
						git = true,
						folder = true,
						file = true,
						folder_arrow = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							deleted = "",
							untracked = "U",
							ignored = "◌",
						},
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
				},
			},
			filters = {
				dotfiles = false,
				exclude = { ".env", ".env.*" },
			},
		})

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true
				}
			end

			vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
		end

		nvim_tree.on_attach = on_attach
	end
}
