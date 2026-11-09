local M = {}

-- Resolve the shared source relative to this module so the project can move.
local source = debug.getinfo(1, "S").source:sub(2)
local palette_file = vim.fs.normalize(vim.fs.joinpath(
  vim.fs.dirname(source), "..", "..", "palettes.json"
))

function M.palette()
  -- Read on each theme load so colorscheme reloads pick up palette edits.
  local palettes = vim.json.decode(table.concat(vim.fn.readfile(palette_file), "\n"))
  return palettes[vim.o.background]
end

function M.terminal()
  local palette = M.palette()
  return {
    palette.black, palette.red, palette.green, palette.yellow,
    palette.blue, palette.magenta, palette.cyan, palette.white,
    palette.bright_black, palette.bright_red, palette.bright_green, palette.bright_yellow,
    palette.bright_blue, palette.bright_magenta, palette.bright_cyan, palette.bright_white,
  }
end

-- Derive quiet diff and highlight backgrounds from the same accent colors.
local function tint(palette, color, amount)
  local result = "#"
  for channel = 2, 6, 2 do
    local base = tonumber(palette.background:sub(channel, channel + 1), 16)
    local accent = tonumber(color:sub(channel, channel + 1), 16)
    result = result .. string.format("%02x", math.floor(base + (accent - base) * amount + 0.5))
  end
  return result
end

function M.apply(colors)
  local palette = M.palette()
  local roles = {
    background = { "bg_main", "bg_inactive", "bg_tab_current", "bg_diff_context" },
    surface = {
      "bg_dim", "bg_alt", "bg_active", "bg_sidebar", "bg_popup", "bg_completion",
      "bg_hl_line", "bg_paren_match", "bg_paren_expression", "bg_status_line_active",
      "bg_status_line_inactive", "bg_tab_bar", "bg_tab_other", "bg_tab_alternate",
    },
    foreground = {
      "fg_main", "fg_active", "fg_sidebar", "fg_status_line_active",
      "identifier", "variable_use", "constant", "builtin",
    },
    white = { "fg_alt", "fg_status_line_inactive", "fg_tab_other" },
    bright_black = { "fg_dim", "fg_inactive", "comment", "docstring", "border" },
    green = {
      "accent", "accent_light", "accent_dark", "accent_darker",
      "fn", "fn_call", "fg_added", "fg_added_intense", "bg_added_fringe", "success", "ok", "olive",
    },
    bright_green = { "border_highlight", "info" },
    operator = { "operator" },
    yellow = { "warning", "string", "gold", "fg_changed", "fg_changed_intense", "bg_changed_fringe" },
    bright_yellow = { "underline_warning" },
    red = { "error", "rust", "fg_removed", "fg_removed_intense", "bg_removed_fringe" },
    bright_red = { "underline_error" },
    blue = { "keyword", "preproc", "slate", "indigo" },
    cyan = { "type", "hint", "underline_note" },
    magenta = { "pink", "maroon" },
    selection = { "visual" },
    selection_foreground = { "selection_foreground" },
    cursor = { "cursor" },
    cursor_foreground = { "cursor_foreground" },
  }
  for name, names in pairs(roles) do
    for _, role in ipairs(names) do
      colors[role] = palette[name]
    end
  end

  for _, name in ipairs({ "red", "green", "yellow", "blue", "magenta", "cyan" }) do
    colors[name] = palette[name]
    colors[name .. "_faint"] = palette[name]
    colors[name .. "_warmer"] = palette[name]
    colors[name .. "_cooler"] = palette[name]
    colors[name .. "_intense"] = palette["bright_" .. name]
    colors["bg_" .. name .. "_intense"] = tint(palette, palette[name], 0.25)
    colors["bg_" .. name .. "_subtle"] = tint(palette, palette[name], 0.16)
    colors["bg_" .. name .. "_nuanced"] = tint(palette, palette[name], 0.10)
  end

  for kind, name in pairs({ added = "green", changed = "yellow", removed = "red" }) do
    colors["bg_" .. kind] = tint(palette, palette[name], 0.12)
    colors["bg_" .. kind .. "_faint"] = tint(palette, palette[name], 0.06)
    colors["bg_" .. kind .. "_refine"] = tint(palette, palette[name], 0.24)
  end

  colors.bg_char_0 = colors.bg_green_intense
  colors.bg_char_1 = colors.bg_yellow_intense
  colors.bg_char_2 = colors.bg_red_intense

  local light = vim.o.background == "light"
  colors.cur_search_bg = light and tint(palette, palette.yellow, 0.22) or palette.yellow
  colors.cur_search_fg = light and palette.foreground or palette.background

  for _, name in ipairs({ "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }) do
    for _, prefix in ipairs({ "bg_term_", "fg_term_" }) do
      colors[prefix .. name] = palette[name]
      colors[prefix .. name .. "_bright"] = palette["bright_" .. name]
    end
  end
end

return M
