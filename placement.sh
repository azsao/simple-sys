#!/bin/bash

set -e
USERNAME=$(whoami | tr -cd '[:alnum:]')
echo "$(date): Starting placement script" >> simple-sys/logs/placement.log

# moving to proper directories
mv installation.sh ~/ >> simple-sys/logs/placement.log 2>&1
mv simple-sys/pictures/* ~/ >> simple-sys/logs/placement.log 2>&1 || true
mv simple-sys/fonts/* ~/ >> simple-sys/logs/placement.log 2>&1 || true

echo "Concluded moving scripts and wallpaper."

sleep 2

# config files for rice
echo "Configuration files scheduled to be moved."
[ -d ~/.config/i3 ] && rm -r ~/.config/i3
mv "$USERNAME/simple-sys/config/i3" ~/.config/ >> simple-sys/logs/placement.log 2>&1
[ -d ~/.config/polybar ] && rm -r ~/.config/polybar
mv "$USERNAME/simple-sys/config/polybar" ~/.config/ >> simple-sys/logs/placement.log 2>&1
[ -d ~/.config/rofi ] && rm -r ~/.config/rofi
mv "$USERNAME/simple-sys/config/rofi" ~/.config/ >> simple-sys/logs/placement.log 2>&1
echo "Configuration files moved successfully."

# conclusion
echo "$(date): Placement script completed" >> simple-sys/logs/placement.log
