-- tokyonight theme
local tokyonight = pRequire("tokyonight")
if tokyonight then
  tokyonight.setup({
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = false, -- Enable this to disable setting the background color
  })
end
