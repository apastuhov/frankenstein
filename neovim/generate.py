"""Copy the shared palette into the self-contained Neovim plugin."""

import json
import sys
from pathlib import Path


NEOVIM = Path(__file__).resolve().parent
ROOT = NEOVIM.parent
if __name__ == "__main__":
    sys.path.insert(0, str(ROOT))

from _generator.palette import load_palettes, write_outputs


def generate(palettes):
    return {NEOVIM / "palettes.json": json.dumps(palettes, indent=2) + "\n"}


if __name__ == "__main__":
    write_outputs(generate(load_palettes()))
