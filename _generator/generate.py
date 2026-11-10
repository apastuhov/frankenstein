"""Generate registered application ports and shared previews."""

import argparse
import importlib.util

from _generator.palette import ROOT, load_palettes, write_outputs
from _generator.ports import PORTS
from _generator.assets import generate as generate_assets
from _generator.docs import generate as generate_docs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--port", choices=sorted(PORTS), help="generate only this port")
    args = parser.parse_args()
    palettes = load_palettes()
    outputs = {}
    if not args.port:
        for generator in (generate_docs, generate_assets):
            shared_outputs = generator(palettes)
            overlap = outputs.keys() & shared_outputs.keys()
            if overlap:
                raise ValueError(f"Duplicate generated paths: {overlap}")
            outputs.update(shared_outputs)
    for name in ([args.port] if args.port else PORTS):
        spec = importlib.util.spec_from_file_location(f"port_{name}", ROOT / PORTS[name])
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        port_outputs = module.generate(palettes)
        overlap = outputs.keys() & port_outputs.keys()
        if overlap:
            raise ValueError(f"Duplicate generated paths: {overlap}")
        outputs.update(port_outputs)
    write_outputs(outputs)


if __name__ == "__main__":
    main()
