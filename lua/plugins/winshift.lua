return {
  "sindrets/winshift.nvim",
  commit = "37468ed6f385dfb50402368669766504c0e15583",
  keys = function()
    local keys = {}
    for k, v in pairs({
      left = "<C-M-H>",
      down = "<C-M-J>",
      up = "<C-M-K>",
      right = "<C-M-L>",
    }) do
      table.insert(keys, {
        v,
        function()
          return require("winshift").cmd_winshift(k)
        end,
      })
    end

    return keys
  end,
}
