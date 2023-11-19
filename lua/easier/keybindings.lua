-- For common keybindings -------------------------------

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
---------------------------------------------------------

local cfg = require("easier").config
local keys = cfg.keys
if not keys then
  return
end

-- leader key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- save && quit
keymap("n", keys.save, "<CMD>w<CR>")
keymap("n", keys.quit, "<CMD>q<CR>")
keymap("n", keys.force_quit, "<CMD>qa!<CR>")

-- move | quick_move
keymap({ "n", "v", "x" }, keys.move.up, "k")
keymap({ "n", "v", "x" }, keys.move.down, "j")
keymap({ "n", "v", "x" }, keys.move.left, "h")
keymap({ "n", "v", "x" }, keys.move.right, "l")
keymap({ "n", "v", "x" }, keys.move.quick_up, table.concat({keys.move.row_step,"k"}))
keymap({ "n", "v", "x" }, keys.move.quick_down, table.concat({keys.move.row_step,"j"}))
keymap({ "n", "v", "x" }, keys.move.quick_left, table.concat({keys.move.col_step,"h"}))
keymap({ "n", "v", "x" }, keys.move.quick_right, table.concat({keys.move.col_step,"l"}))

-- enter insert mode
keymap("n", keys.insert.left, "i")
keymap("n", keys.insert.right, "a")
keymap("n", keys.insert.row_left, "I")
keymap("n", keys.insert.row_right, "A")

-- cancel and repeat
keymap("n", keys.cancel, "u")
keymap("n", keys.repetition, "<C-r>")

-- cut
keymap("v", keys.cut.base, "d")
keymap("n", keys.cut.up, "dk")
keymap("n", keys.cut.down, "dj")
keymap("n", keys.cut.left, "dh")
keymap("n", keys.cut.right, "dl")
keymap("n", keys.cut.row, "dd")

-- copy
keymap("v", keys.copy.base, "y")
keymap("n", keys.copy.up, "yk")
keymap("n", keys.copy.down, "yj")
keymap("n", keys.copy.left, "yh")
keymap("n", keys.copy.right, "yl")
keymap("n", keys.copy.row, "yy")

-- paste
keymap("n", keys.paste.left, "P")
keymap("n", keys.paste.right, "p")
-- visual mode use paste, not copy
keymap({"x", "v"}, { paste.left, paste.right }, '"_dP')

-- Indent code
keymap("v", keys.indent_left, "<gv")
keymap("v", keys.indent_left, ">gv")
keymap("n", keys.indent_right, "<<CR>")
keymap("n", keys.indent_right, "><CR>")

-- Previous command/Next command
keymap("c", keys.pre_command, "<C-n>")
keymap("c", keys.next_command, "<C-p>")

-- terminal
keymap("n", "tt", "<CMD>term<CR>")
keymap("n", {"ti", "tk"}, "<CMD>sp | terminal<CR>")
keymap("n", {"tj", "tl"}, "<CMD>vsp | terminal<CR>")

-- transfer move selected text
keymap({"x", "v"}, keys.transfer.up, ":move '>+1<CR>gv-gv")
keymap({"x", "v"}, keys.transfer.down, ":move '<-2<CR>gv-gv")

-------------------- fix ------------------------------

local opts_expr = {
  expr = true,
  silent = true,
}

-- fix :set wrap
keymap("n", keys.move.down, "v:count == 0 ? 'gj' : 'j'", opts_expr)
keymap("n", keys.move.up, "v:count == 0 ? 'gk' : 'k'", opts_expr)

-- very magic search mode
if cfg.enable_very_magic_search then
  keymap({ "n", "v" }, "/", "/\\v", {
    remap = false,
    silent = false,
  })
  keymap("c", "s/", "s/\\v", {
    remap = false,
    silent = false,
  })
end

--------------- super window -----------------------
if cfg.s_windows ~= nil and cfg.s_windows.enable then
  local skey = cfg.s_windows.keys
  keymap("n", "s", "")
  keymap("n", skey.split_vertically, ":vsp<CR>")
  keymap("n", skey.split_horizontally, ":sp<CR>")
  keymap("n", skey.close, "<C-w>c")
  keymap("n", skey.close_others, "<C-w>o") -- close others
  keymap("n", skey.jump_left, "<C-w>h")
  keymap("n", skey.jump_down, "<C-w>j")
  keymap("n", skey.jump_up, "<C-w>k")
  keymap("n", skey.jump_right, "<C-w>l")
  keymap("n", skey.width_decrease, ":vertical resize -10<CR>")
  keymap("n", skey.width_increase, ":vertical resize +10<CR>")
  keymap("n", skey.height_decrease, ":horizontal resize -10<CR>")
  keymap("n", skey.height_increase, ":horizontal resize +10<CR>")
  keymap("n", skey.size_equal, "<C-w>=")
end

-------------- super tab ---------------------------

if cfg.s_tab ~= nil and cfg.s_tab.enable then
  local tkey = cfg.s_tab.keys
  keymap("n", tkey.split, "<CMD>tab split<CR>")
  keymap("n", tkey.close, "<CMD>tabclose<CR>")
  keymap("n", tkey.next, "<CMD>tabnext<CR>")
  keymap("n", tkey.prev, "<CMD>tabprev<CR>")
  keymap("n", tkey.first, "<CMD>tabfirst<CR>")
  keymap("n", tkey.last, "<CMD>tablast<CR>")
end

-- treesitter fold
keymap("n", keys.fold.open, ":foldopen<CR>")
keymap("n", keys.fold.close, ":foldclose<CR>")

-- Esc back to Normal mode
keymap("t", keys.terminal.back_normal, "<C-\\><C-n>")

-- DEPRECATED :Terminal kes
-- map("n", "st", ":sp | terminal<CR>", opt)
-- map("n", "stv", ":vsp | terminal<CR>", opt)
-- map("t", "<A-j>", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<A-k>", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<A-i>", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
-- map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
-- map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
-- map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
-- map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)