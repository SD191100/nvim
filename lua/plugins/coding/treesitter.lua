-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	lazy = false,
-- 	build = ":TSUpdate",
-- 	dependencies = {
-- 		"windwp/nvim-ts-autotag",
-- 	},
-- 	config = function()
-- 		require("nvim-treesitter").setup({
-- 			install_dir = vim.fn.stdpath("data") .. "/site",
-- 		})
--
-- 		require("nvim-treesitter").install{
-- 			"json",
-- 			"javascript",
-- 			"typescript",
-- 			"tsx",
-- 			"yaml",
-- 			"html",
-- 			"css",
-- 			"prisma",
-- 			"markdown",
-- 			"markdown_inline",
-- 			"svelte",
-- 			"graphql",
-- 			"bash",
-- 			"lua",
-- 			"vim",
-- 			"dockerfile",
-- 			"gitignore",
-- 			"query",
-- 			"vimdoc",
-- 			"c",
-- 			"asm",
-- 			"go",
-- 			"gomod",
-- 			"gosum",
-- 			"gowork",
-- 		}
-- 	end,
-- }
--
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Explicitly target the new rewrite branch
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    init = function()
        -- 1. The rewrite doesn't have an internal 'highlight' configuration toggle.
        -- We turn on Neovim's native 0.12 Treesitter engine via an Autocmd instead.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        -- 2. Diffs your needed languages against what's already installed
        -- so it only downloads asynchronously when missing.
        local ensure_installed = {
            "json", "javascript", "typescript", "tsx", "yaml", "html", "css",
            "prisma", "markdown", "markdown_inline", "svelte", "graphql",
            "bash", "lua", "vim", "dockerfile", "gitignore", "query",
            "vimdoc", "c", "asm", "go", "gomod", "gosum", "gowork",
        }

        local config_module = require("nvim-treesitter.config")
        if config_module and config_module.get_installed then
            local already_installed = config_module.get_installed()
            local parsers_to_install = {}

            for _, parser in ipairs(ensure_installed) do
                if not vim.tbl_contains(already_installed, parser) then
                    table.insert(parsers_to_install, parser)
                end
            end

            if #parsers_to_install > 0 then
                -- Safely triggers the new async installer
                require("nvim-treesitter").install(parsers_to_install)
            end
        end
    end,
    config = function()
        -- The modern top-level setup module (Singular config)
        require("nvim-treesitter.config").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Setup your autotag plugin independently
        require("nvim-ts-autotag").setup()
    end,
}
