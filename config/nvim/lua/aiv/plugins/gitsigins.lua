return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
			vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })

			-- Actions
			vim.keymap.set("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage hunk" })
			vim.keymap.set("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset hunk" })

			vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
			vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })

			vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

			vim.keymap.set("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame line" })
			vim.keymap.set("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })

			vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
			vim.keymap.set("n", "<leader>hD", function()
				gs.diffthis("~")
			end, { desc = "Diff this ~" })
		end,
	},
}
