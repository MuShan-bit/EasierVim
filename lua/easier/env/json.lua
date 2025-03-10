--- @param config JsonConfig
return function(config)
  return {

    getFormatOnSavePattern = function()
      if config.format_on_save then
        return { "*.json" }
      end
      return {}
    end,

    getTSEnsureList = function()
      return { "json" }
    end,

    getLSPEnsureList = function()
      return { "jsonls" }
    end,

    getLSPConfigMap = function()
      return {
        jsonls = require("easier.lsp.config.json"),
      }
    end,

    getToolEnsureList = function()
      if config.formatter == "fixjson" then
        return { "fixjson" }
      end
      if config.formatter == "prettier" then
        return { "prettier" }
      end
    end,

    getNulllsSources = function()
      local null_ls = pRequire("null-ls")
      if not null_ls then
        return {}
      end
      if config.formatter == "fixjson" then
        return { null_ls.builtins.formatting.fixjson }
      elseif config.formatter == "prettier" then
        return { null_ls.builtins.formatting.prettier.with({
          filetypes = { "json" },
        }) }
      end
      return {}
    end,

    getNeotestAdapters = function()
      return {}
    end,
  }
end
