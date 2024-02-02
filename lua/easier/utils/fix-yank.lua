-- https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
vim.cmd([[
augroup fix_yank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/Windows/System32/clip.exe', @0) | endif
augroup END
]])
-- if vim.fn.has('wsl') then
--   vim.cmd [[
--   augroup Yank
--   autocmd!
--   autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
--   augroup END
--   ]]
-- end