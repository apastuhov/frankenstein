"""Load and validate the shared palette used by all generators."""

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ANSI = (
    "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white",
    "bright_black", "bright_red", "bright_green", "bright_yellow",
    "bright_blue", "bright_magenta", "bright_cyan", "bright_white",
)
REQUIRED = set(ANSI) | {
    "background", "foreground", "surface", "selection", "selection_foreground",
    "cursor", "cursor_foreground", "operator",
}


def load_palettes():
    palettes = json.loads((ROOT / "palettes.json").read_text(encoding="utf-8"))
    for appearance in ("dark", "light"):
        for token in sorted(REQUIRED):
            value = palettes[appearance][token]
            if not isinstance(value, str) or not re.fullmatch(r"#[0-9A-Fa-f]{6}", value):
                raise ValueError(f"Invalid color for {appearance}.{token}: {value!r}")
    return palettes


def write_outputs(outputs):
    for path, content in outputs.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
