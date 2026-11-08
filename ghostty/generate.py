"""Generate Ghostty themes from the shared palette."""

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
if __name__ == "__main__":
    # Allow direct execution from any directory to import the shared generator code.
    sys.path.insert(0, str(ROOT))

from _generator.palette import ANSI, load_palettes, write_outputs

THEMES = {
    "dark": "frankenstein_creature_of_the_night",
    "light": "frankenstein_creature_of_the_light",
}


def ghostty_theme(palette):
    fields = (
        ("background", "background"),
        ("foreground", "foreground"),
        ("cursor-color", "cursor"),
        ("cursor-text", "cursor_foreground"),
        ("selection-background", "selection"),
        ("selection-foreground", "selection_foreground"),
        ("split-divider-color", "surface"),
    )
    lines = [
        "# https://github.com/apastuhov/frankenstein",
        "# Generated from palettes.json by ghostty/generate.py.",
        "# Edit the source palette, then regenerate this file.",
        "",
        *(f"{option} = {palette[token]}" for option, token in fields),
        "",
        "# ANSI colors 0-15.",
        *(f"palette = {index}={palette[token]}" for index, token in enumerate(ANSI)),
    ]
    return "\n".join(lines) + "\n"


def generate(palettes):
    return {
        ROOT / "ghostty" / "themes" / name: ghostty_theme(palettes[appearance])
        for appearance, name in THEMES.items()
    }


if __name__ == "__main__":
    write_outputs(generate(load_palettes()))
