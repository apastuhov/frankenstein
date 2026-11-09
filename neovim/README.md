# Frankenstein for Neovim

From the repository root, generate the palette and link the theme into Neovim's package directory:

```sh
just neovim::build
just neovim::link
```

Keep the repository at the same path so the link remains valid. The link command leaves an existing file or directory untouched; remove or move a conflicting entry first.

Then configure Neovim:

```lua
vim.cmd.packadd("frankenstein")
require("frankenstein").setup()
vim.cmd.colorscheme(
  vim.o.background == "light" and "creature_of_the_light" or "creature_of_the_night"
)
```

`setup()` is optional when loading a colorscheme directly. Select either variant explicitly:

```vim
:colorscheme creature_of_the_night
:colorscheme creature_of_the_light
```

Explicit selection sets the corresponding background; later background changes reload the matching variant. The first 16 embedded-terminal colors use the theme palette; the remaining slots retain their defaults.

Tree-sitter and language-server highlighting depends on the relevant parsers and servers. Highlighting TODO and FIXME inside comments also requires the Tree-sitter `comment` parser and the language's comment injections.
