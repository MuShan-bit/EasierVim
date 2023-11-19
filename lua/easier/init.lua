local M = {}
M.version = "v0.10.1"

---@type UserConfig
M.config = require("easier.config")
--- @param user_config UserConfig
function M.setup(user_config)
  require("easier.utils.global")
  require("easier.basic")
  -- user config override
  M.config = vim.tbl_deep_extend("force", M.config, user_config)
  require("easier.env").init(M.config)
  require("easier.keybindings")
  local pluginManager = require("easier.lazy")
  if not pluginManager.avaliable() then
    pluginManager.install()
  end
  pluginManager.setup()
  require("easier.autocmds")
  require("easier.lsp")
  require("easier.cmp")
  require("easier.format")
  require("easier.dap")
  require("easier.colorscheme")
  require("easier.utils.color-preview")
  if M.config.fix_windows_clipboard then
    require("utils.fix-yank")
  end
end

return M
