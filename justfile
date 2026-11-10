mod ghostty
mod neovim

alias ghostty-build := ghostty::build
alias ghostty-link := ghostty::link
alias neovim-build := neovim::build
alias neovim-link := neovim::link

# Generate documentation, previews, and every registered app theme.
build:
    python3 -m _generator.generate

# Generate the README palette tables.
docs:
    python3 -m _generator.docs

# Generate the SVG palette previews.
assets:
    python3 -m _generator.assets
