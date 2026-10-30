# Frankenstein for Ghostty

Clone the repository into a permanent location, then link its theme files into Ghostty's theme directory:

```sh
git clone https://github.com/apastuhov/frankenstein.git "$HOME/frankenstein"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"
ln -s "$HOME/frankenstein/ghostty/themes/frankenstein_creature_of_the_light" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes/frankenstein_creature_of_the_light"
ln -s "$HOME/frankenstein/ghostty/themes/frankenstein_creature_of_the_night" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes/frankenstein_creature_of_the_night"
```

The links let Ghostty read the files in the clone. If you already cloned the repository elsewhere, substitute that path for `$HOME/frankenstein`.

Select the themes in Ghostty:

```ini
theme = light:frankenstein_creature_of_the_light,dark:frankenstein_creature_of_the_night
```

To update the themes, run `git -C "$HOME/frankenstein" pull` and reload Ghostty's configuration.
