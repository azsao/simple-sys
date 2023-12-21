#!/bin/bash

USERNAME=$(whoami)

echo "Running placement.sh"
sleep 2

# config files for rice
echo "Configuration files scheduled to be moved."
rm -r /home/$USERNAME/.config/i3
sleep 2
mv config/i3 /home/$USERNAME/.config
mv config/polybar /home/$USERNAME/.config
mv config/rofi /home/$USERNAME/.config
mv config/kitty /home/$USERNAME/.config
mv config/nvim /home/$USERNAME/.config

echo "Configuration files moved."

if mv /home/$USERNAME/simple-sys/fonts /home/$USER; then
    echo "Font moved successful."
else
    echo "Font failed. Check permissions or directory existence."
fi

if mv /home/$USERNAME/simple-sys/pictures /home/$USER; then
    echo "pictures moved successful."
else
    echo "pictures failed. Check permissions or directory existence."
fi

# conclusion
echo "Placement script completed"