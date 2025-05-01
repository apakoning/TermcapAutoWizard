#!/bin/bash

# ============================
# LESS_TERMCAP Color Wizard
# ============================

show_help() {
cat << 'EOF'

🧾 Script: less_termcap_fzf_wizard.sh
──────────────────────────────────────
📌 Description:
This script configures colorful and readable `man` pages by allowing you to interactively pick colors for LESS_TERMCAP_* variables.

📌 What it does:
- Detects terminal color capability (8-color, 16-color, 256-color, 24-bit RGB)
- Guides you through selecting colors for bold, underline, blinking, standout
- Outputs copy-paste ready export lines for your ~/.bashrc
- Includes optimized default themes for all terminal types

📌 What it's used for:
- Making man pages easier to read
- Matching man page colors to your terminal theme
- Learning and applying terminal color theory (ANSI, RGB)

📌 Requirements:
- Bash
- fzf (install via `sudo dnf install fzf`)
- A terminal emulator (GNOME Terminal, TTY, SSH, etc.)
- tput (already available via ncurses on most systems)

📌 How to use:
1. Make executable:
   chmod +x less_termcap_fzf_wizard.sh

2. Run it:
   ./less_termcap_fzf_wizard.sh

3. Follow the wizard and copy the result to your ~/.bashrc

EOF
}

# Check if help was requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_help
  exit 0
fi

#!/bin/bash

# Dependencies check
command -v fzf >/dev/null 2>&1 || { echo >&2 "fzf is not installed. Please install it first."; exit 1; }

generate_rgb_list() {
  for r in 0 64 128 192 255; do
    for g in 0 64 128 192 255; do
      for b in 0 64 128 192 255; do
        printf "%03d,%03d,%03d\t\e[48;2;%d;%d;%dm   \e[0m\n" "$r" "$g" "$b" "$r" "$g" "$b"
echo
echo "=============================="
echo "🧠 Detecting Terminal Capabilities..."
echo "=============================="

TERM_COLOR_MODE="unknown"

if [[ "$COLORTERM" == *"truecolor"* || "$COLORTERM" == *"24bit"* ]]; then
  TERM_COLOR_MODE="truecolor"
elif tput colors &>/dev/null && [ "$(tput colors)" -ge 256 ]; then
  TERM_COLOR_MODE="256color"
elif tput colors &>/dev/null && [ "$(tput colors)" -ge 16 ]; then
  TERM_COLOR_MODE="16color"
elif tput colors &>/dev/null && [ "$(tput colors)" -ge 8 ]; then
  TERM_COLOR_MODE="8color"
else
  TERM_COLOR_MODE="unknown"
fi

echo "Detected: $TERM_COLOR_MODE"

case "$TERM_COLOR_MODE" in
  truecolor)
    echo "✅ Recommended: 24-bit True Color Theme"
    ;;
  256color)
    echo "✅ Recommended: 256-Color Theme"
    ;;
  16color)
    echo "✅ Recommended: 16-Color ANSI Theme"
    ;;
  8color)
    echo "✅ Recommended: 8-Color Fallback Theme"
    ;;
  *)
    echo "⚠️ Could not determine your terminal's color depth. Use the 8-color fallback theme to be safe."
    ;;
esac

      done
    done
  done
}

pick_color() {
  local label=$1
  echo
  echo "=== Select color for $label ==="
  local rgb=$(generate_rgb_list | fzf --ansi --prompt="$label: " | cut -f1)
  if [[ -z "$rgb" ]]; then
    echo "No selection made. Exiting."
    exit 1
  fi
  echo "$rgb"
}

echo "=============================="
echo "LESS TERMCAP RGB Color Picker Wizard"
echo "=============================="
echo "You'll be prompted to select colors for various man page text styles."
echo "Press Enter to start."
read

declare -A colors

colors[mb]=$(pick_color "LESS_TERMCAP_mb (blinking)")
colors[md]=$(pick_color "LESS_TERMCAP_md (bold)")
colors[us]=$(pick_color "LESS_TERMCAP_us (underline)")
colors[so_fg]=$(pick_color "LESS_TERMCAP_so foreground (standout text)")
colors[so_bg]=$(pick_color "LESS_TERMCAP_so background (standout background)")

# Static resets
colors[me]="\e[0m"
colors[se]="\e[0m"
colors[ue]="\e[0m"

echo
echo "=============================="
echo "Your Custom LESS_TERMCAP Theme:"
echo "=============================="
echo

echo "export LESS_TERMCAP_mb=\$'\e[1;38;2;${colors[mb]}m'"
echo "export LESS_TERMCAP_md=\$'\e[1;38;2;${colors[md]}m'"
echo "export LESS_TERMCAP_us=\$'\e[1;38;2;${colors[us]}m'"
echo "export LESS_TERMCAP_me=\$'${colors[me]}'"
echo "export LESS_TERMCAP_se=\$'${colors[se]}'"
echo "export LESS_TERMCAP_ue=\$'${colors[ue]}'"
echo "export LESS_TERMCAP_so=\$'\e[1;48;2;${colors[so_bg]};38;2;${colors[so_fg]}m'"

echo
echo "Paste the above lines into your ~/.bashrc and run 'source ~/.bashrc' to apply."
echo
read -p "Press enter to exit."

echo
echo "=============================="
echo "Suggested Readable 24-bit RGB Theme:"
echo "=============================="
cat << 'EOF'
export LESS_TERMCAP_mb=$'\e[1;38;2;255;64;64m'            # blinking = bright red
export LESS_TERMCAP_md=$'\e[1;38;2;102;255;255m'          # bold = light cyan
export LESS_TERMCAP_us=$'\e[1;38;2;128;255;128m'          # underline = light green
export LESS_TERMCAP_so=$'\e[1;48;2;0;0;128;38;2;255;255;0m'  # standout = yellow on navy blue
export LESS_TERMCAP_me=$'\e[0m'                           # reset
export LESS_TERMCAP_se=$'\e[0m'                           # reset standout
export LESS_TERMCAP_ue=$'\e[0m'                           # reset underline
EOF

echo
echo "=============================="
echo "Suggested Readable LESS_TERMCAP Themes"
echo "=============================="

echo
echo "🎨 24-bit True Color (16.7 million colors):"
cat << 'EOF'
export LESS_TERMCAP_mb=$'\e[1;38;2;255;64;64m'            # blinking = bright red
export LESS_TERMCAP_md=$'\e[1;38;2;102;255;255m'          # bold = light cyan
export LESS_TERMCAP_us=$'\e[1;38;2;128;255;128m'          # underline = light green
export LESS_TERMCAP_so=$'\e[1;48;2;0;0;128;38;2;255;255;0m'  # standout = yellow on navy blue
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
EOF

echo
echo "🌈 256-color Terminal:"
cat << 'EOF'
export LESS_TERMCAP_mb=$'\e[1;38;5;196m'       # blinking = bright red
export LESS_TERMCAP_md=$'\e[1;38;5;81m'        # bold = light cyan
export LESS_TERMCAP_us=$'\e[1;38;5;112m'       # underline = light green
export LESS_TERMCAP_so=$'\e[1;48;5;18;38;5;226m'  # standout = yellow on navy
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
EOF

echo
echo "🖥️ 16-color Terminal:"
cat << 'EOF'
export LESS_TERMCAP_mb=$'\e[1;31m'    # blinking = red
export LESS_TERMCAP_md=$'\e[1;36m'    # bold = cyan
export LESS_TERMCAP_us=$'\e[1;32m'    # underline = green
export LESS_TERMCAP_so=$'\e[1;44;33m' # standout = yellow on blue
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
EOF

echo
echo "📟 8-color Terminal (fallback safe):"
cat << 'EOF'
export LESS_TERMCAP_mb=$'\e[1;31m'    # red
export LESS_TERMCAP_md=$'\e[1;37m'    # white (safe fallback)
export LESS_TERMCAP_us=$'\e[1;32m'    # green
export LESS_TERMCAP_so=$'\e[7m'       # reverse video
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
EOF
