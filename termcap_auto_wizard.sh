#!/usr/bin/env bash

# Termcap Auto Wizard
# Interactive LESS_TERMCAP color picker for readable man pages.

set -u

VERSION="0.1.0"

show_help() {
  cat <<'EOF_HELP'
Termcap Auto Wizard

Usage:
  ./termcap_auto_wizard.sh [option]

Options:
  -h, --help       Show this help message
  -v, --version    Show version information
  --preset         Print recommended presets and exit

Description:
  Termcap Auto Wizard helps you build LESS_TERMCAP_* environment variables
  for colorful, readable man pages. It detects terminal color capability and,
  when fzf is installed, lets you interactively select RGB colors.

Requirements:
  - Bash 4+
  - fzf, for interactive color picking
  - tput, normally provided by ncurses

Use:
  chmod +x termcap_auto_wizard.sh
  ./termcap_auto_wizard.sh

After the wizard prints the export block, paste it into ~/.bashrc and run:
  source ~/.bashrc
EOF_HELP
}

show_version() {
  echo "Termcap Auto Wizard $VERSION"
}

need_command() {
  local cmd="$1"
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Error: required command not found: $cmd" >&2
    return 1
  fi
}

detect_color_mode() {
  if [[ "${COLORTERM:-}" == *"truecolor"* || "${COLORTERM:-}" == *"24bit"* ]]; then
    echo "truecolor"
  elif tput colors >/dev/null 2>&1 && [[ "$(tput colors)" -ge 256 ]]; then
    echo "256color"
  elif tput colors >/dev/null 2>&1 && [[ "$(tput colors)" -ge 16 ]]; then
    echo "16color"
  elif tput colors >/dev/null 2>&1 && [[ "$(tput colors)" -ge 8 ]]; then
    echo "8color"
  else
    echo "unknown"
  fi
}

print_detection() {
  local mode="$1"

  echo "=============================="
  echo "Detecting terminal capabilities"
  echo "=============================="
  echo "Detected: $mode"

  case "$mode" in
    truecolor) echo "Recommended: 24-bit true color theme" ;;
    256color)  echo "Recommended: 256-color theme" ;;
    16color)   echo "Recommended: 16-color ANSI theme" ;;
    8color)    echo "Recommended: 8-color fallback theme" ;;
    *)         echo "Could not determine color depth. Use the 8-color fallback theme." ;;
  esac
}

generate_rgb_list() {
  local r g b
  for r in 0 64 128 192 255; do
    for g in 0 64 128 192 255; do
      for b in 0 64 128 192 255; do
        printf "%03d,%03d,%03d\t\e[48;2;%d;%d;%dm   \e[0m\n" "$r" "$g" "$b" "$r" "$g" "$b"
      done
    done
  done
}

pick_color() {
  local label="$1"
  local rgb

  echo >&2
  echo "=== Select color for $label ===" >&2

  rgb="$(generate_rgb_list | fzf --ansi --prompt="$label: " | cut -f1)"

  if [[ -z "$rgb" ]]; then
    echo "No selection made. Exiting." >&2
    exit 1
  fi

  echo "$rgb"
}

print_presets() {
  cat <<'EOF_PRESETS'
Suggested readable LESS_TERMCAP themes

24-bit true color:
export LESS_TERMCAP_mb=$'\e[1;38;2;255;64;64m'                 # blinking = bright red
export LESS_TERMCAP_md=$'\e[1;38;2;102;255;255m'               # bold = light cyan
export LESS_TERMCAP_us=$'\e[1;38;2;128;255;128m'               # underline = light green
export LESS_TERMCAP_so=$'\e[1;48;2;0;0;128;38;2;255;255;0m'    # standout = yellow on navy
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

256-color terminal:
export LESS_TERMCAP_mb=$'\e[1;38;5;196m'          # blinking = bright red
export LESS_TERMCAP_md=$'\e[1;38;5;81m'           # bold = light cyan
export LESS_TERMCAP_us=$'\e[1;38;5;112m'          # underline = light green
export LESS_TERMCAP_so=$'\e[1;48;5;18;38;5;226m' # standout = yellow on navy
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

16-color terminal:
export LESS_TERMCAP_mb=$'\e[1;31m'    # blinking = red
export LESS_TERMCAP_md=$'\e[1;36m'    # bold = cyan
export LESS_TERMCAP_us=$'\e[1;32m'    # underline = green
export LESS_TERMCAP_so=$'\e[1;44;33m' # standout = yellow on blue
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

8-color fallback:
export LESS_TERMCAP_mb=$'\e[1;31m'    # red
export LESS_TERMCAP_md=$'\e[1;37m'    # white
export LESS_TERMCAP_us=$'\e[1;32m'    # green
export LESS_TERMCAP_so=$'\e[7m'       # reverse video
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
EOF_PRESETS
}

run_wizard() {
  local mode
  declare -A colors

  need_command fzf || exit 1
  need_command tput || exit 1

  mode="$(detect_color_mode)"

  print_detection "$mode"
  echo
  echo "=============================="
  echo "LESS_TERMCAP RGB Color Picker"
  echo "=============================="
  echo "You will be prompted to select colors for man page text styles."
  read -r -p "Press Enter to start."

  colors[mb]="$(pick_color "LESS_TERMCAP_mb blinking")"
  colors[md]="$(pick_color "LESS_TERMCAP_md bold")"
  colors[us]="$(pick_color "LESS_TERMCAP_us underline")"
  colors[so_fg]="$(pick_color "LESS_TERMCAP_so foreground")"
  colors[so_bg]="$(pick_color "LESS_TERMCAP_so background")"

  echo
  echo "=============================="
  echo "Your custom LESS_TERMCAP theme"
  echo "=============================="
  echo
  echo "export LESS_TERMCAP_mb=\$'\e[1;38;2;${colors[mb]}m'"
  echo "export LESS_TERMCAP_md=\$'\e[1;38;2;${colors[md]}m'"
  echo "export LESS_TERMCAP_us=\$'\e[1;38;2;${colors[us]}m'"
  echo "export LESS_TERMCAP_so=\$'\e[1;48;2;${colors[so_bg]};38;2;${colors[so_fg]}m'"
  echo "export LESS_TERMCAP_me=\$'\e[0m'"
  echo "export LESS_TERMCAP_se=\$'\e[0m'"
  echo "export LESS_TERMCAP_ue=\$'\e[0m'"
  echo
  echo "Paste the block above into ~/.bashrc and run: source ~/.bashrc"
}

case "${1:-}" in
  -h|--help)
    show_help
    ;;
  -v|--version)
    show_version
    ;;
  --preset|--presets)
    print_presets
    ;;
  "")
    run_wizard
    ;;
  *)
    echo "Unknown option: $1" >&2
    echo "Run './termcap_auto_wizard.sh --help' for usage." >&2
    exit 2
    ;;
esac
