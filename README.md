# Termcap Auto Wizard

### 🧾 Script Description

**`termcap_auto_wizard.sh`** is a guided terminal-based color picker for customizing `man` page styles using the `LESS_TERMCAP_*` environment variables.

---

## 📌 What It Does

- Detects your terminal’s color capability (8-color, 16-color, 256-color, 24-bit RGB)
- Lets you interactively select colors for:
  - Blinking text
  - Bold text
  - Underline
  - Section headers (standout mode)
- Generates a `~/.bashrc`-ready export block
- Includes optimized presets for readability per terminal type

---

## 📌 Use Cases

- Improve readability of `man` pages
- Match color scheme to your terminal
- Learn ANSI/256-color/RGB terminal color logic

---

## ⚙️ Requirements

- Bash
- [`fzf`](https://github.com/junegunn/fzf) (Install with `sudo dnf install fzf`)
- Terminal emulator (e.g., GNOME Terminal, Alacritty, xterm, TTY)
- `tput` (part of ncurses)

---

## ▶️ How to Use

```bash
chmod +x termcap_auto_wizard.sh
./termcap_auto_wizard.sh
```

You’ll be guided step-by-step to choose colors and get your theme configuration.

---

## 🆘 Help

You can also run:

```bash
./termcap_auto_wizard.sh --help
```

To display built-in instructions.

---

## 🛠️ Project Standards

This repo includes tools to ensure **consistent behavior across platforms** and editors:

### ✅ `.editorconfig`
- Enforces:
  - UTF-8 encoding
  - Unix-style line endings (`LF`)
  - Final newline at end of file
  - 2-space indentation for `.sh` files
  - Markdown-friendly line break behavior

Most modern editors (VS Code, Sublime, JetBrains, Vim w/ plugin) respect this automatically.

### ✅ `.gitattributes`
- Standardizes line endings across systems
- Ensures proper Git diff behavior for:
  - Shell scripts
  - Markdown files
  - Text and binary files
- Helps prevent issues when collaborating across macOS, Windows, and Linux

---

Created with readability and terminal mastery in mind. 😎
