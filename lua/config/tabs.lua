-- A snacks picker source that lists the open tab pages.
--
-- Every entry is named after the working directory of the tab. For a git
-- worktree that is the repository and the worktree name, e.g. `atmos/master`.
-- The file that is open in the tab is shown on the right.

--- The normal window of a tab page.
--- Floating windows are skipped: the picker itself is a float in the current
--- tab, so it would otherwise be picked as the tab's window.
---@param tab number tab page handle
---@param tabnr number tab page number
---@return number? window handle
local function tab_window(tab, tabnr)
  local wins = vim.api.nvim_tabpage_list_wins(tab)
  -- the current window of the tab, unless it is a float
  local win = wins[vim.fn.tabpagewinnr(tabnr)]
  if win and vim.api.nvim_win_get_config(win).relative == "" then
    return win
  end
  -- otherwise the first normal window
  for _, w in ipairs(wins) do
    if vim.api.nvim_win_get_config(w).relative == "" then
      return w
    end
  end
end

--- A short name for a working directory.
--- For a git worktree this is the repository and the worktree name,
--- e.g. `atmos/master`. For a plain repository its directory name.
---@param cwd string
---@return string
local function dir_name(cwd)
  local dotgit = vim.fs.find(".git", { upward = true, path = cwd })[1]
  if not dotgit then
    return vim.fn.fnamemodify(cwd, ":~")
  end
  local dir = vim.fs.dirname(dotgit)
  if vim.uv.fs_stat(dotgit).type == "directory" then
    return vim.fn.fnamemodify(dir, ":t")
  end
  -- a linked worktree has a `.git` file pointing at the main repository:
  -- gitdir: <main repository>/.git/worktrees/<worktree name>
  local gitdir = vim.fn.readfile(dotgit, "", 1)[1] or ""
  local _, repo, worktree = gitdir:match("gitdir:%s*(.*)/([^/]+)/%.git/worktrees/([^/]+)$")
  return repo and (repo .. "/" .. worktree) or vim.fn.fnamemodify(dir, ":t")
end

--- Renders a tab entry: the label, a folder icon, the name of the working
--- directory and the file that is open in the tab.
--- The name is not a real path, so it must not go through the path shortening
--- that the `file` format does.
---@param item snacks.picker.finder.Item
---@param picker snacks.Picker
---@return snacks.picker.Highlight[]
local function tab_format(item, picker)
  local ret = {} ---@type snacks.picker.Highlight[]
  ret[#ret + 1] = { item.label, "SnacksPickerLabel" }
  ret[#ret + 1] = { " ", virtual = true }
  local name = item.item.name
  local icon, hl = Snacks.util.icon(vim.fn.fnamemodify(name, ":t"), "directory", { fallback = picker.opts.icons.files })
  ret[#ret + 1] = {
    Snacks.picker.util.align(icon, picker.opts.formatters.file.icon_width or 2),
    hl,
    virtual = true,
  }

  -- The list prepends a prefix to every line, so the entry is that much
  -- narrower than the list window.
  local icons = picker.opts.icons.ui
  local prefix = (#picker.list.selected > 0 or picker.opts.formatters.selected.show_always)
      and math.max(vim.api.nvim_strwidth(icons.selected), vim.api.nvim_strwidth(icons.unselected))
    or 1

  -- The name is resolved first, so that it is truncated to whatever is left
  -- over once the file name has been placed on the right.
  ret[#ret + 1] = {
    "",
    resolve = function(max)
      local text = Snacks.picker.util.truncate(name, math.max(max - prefix - 1, 1), true)
      local dir, base = text:match("^(.*)/(.+)$")
      return {
        { dir and (dir .. "/") or "", "SnacksPickerDir" },
        { base or text, "SnacksPickerDirectory" },
      }
    end,
  }

  -- The file name is pushed to the right edge of the list.
  ret[#ret + 1] = {
    "",
    resolve = function(max)
      return { { string.rep(" ", math.max(max - prefix, 0)) } }
    end,
  }
  ret[#ret + 1] = { item.comment, "SnacksPickerComment" }
  return ret
end

return {
  finder = function()
    local current = vim.api.nvim_get_current_tabpage()
    local items = {} ---@type snacks.picker.finder.Item[]
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local tabnr = vim.api.nvim_tabpage_get_number(tab)
      local win = tab_window(tab, tabnr)
      local path = win and vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)) or ""
      local base = path ~= "" and vim.fn.fnamemodify(path, ":t") or "[No Name]"
      -- `getcwd(winid, tabnr)` gives the working directory in effect in that tab
      local cwd = win and vim.fn.getcwd(win, tabnr) or vim.fn.getcwd()
      local dir = dir_name(cwd)
      items[#items + 1] = {
        -- `text` is what fuzzy matching runs against, so the tab number, the
        -- short name, the full path and the file are all searchable
        text = ("%d %s %s %s"):format(tabnr, dir, cwd, base),
        -- the full path, for `file:` patterns and path based scoring
        file = cwd,
        -- the short name of the working directory, e.g. `atmos/master`
        item = { tabnr = tabnr, name = dir },
        -- the file open in the tab, shown dimmed after the directory
        comment = base,
        -- rendered as a `SnacksPickerLabel` prefix
        label = ("%s%2d"):format(tab == current and "●" or " ", tabnr),
      }
    end
    return items
  end,
  format = tab_format,
  layout = { preset = "select" },
  -- `item.file` is a directory, so there is nothing to preview
  preview = "none",
  confirm = function(picker, item)
    picker:norm(function()
      local tabnr = item and item.item.tabnr
      picker:close()
      if tabnr and tabnr <= vim.fn.tabpagenr("$") then
        vim.cmd("tabnext " .. tabnr)
      end
    end)
  end,
  actions = {
    tabdelete = function(picker, item)
      picker:norm(function()
        local tabnr = item and item.item.tabnr
        picker:close()
        local count = vim.fn.tabpagenr("$")
        -- closing the only tab would leave you with no window
        if tabnr and count > 1 and tabnr <= count then
          vim.cmd("tabclose " .. tabnr)
        end
      end)
    end,
  },
  win = {
    input = {
      keys = {
        -- overrides the global `<c-x>` = `edit_split` for this picker only,
        -- since source config merges after global picker config
        ["<c-x>"] = { "tabdelete", mode = { "i", "n" } },
      },
    },
  },
}
