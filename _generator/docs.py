"""Generate README palette tables."""

from _generator.palette import ANSI, ROOT, load_palettes, write_outputs
from _generator.preview_data import SURFACES, THEMES


SEMANTIC = (("operator", "Symbolic operators (`operator`)"),)
BEGIN = "<!-- BEGIN GENERATED PALETTES -->"
END = "<!-- END GENERATED PALETTES -->"


def swatch(color):
    return f"$\\color{{{color}}}{{\\blacksquare}}$ `{color}`"


def readme_tables(palettes):
    dark, light = palettes["dark"], palettes["light"]
    lines = [
        "### Surfaces and interaction",
        "",
        f"| Token or role | {THEMES['dark']} | {THEMES['light']} |",
        "| --- | --- | --- |",
        *(
            f"| {label} | {swatch(dark[token])} | {swatch(light[token])} |"
            for token, label in SURFACES
        ),
        "",
        "Use raised surfaces to distinguish secondary areas from the main background.",
        "",
        "### ANSI palette",
        "",
        "ANSI slot names describe terminal color roles. In light mode, the white slots are",
        "dark neutrals suitable for text. Bright slots are alternate accents; they can be",
        "deeper rather than lighter on a pale background.",
        "",
        f"| ANSI slot | Token | {THEMES['dark']} | {THEMES['light']} |",
        "| --- | --- | --- | --- |",
        *(
            f"| {index} | {token.replace('_', ' ').capitalize()} | {swatch(dark[token])} | {swatch(light[token])} |"
            for index, token in enumerate(ANSI)
        ),
        "",
        "### Additional semantic colors",
        "",
        f"| Role | {THEMES['dark']} | {THEMES['light']} |",
        "| --- | --- | --- |",
        *(
            f"| {label} | {swatch(dark[token])} | {swatch(light[token])} |"
            for token, label in SEMANTIC
        ),
    ]
    return "\n".join(lines)



def generate(palettes):
    path = ROOT / "README.md"
    readme = path.read_text(encoding="utf-8")
    before, body = readme.split(BEGIN, 1)
    _, after = body.split(END, 1)
    return {path: before + BEGIN + "\n\n" + readme_tables(palettes) + "\n\n" + END + after}


if __name__ == "__main__":
    write_outputs(generate(load_palettes()))
