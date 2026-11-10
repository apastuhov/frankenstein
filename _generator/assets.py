"""Generate SVG palette previews."""

from _generator.palette import ANSI, ROOT, load_palettes, write_outputs
from _generator.preview_data import SURFACES, THEMES


def preview(palette, name):
    p = palette
    lines = [
        '<svg xmlns="http://www.w3.org/2000/svg" width="960" height="820" viewBox="0 0 960 820" role="img">',
        f'<title>{name} terminal and palette preview</title>',
        f'<rect width="960" height="820" rx="12" fill="{p["background"]}"/>',
        f'<path d="M12 0H948Q960 0 960 12V72H0V12Q0 0 12 0" fill="{p["surface"]}"/>',
        f'<text x="32" y="45" fill="{p["foreground"]}" font-family="monospace" font-size="22">{name} · terminal preview</text>',
        '<g font-family="monospace" font-size="21" xml:space="preserve">',
        f'<text x="32" y="120" fill="{p["foreground"]}"><tspan fill="{p["green"]}">dotfiles</tspan> on <tspan fill="{p["blue"]}">main</tspan></text>',
        f'<text x="32" y="156" fill="{p["foreground"]}"><tspan fill="{p["green"]}">❯</tspan> git status --short</text>',
        f'<text x="32" y="192" fill="{p["foreground"]}"><tspan fill="{p["green"]}">M </tspan> ghostty/config</text>',
        f'<text x="32" y="228" fill="{p["foreground"]}"><tspan fill="{p["cyan"]}">??</tspan> nvim/init.lua</text>',
        f'<text x="32" y="286" fill="{p["bright_black"]}">muted text <tspan fill="{p["yellow"]}">  warning</tspan><tspan fill="{p["red"]}">  error</tspan></text>',
        f'<text x="32" y="322" fill="{p["bright_green"]}">3 notifications</text>',
        f'<rect x="280" y="299" width="180" height="30" fill="{p["selection"]}"/>',
        f'<text x="290" y="322" fill="{p["selection_foreground"]}">selected text</text>',
        f'<text x="32" y="360" fill="{p["green"]}">❯</text>',
        f'<rect x="58" y="340" width="13" height="25" fill="{p["cursor"]}"/>',
        '</g>',
        f'<text x="32" y="420" fill="{p["foreground"]}" font-family="sans-serif" font-size="22" font-weight="bold">Surfaces and interaction</text>',
    ]
    for index, (token, label) in enumerate(SURFACES[:6]):
        x, y = 32 + (index % 2) * 460, 450 + (index // 2) * 58
        lines.extend([
            f'<rect x="{x}" y="{y}" width="38" height="38" fill="{p[token]}" stroke="{p["bright_black"]}"/>',
            f'<text x="{x + 52}" y="{y + 16}" fill="{p["foreground"]}" font-family="sans-serif" font-size="16">{label}</text>',
            f'<text x="{x + 52}" y="{y + 36}" fill="{p["foreground"]}" font-family="monospace" font-size="15">{p[token]}</text>',
        ])
    lines.append(f'<text x="32" y="666" fill="{p["foreground"]}" font-family="sans-serif" font-size="22" font-weight="bold">ANSI palette · normal and bright</text>')
    for index, token in enumerate(ANSI):
        x, y = 32 + (index % 8) * 112, 688 + (index // 8) * 58
        lines.extend([
            f'<rect x="{x}" y="{y}" width="32" height="32" fill="{p[token]}" stroke="{p["bright_black"]}"/>',
            f'<text x="{x + 38}" y="{y + 20}" fill="{p["foreground"]}" font-family="monospace" font-size="14">{index}</text>',
        ])
    lines.append('</svg>')
    return "\n".join(lines) + "\n"


def generate(palettes):
    return {
        ROOT / "assets" / f"{name}.svg": preview(palettes[appearance], name)
        for appearance, name in THEMES.items()
    }


if __name__ == "__main__":
    write_outputs(generate(load_palettes()))
