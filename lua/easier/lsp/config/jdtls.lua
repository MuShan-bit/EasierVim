local common = require("easier.lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,

  on_attach = function(client,bufnr)
    common.keyAttach(bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}

