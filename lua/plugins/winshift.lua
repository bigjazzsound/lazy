return {
  "sindrets/winshift.nvim",
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
