local M = {}
local palette = require("frankenstein.palette")

function M.setup()
  vim.opt.termguicolors = true
  local group = vim.api.nvim_create_augroup("FrankensteinBackground", { clear = true })
  vim.api.nvim_create_autocmd("OptionSet", {
    group = group,
    pattern = "background",
    callback = function()
      if vim.g.colors_name == "creature_of_the_light" or vim.g.colors_name == "creature_of_the_night" then
        M.load(vim.o.background)
      end
    end,
  })
end

function M.load(appearance)
  local name = appearance == "light" and "creature_of_the_light" or "creature_of_the_night"
  if vim.g.colors_name ~= name and vim.o.background ~= appearance then
    -- Avoid reloading the previous colorscheme while changing the option.
    vim.g.colors_name = nil
    vim.o.background = appearance
  end

  M.setup()
  vim.cmd("highlight clear")
  vim.g.colors_name = name

  local colors = {}
  palette.apply(colors)
  local highlights = require("frankenstein.highlights").build(colors)
  for group, definition in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, definition)
  end
  for index, color in ipairs(palette.terminal()) do
    vim.g["terminal_color_" .. (index - 1)] = color
  end
end

return M
