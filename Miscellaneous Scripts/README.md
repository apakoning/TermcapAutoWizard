This is a simple script to check your system for modern Linux CLI tools.
Only a handful have in the meantime been surpassed in function; so no real loss if you don't have them on your system.

Below is a breakdown of commonly recommended modern CLI tools, and whether they’re still worth having in 2025 — or have become optional:

✅ Still Highly Useful in 2025
￼
Tool				Replaces	Still Worth It?	Reason
bat				cat		✅ Yes		Syntax highlighting, paging, Git integration. Excellent general-purpose viewer.
fd				find		✅ Yes		Faster, simpler syntax, good for 80% of use cases.
ripgrep (rg)			grep		✅ Yes		Blazing fast, recursive by default, respects .gitignore.
btop/bottom			top/htop	✅ Yes		Modern, interactive, beautiful system monitors.
fzf				N/A		✅ Yes		Versatile fuzzy finder — used in scripts, workflows, terminals.
dust				du		✅ Yes		Visual, human-readable disk usage tree. Very handy.
tldr				man		✅ Yes		Concise, community-written examples. Excellent for quick reminders.
delta				diff		✅ Yes		Git diff viewer with syntax highlighting. Pure quality.


🟡 Nice to Have / Situational
￼
Tool				Replaces	Still Useful?	Reason
exa				ls		🟡 Optional	Was great, but archived in 2023. Now replaced by eza.
httpie				curl		🟡 Situational	Friendlier for APIs and JSON, but heavier than curl.
taskwarrior			N/A		🟡 Niche	For CLI task management. Great if used — overkill if not.
vifm				mc/ranger	🟡 Taste-based	Vi-style file manager. Not for everyone.
aria2				wget		🟡 Situational	Good for parallel/batched downloads. Niche need.
curlie				curl		🟡 Fun UI	Simpler UI over curl. Redundant if you use httpie.


❌ Outdated or Superseded / Not Worth Installing
￼
Tool				Replaces	Notes
chkrootkit			N/A		❌ Obsolete. Use rkhunter + auditd or dedicated tools like Lynis.
hashdeep			N/A		❌ Niche + unmaintained. Use sha256sum, integrity-checker, or tripwire.
exa				ls		❌ Deprecated. Use eza instead.
trash				rm		❌ Most modern DEs have trash-handling already; rarely useful on servers.




🔄 Modern Alternative Suggestions

🔄 exa → use eza

🔄 chkrootkit → switch to rkhunter, Lynis, or osquery

🔄 hashdeep → sha256sum, integrit, or aide

🔄 curlie → just use httpie if installed
