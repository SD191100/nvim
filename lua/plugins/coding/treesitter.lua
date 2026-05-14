return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require('nvim-treesitter').setup {
        install_dir = vim.fn.stdpath('data') .. '/site',
    }

    require('nvim-treesitter').install({
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "asm",
    })
    
  end,
}
