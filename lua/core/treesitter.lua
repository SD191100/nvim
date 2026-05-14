vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.bo.buftype ~= "" then
      return -- ignore UI buffers like Telescope
    end

     -- check if treesitter supports this filetype

    local ok, lang = pcall(vim.treesitter.language.get_lang, vim.bo.filetype)
    if not ok or not lang then return end
    vim.treesitter.start()
     vim.schedule(function()
      pcall(function()
        require("nvim-ts-autotag").setup()
      end)
    end)
  end,
})
