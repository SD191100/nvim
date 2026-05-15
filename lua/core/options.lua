vim.cmd("let g:netrw_liststyle =3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
-- opt.softtabstop = 4

opt.wrap = true

opt.ignorecase = true
opt.smartcase = true

-- opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.swapfile = false

opt.laststatus = 3

local function apply_ui()
	local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	vim.api.nvim_set_hl(0, "WinSeparator", {
		fg = "#2e3440",
		bg = "NONE",
	})

	vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", {
		fg = "#282C34",
		bg = "NONE",
	})

	-- vim.opt.fillchars = {
	-- vert = "|",
	-- }

	vim.opt.fillchars:append({
		eob = " ",
	})

	vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", {
		fg = "#3e3e3e",
	})

	vim.api.nvim_set_hl(0, "NvimTreeCursorLine", {
		bg = "#2e2e2e",
	})
end

apply_ui()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_ui,
})
