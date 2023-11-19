-- stdpath("data")
-- macOS/Linux: ~/.local/share/nvim
-- Windows: ~/AppData/Local/nvim-data
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local M = {}

-- 存在性检测
M.avaliable = function()
  return vim.loop.fs_stat(lazypath)
end

-- 安装
M.install = function()
  vim.notify("Installing plugin manager lazy.nvim ...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.notify("plugin manager installed complete")
end

-- 装载
M.setup = function()
  vim.opt.rtp:prepend(lazypath)
  local status_ok, lazy = pcall(require, "lazy")
  if not status_ok then
    vim.notify("require lazy.nvim")
    return
  end
  local plugins = require("easier.plugins")
  lazy.setup(plugins)
end

return M
