# Termcap Auto Wizard

**Termcap Auto Wizard** is a Bash-based terminal color wizard for customizing `man` page styling through the `LESS_TERMCAP_*` environment variables.

It detects your terminal color capability and helps generate a copy-paste-ready export block for your shell configuration.

## What it does

- Detects terminal color support: 8-color, 16-color, 256-color, or 24-bit true color
- Lets you interactively choose colors with `fzf`
- Generates `LESS_TERMCAP_*` export lines for `~/.bashrc`
- Includes readable presets for common terminal color modes
- Helps make `man` pages easier to read

## Requirements

- Bash 4+
- `fzf`
- `tput`, usually provided by `ncurses`
- A terminal emulator such as GNOME Terminal, Alacritty, xterm, or a TTY

On RHEL-compatible systems:

```bash
sudo dnf install fzf ncurses
```

## Usage

```bash
chmod +x termcap_auto_wizard.sh
./termcap_auto_wizard.sh
```

Show help:

```bash
./termcap_auto_wizard.sh --help
```

Show version:

```bash
./termcap_auto_wizard.sh --version
```

Print suggested presets without running the wizard:

```bash
./termcap_auto_wizard.sh --preset
```

## Applying the generated theme

After the wizard prints your custom export block, paste it into `~/.bashrc`:

```bash
nano ~/.bashrc
```

Then reload your shell configuration:

```bash
source ~/.bashrc
```

Open a man page to test it:

```bash
man ls
```

## Project files

- `termcap_auto_wizard.sh` — main wizard script
- `LICENSE` — MIT license
- `.editorconfig` — editor formatting rules
- `.gitattributes` — Git line-ending and diff rules
- `Miscellaneous Scripts/` — extra CLI helper scripts

## Notes

The miscellaneous CLI scripts are useful experiments, but the main portfolio project is `termcap_auto_wizard.sh`.

## License

MIT License. See `LICENSE`.
