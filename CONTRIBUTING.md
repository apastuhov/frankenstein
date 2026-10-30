# Contributing

Issues and pull requests are welcome. 
Include the application, variant, and steps to reproduce; screenshots help with visual issues. 
Fixes in pull requests are especially welcome.

AI tools are okay. Review and take responsibility for everything you submit. 
Contributors who submit abusive or spam pull requests will be blocked. 
Contributions must be material you have the right to share under the project's [MIT license](LICENSE).

## Palette and ports

Each application folder contains its theme, installation README, and, when available, screenshots. New ports should support both variants and use the shared palette.

- Use neutral text for ordinary code, green for functions, gold for strings and numbers, teal for types, blue for keywords, and muted gray for comments and punctuation.
- Use red for errors, gold for warnings, green for success and information, and teal for hints. Pair selection and accent backgrounds with readable foregrounds.
- Keep the same color roles in both variants, adapting them where an application requires it.

### Adding a port

Give each application its own directory with installation and update instructions in `README.md` and its distributable files in the layout the application needs. 
Support both palette variants. 
Keep generator code alongside the port and register it in `_generator/ports.py`.

Current generators are Python modules exposing `generate(palettes)`. 
They receive the validated palette and return a dictionary mapping absolute `Path` objects to UTF-8 text;
 they do not write files themselves. Use shared palette definitions from `_generator/palette.py`. 
For direct execution, load and validate the palette with `load_palettes()` and pass the result to `write_outputs()`, as in `ghostty/generate.py`. 
The orchestrator prepares all outputs before writing and rejects duplicate output paths; 
 a filesystem error during writing can still leave partial updates. 
If a future port requires another language or toolset, extend the manifest and runner with an explicit interface for it.

### Distribution branches

The main repository is the source of truth. 
Each application is intended to have its own distribution branch, containing its installable files at the branch root so package managers can consume it. 
Distribution branches and their publishing automation are not set up yet; do not document a branch as available until it exists. 
Keep generated files and any required runtime dependencies in the port so it can be distributed independently.
