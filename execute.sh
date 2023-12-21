#!/bin/bash

USERNAME=$USER
USERNAME=$(echo "$USERNAME" | tr -cd '[:alnum:]')
USER_HOME=$(getent passwd "$(whoami)" | cut -d: -f6)

INSTALLATION="~/installation.sh"
FONT="~/fonts/fonts.sh"
PLACEMENT="$USER_HOME/simple-sys/placement.sh"

chmod +x "$INSTALLATION"
chmod +x "$FONT"
chmod +x "$PLACEMENT"

echo "Executing placement script"
"$PLACEMENT"
echo "Placement script concluded"

sleep 2

echo "Executing installation script"
"$INSTALLATION"
echo "Installation script concluded"

sleep 5

echo "Executing font script"
"$FONT"
echo "Font script concluded"

sleep 5

echo "Script concluded, requesting restart"

read -p "Do you want to restart? (Y/N): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "Initiating Restart"
    sudo reboot
fi