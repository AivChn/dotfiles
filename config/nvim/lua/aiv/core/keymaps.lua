vim.g.mapleader = " "

local keymap = vim.keymap

-- movement realted keymaps
-- move 100 lines up or down
keymap.set("n", "<leader>jj", "100j", { desc = "Go down 100 lines" })
keymap.set("n", "<leader>kk", "100k", { desc = "Go up 100 lines" })

-- Move halfway up or down
keymap.set("n", "<leader>ahead", function()
	local distance = math.floor((vim.fn.line("$") - vim.fn.line(".")) / 2)
	vim.cmd("normal! " .. distance .. "j")
end, { desc = "jump halfway to the end of the file" })
keymap.set("n", "<leader>back", function()
	local distance = math.floor(vim.fn.line(".") / 2)
	vim.cmd("normal! " .. distance .. "k")
end, { desc = "Jump halfway to the beginning of the file" })

-- looks related keymaps
keymap.set("n", "<leader>csh", ":nohl<CR>", { desc = "Clear search highlights" })

-- edit realted keymaps
-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- tab and windows realted keymaps
keymap.set("n", "<leader>spt", "<cmd>vsplit | term<CR>", { desc = "Open a terminal in a vertical split" })
keymap.set(
	"n",
	"<leader>spe",
	"<cmd>vsplit<CR>:e ",
	{ desc = "Opens a new vertical split and primes :e for changing file" }
)
keymap.set("n", "<leader>spx", "<cmd>close<CR>", { desc = "Close current window" })

-- neotree
-- open neotree
keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", { desc = "Toggle neotree" })
keymap.set("n", "<leader>onb", "<cmd>Neotree focus buffers<CR>", { desc = "open neotree buffers list" })
keymap.set("n", "<leader>ong", "<cmd>Neotree focus git_status<CR>", { desc = "open neotree git list" })
--keymap.set("n", "<leader>ond", "<cmd>Neotree focus document_symbols<CR>", { desc = "open neotree git list" })

-- telescope keymaps
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "Switch buffers" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
keymap.set("n", "<leader>fi", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in current buffer" })
keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Fuzzy find in diagontics in file" })

-- auto session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
-- Text object
vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Gitsigns select hunk" })

-- lsp-config
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
	end,
})

-- lazygit - IN FILE (recommended)

-- todo-comments - IN FILE (easier to handle)

-- lint - IN FILE

-- trouble - IN FILE
