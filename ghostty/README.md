# Frankenstein for Ghostty

From the repository root, generate and link the themes with [just](https://just.systems/):

```sh
just ghostty::build
just ghostty::link
```

Keep the repository at the same path so the links remain valid. The link command leaves existing files untouched; remove or move conflicting files before running it.

Select the themes in Ghostty:

```ini
theme = light:frankenstein_creature_of_the_light,dark:frankenstein_creature_of_the_night
```

After changing or updating the theme files, reload Ghostty's configuration.
