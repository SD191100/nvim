return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "thin",
      show_buffer_close_icons = false,

      offsets = {
        {
          filetype = "NvimTree",
          text = " ",
          text_align = "left",
          separator = false,
        },
      }
    },
  },
  
}
