local cmp = require("easier").config.cmp
if not cmp then
  return
end

local M = {}
M.copilot = function()
  local copilot = pRequire("copilot")
  if copilot and cmp.copilot then
    copilot.setup({})
  end
end

M.copilot_cmp = function()
  local copilot_cmp = pRequire("copilot_cmp")
  if copilot_cmp and cmp.copilot then
    copilot_cmp.setup()
    keymap("n", cmp.keys.copilot_panel, "<CMD>Copilot panel<CR>")
  end
end

return M
