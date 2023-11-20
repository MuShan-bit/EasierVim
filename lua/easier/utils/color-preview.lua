-- based on https://www.youtube.com/playlist?list=PLOe6AggsTaVsMfLjXeavVwzkmOfAZnfQb
local telescope = pRequire("telescope")
if not telescope then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mycolors = { "nord", "onedark", "gruvbox", "tokyonight", "nightfox", "nordfox", "duskfox", "dracula" }

local mini = {
  layout_strategy = "vertical",
  layout_config = {
    width = 0.2,
    height = 12,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
}

local function enter(prompt_buffer)
  -- local selected = action_state.get_selected_entry()
  -- local cmd = "colorscheme " .. selected[1]
  -- vim.cmd(cmd)
  actions.close(prompt_buffer)
end

local function next_color(prompt_buffer)
  actions.move_selection_next(prompt_buffer)
  local selected = action_state.get_selected_entry()
  require("easier").config.colorscheme = selected[1]
  package.loaded["easier.plugins.lualine"] = nil
  require("easier.plugins.lualine")
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local function prev_color(prompt_buffer)
  actions.move_selection_previous(prompt_buffer)
  local selected = action_state.get_selected_entry()
  require("easier").config.colorscheme = selected[1]
  package.loaded["easier.plugins.lualine"] = nil
  require("easier.plugins.lualine")
  local cmd = "colorscheme " .. selected[1]
  vim.cmd(cmd)
end

local opts = {
  prompt_title = "colorscheme",
  initial_mode = "normal",
  finder = finders.new_table(mycolors),
  sorter = sorters.get_generic_fuzzy_sorter({}),
  attach_mappings = function(_, map)
    map("i", "<CR>", enter)
    map("i", "<C-i>", prev_color)
    map("i", "<C-k>", next_color)
    map("n", "<CR>", enter)
    map("n", "i", prev_color)
    map("n", "k", next_color)
    return true
  end,
}

local colorPicker = pickers.new(mini, opts)

local function colorPreview()
  colorPicker:find()
end

vim.api.nvim_create_user_command("EasierColorPreview", colorPreview, {})
