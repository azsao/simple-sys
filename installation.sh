#!/bin/bash

LOG_FILE="logs/install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "$(date +"%H:%M:%S"): $1"
}

log "Starting system update..."
sudo pacman -Syu --noconfirm
log "System updated. Proceeding..."


log "installing installation dependencies"  # sounds redundant haha
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm wget
sudo pacman -S --noconfirm unzip
log "Installed installation dependencies" 

# Install yay
if ! command -v yay &>/dev/null; then
    log "yay is not installed. Downloading and installing..."
    
    # Create a directory for yay installation
    sudo mkdir -p /opt/yay
    sudo chown -R "$USER:$USER" /opt/yay
    cd /opt/yay || exit
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R "$USER:$USER" yay
    cd yay || exit
    makepkg -si --noconfirm
    cd - || exit
    log "yay has been installed!"
else
    log "yay is already installed!"
fi

if ! command -v nano &>/dev/null; then
    log "nano is not installed. Installing..."
    sudo pacman -S --noconfirm nano
    log "nano has been installed!"
else
    log "nano is already installed!"
fi

if ! command -v nvim &>/dev/null; then
    log "NVIM is not installed. Downloading and installing..."
    sudo pacman -S neovim --noconfirm
    log "NVIM has been installed!"

fi

sudo pacman -S --noconfirm konsole

if ! command -v cmake &>/dev/null; then
    log "CMake is not installed. Installing..."
    sudo pacman -S --noconfirm cmake
    log "CMake has been installed!"
else
    log "CMake is already installed!"
fi

log "Installing python + dependencies" 
sudo pacman -S --noconfirm python-gobject python-gtksourceview3
sudo python3 setup.py install
log "Installed python + dependencies" 

# Entering Second Stage
log "Entering Second Stage, Halting...."
sleep 15
log "Entering Second Stage, Proceeding...."

log "Starting system update..."
sudo pacman -Syu --noconfirm
log "System updated. Proceeding..."

# Gaming Components

log "Issuing gaming components"
sudo pacman -S --noconfirm firefox
sudo pacman -S --noconfirm discord
sudo pacman -S --noconfirm zathura
sudo pacman -S --noconfirm telegram
sudo pacman -S --noconfirm flameshot
yay -S spotify
log "Concluded gaming components"

sleep 2

# Visual Components
log "Issuing visual components"
sudo pacman -S --noconfirm rofi
sudo pacman -S --noconfirm picom
log "Concluded visual components"

# Console Components
log "Issuing console components"
sudo pacman -S --noconfirm fish
sudo pacman -S --noconfirm neofetch
sudo pacman -S --noconfirm konsole
sudo pacman -S --noconfirm nemo
log "Concluded console components"

# Special Components
log "Issuing special components"
cd /home
sudo pacman -S --noconfirm polybar
log "Concluded special components"

# Codex Prompt 
read -p "Do you want to open Firefox and manually install a necessary font (Keep in mind, failure to do so may result in bugs)? (Y/N): " answer
# Convert the answer to lowercase
answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

if [ "$answer" == "y" ]; then
    firefox https://www.dafont.com/coders-crux.font
    log "Firefox is now open and redirected to font download."
elif [ "$answer" == "n" ]; then
    log "You chose not to install the font."
else
    echo "Invalid input. Please enter Y or N."
fi


log "Script successfully concluded"
