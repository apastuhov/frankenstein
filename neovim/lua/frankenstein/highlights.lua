return {
  build = function(colors)
    local highlights = {
      Normal = { fg = colors.fg_main, bg = colors.bg_main },
      NormalNC = { fg = colors.fg_main, bg = colors.bg_main },
      NormalFloat = { fg = colors.fg_main, bg = colors.bg_popup },
      FloatBorder = { fg = colors.border, bg = colors.bg_popup },
      FloatTitle = { fg = colors.accent, bg = colors.bg_popup, bold = true },
      LineNr = { fg = colors.fg_dim },
      SignColumn = { fg = colors.fg_dim, bg = colors.bg_main },
      FoldColumn = { fg = colors.fg_dim, bg = colors.bg_main },
      Folded = { fg = colors.fg_dim, bg = colors.bg_dim },
      CursorColumn = { bg = colors.bg_dim },
      ColorColumn = { bg = colors.bg_dim },
      NonText = { fg = colors.fg_dim },
      SpecialKey = { fg = colors.fg_dim },
      Whitespace = { fg = colors.fg_dim },
      EndOfBuffer = { fg = colors.bg_main },
      VertSplit = { fg = colors.border },
      WinSeparator = { fg = colors.border },
      StatusLine = { fg = colors.fg_status_line_active, bg = colors.bg_status_line_active },
      StatusLineNC = { fg = colors.fg_status_line_inactive, bg = colors.bg_status_line_inactive },
      WinBar = { fg = colors.fg_main, bg = colors.bg_main },
      WinBarNC = { fg = colors.fg_dim, bg = colors.bg_main },
      TabLine = { fg = colors.fg_tab_other, bg = colors.bg_tab_other },
      TabLineFill = { bg = colors.bg_tab_bar },
      TabLineSel = { fg = colors.fg_main, bg = colors.bg_tab_current, bold = true },
      Pmenu = { fg = colors.fg_main, bg = colors.bg_popup },
      PmenuSbar = { bg = colors.bg_dim },
      PmenuThumb = { bg = colors.fg_dim },
      Directory = { fg = colors.blue },
      Title = { fg = colors.accent, bold = true },
      MoreMsg = { fg = colors.success },
      ModeMsg = { fg = colors.fg_main, bold = true },
      Question = { fg = colors.success },
      WarningMsg = { fg = colors.warning },
      DiffAdd = { bg = colors.bg_added },
      DiffChange = { bg = colors.bg_changed },
      DiffDelete = { fg = colors.fg_removed, bg = colors.bg_removed },
      DiffText = { bg = colors.bg_changed_refine },
      SpellBad = { undercurl = true, sp = colors.error },
      SpellCap = { undercurl = true, sp = colors.warning },
      SpellLocal = { undercurl = true, sp = colors.hint },
      SpellRare = { undercurl = true, sp = colors.info },
      DiagnosticError = { fg = colors.error },
      DiagnosticWarn = { fg = colors.warning },
      DiagnosticInfo = { fg = colors.info },
      DiagnosticHint = { fg = colors.hint },
      DiagnosticOk = { fg = colors.success },
    }
    -- Use a small set of muted syntax accents and dim punctuation.
    local groups = {
      [colors.fg_main] = {
        "Constant",
        "Identifier",
        "Special",
        "SpecialChar",
        "Tag",
        "Debug",
      },
      [colors.blue_faint] = {
        "Statement",
        "Conditional",
        "Repeat",
        "Label",
        "Keyword",
        "Exception",
        "PreProc",
        "Include",
        "Define",
        "PreCondit",
        "StorageClass",
        "Boolean",
      },
      [colors.green_faint] = { "Function", "Macro" },
      [colors.operator] = { "Operator" },
      [colors.magenta_faint] = {},
      [colors.yellow_faint] = { "String", "Character", "Number", "Float", "Todo" },
      [colors.cyan_faint] = { "Type", "Structure", "Typedef", "TypeDef" },
      [colors.fg_dim] = { "Comment", "SpecialComment", "Delimiter" },
    }
    for color, names in pairs(groups) do
      for _, name in ipairs(names) do
        highlights[name] = { fg = color }
      end
    end

    -- Treesitter captures sometimes define their own colors instead of linking.
    local captures = {
      variable = colors.fg_main,
      ["function"] = colors.green_faint,
      type = colors.cyan_faint,
      constant = colors.fg_main,
      constructor = colors.cyan_faint,
      module = colors.fg_main,
      property = colors.fg_main,
      attribute = colors.fg_main,
      tag = colors.fg_main,
      number = colors.yellow_faint,
      operator = colors.operator,
      punctuation = colors.fg_dim,
      keyword = colors.blue_faint,
      boolean = colors.blue_faint,
      string = colors.yellow_faint,
      character = colors.yellow_faint,
      comment = colors.fg_dim,
    }
    for name, color in pairs(captures) do
      highlights["@" .. name] = { fg = color }
    end
    highlights["@string.documentation"] = { link = "Comment" }
    highlights["@operator"] = { link = "Operator" }
    highlights["@keyword.conditional.ternary"] = { link = "Operator" }
    -- Word operators such as new, typeof, and instanceof are language keywords.
    highlights["@keyword.operator"] = { link = "Keyword" }
    highlights["@comment.todo"] = { link = "Todo" }

    if vim.o.background == "light" then
      -- Lua table braces are constructor captures; keep them quieter than types.
      highlights["@constructor.lua"] = { link = "Delimiter" }
    end

    -- Keep language-server highlights consistent with Treesitter.
    highlights["@lsp.type.keyword"] = { link = "Keyword" }
    highlights["@lsp.type.operator"] = { link = "Operator" }
    highlights["@lsp.type.function"] = { link = "Function" }
    highlights["@lsp.type.method"] = { link = "Function" }
    for _, kind in ipairs({
      "type",
      "class",
      "interface",
      "struct",
      "enum",
      "typeParameter",
      "typeAlias",
      "builtinType",
    }) do
      highlights["@lsp.type." .. kind] = { link = "Type" }
    end
    highlights["@lsp.typemod.type.defaultLibrary"] = { link = "Type" }
    highlights["@lsp.typemod.typeAlias.defaultLibrary"] = { link = "Type" }

    highlights.CursorLine = { bg = colors.bg_dim }
    highlights.CursorLineNr = { fg = colors.fg_main, bold = true }
    highlights.Cursor = { fg = colors.cursor_foreground, bg = colors.cursor }

    highlights.Search = {
      fg = colors.green_intense,
      bg = colors.bg_dim,
    }
    highlights.CurSearch = {
      fg = colors.cur_search_fg,
      bg = colors.cur_search_bg,
      bold = true,
    }
    highlights.IncSearch = { link = "CurSearch" }
    highlights.Substitute = { link = "CurSearch" }
    highlights.Visual = {
      fg = colors.selection_foreground,
      bg = colors.visual,
    }
    for _, name in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
      highlights[name] = { link = "Search" }
    end

    highlights.PmenuSel = { fg = colors.selection_foreground, bg = colors.visual }
    highlights.PmenuMatch = { fg = colors.green_intense, bold = true }
    highlights.PmenuMatchSel = { fg = colors.selection_foreground, bg = colors.visual, bold = true }
    -- Match accents must also stay readable on the green selection.
    highlights.BlinkCmpLabelMatch = { bold = true }
    highlights.QuickFixLine = { link = "Visual" }
    highlights.WildMenu = { link = "PmenuSel" }
    highlights.NvimTreeCursorLine = { link = "PmenuSel" }
    highlights.MatchParen = { fg = colors.green_intense, bg = colors.bg_dim, bold = true }
    highlights.Error = { fg = colors.error, undercurl = true, sp = colors.underline_error }
    highlights.ErrorMsg = { fg = colors.error, bold = true }

    for _, severity in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
      local color = highlights["Diagnostic" .. severity].fg
      highlights["DiagnosticSign" .. severity] = { link = "Diagnostic" .. severity }
      highlights["DiagnosticVirtualText" .. severity] = { fg = color, bg = colors.bg_dim }
      highlights["DiagnosticUnderline" .. severity] = { undercurl = true, sp = color }
    end

    return highlights
  end,
}
