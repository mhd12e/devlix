#!/bin/bash

clear

# Protection against running as root or with sudo
if [ "$(id -u)" -eq 0 ]; then
    whiptail --title "This script should not be run as root" --msgbox "This script should not be run as root" 8 78   
    exit 1
fi

set -e  # Exit immediately if any command exits with a non-zero status

keep_sudo_alive() {
    sudo -v  # Keep the sudo timestamp alive
    while true; do sudo -n true; sleep 60; done 2>/dev/null &  # Run in background to avoid prompting for password
    SUDO_PID=$!  # Save the background process PID
}

# Function to terminate the background sudo process
terminate_sudo() {
    if [ -n "$SUDO_PID" ]; then
        kill "$SUDO_PID"
        echo "Terminated background sudo process."
    fi
}

keep_sudo_alive

cd ~

if whiptail --title "Start" --yesno "Welcome To Devlix WM!\nDo you want to start the Devlix WM Installation?" 8 78; then
    :  # No operation, just continue
else
    exit 0
fi


# Clean package manager cache for pacman and yay
echo -e "\n\n---------------------------------------------"
echo "Cleaning package manager cache for pacman and yay (if installed) ..."
echo -e "---------------------------------------------\n\n"
sleep 2

sudo pacman -Scc --noconfirm
sudo pacman -Syy --noconfirm

if command -v yay &> /dev/null; then
    # yay is installed, proceed with your yay commands
    yay -Scc --noconfirm
    yay -Syy --noconfirm
else
    # yay is not installed, skip yay commands and continue with the rest of the script
    echo -e "\n\n---------------------------------------------"
    echo "yay is not installed, skipping yay commands."
    echo -e "---------------------------------------------\n\n"
    sleep 2
fi

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Update system and install a set of packages

echo -e "\n\n---------------------------------------------"
echo "Updating system and installing packages ..."
echo -e "---------------------------------------------\n\n"
sleep 2

sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl wget flameshot bluez-obex bluez bluez-utils blueman pavucontrol arandr upower

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Remove and rebuild yay from AUR

echo -e "\n\n---------------------------------------------"
echo "Installing yay for the AUR ..."
echo -e "---------------------------------------------\n\n"
sleep 2

sudo rm -rf ~/yay
git clone https://aur.archlinux.org/yay.git ~/yay || { echo "Error: Failed to clone yay repository."; exit 1; }
(cd ~/yay && makepkg -sif --noconfirm)
sudo rm -rf ~/yay
echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Install additional packages via yay

echo -e "\n\n---------------------------------------------"
echo "Installing additional packages via yay ..."
echo -e "---------------------------------------------\n\n"
sleep 2

yay -Syu --noconfirm epub-thumbnailer-git wkhtmltopdf-static 7-zip

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Remove wal cache and configuration files

echo -e "\n\n---------------------------------------------"
echo "Removing old wal colors ..."
echo -e "---------------------------------------------\n\n"
sleep 2

rm -rf ~/.cache/wal

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

#----------------------------------------------------

# Copy Devlix configuration files to the appropriate directories

echo -e "\n\n---------------------------------------------"
echo "Copy Devlix configuration files ..."
echo -e "---------------------------------------------\n\n"
sleep 2

cp -r ~/devlix/configs/* ~/.config
touch ~/.zshrc

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2


#----------------------------------------------------

walpaper=$(whiptail --title "Wallpaper" --radiolist \
"Choose a wallpaper to set\n\nThese are some pre-installed wallpapers included in our repository.\nYou can change the wallpaper later." 15 78 5 \
"wall1.jpg" "Camping in mountains" OFF \
"wall2.png" "Mountain in front of a lake" OFF \
"wall3.png" "Snow mountain with pink clouds" OFF \
"wall4.png" "Mountain with the Milky Way" OFF \
"wall5.jpg" "House on a small island at night" ON \
--nocancel \
3>&1 1>&2 2>&3)

wal -i "/home/$(whoami)/devlix/wallpapers/$walpaper"
~/devlix/alacritty-color-export/script.sh

#----------------------------------------------------

# Build and install Devlix packages (dwm, dmenu, dwmblocks, lfimg)

echo -e "\n\n---------------------------------------------"
echo "Building Devlix WM ..."
echo -e "---------------------------------------------\n\n"
sleep 2

sed -i "s/mohamed/$(whoami)/g" ~/devlix/dwm/config.def.h ~/devlix/dmenu/config.def.h
[ -f ~/devlix/dwm/config.h ] && sed -i "s/mohamed/$(whoami)/g" ~/devlix/dwm/config.h ~/devlix/dmenu/config.h

(cd ~/devlix/dwm && sudo make clean install)
(cd ~/devlix/dmenu && sudo make clean install)
(cd ~/devlix/dwmblocks && sudo make clean install)
(cd ~/devlix/lfimg && make install)

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Change the default shell to zsh

echo -e "\n\n---------------------------------------------"
echo "Changing the default shell to zsh ..."
echo -e "---------------------------------------------\n\n"
sleep 2

while ! chsh -s /usr/bin/zsh; do
    echo "Retrying..."
    sleep 1
done

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Install Oh My Zsh automatically

echo -e "\n\n---------------------------------------------"
echo "Installing Oh My Zsh ..."
echo -e "---------------------------------------------\n\n"
sleep 2

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Set up zsh plugins and themes

echo -e "\n\n---------------------------------------------"
echo "Setting up zsh plugins and themes ..."
echo -e "---------------------------------------------\n\n"
sleep 2

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || { echo "Error: Failed to clone zsh-autosuggestions repository."; exit 1; }
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || { echo "Error: Failed to clone zsh-syntax-highlighting repository."; exit 1; }
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k || { echo "Error: Failed to clone powerlevel10k repository."; exit 1; }

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

# Copy Devlix zsh and X Server configuration files
echo -e "\n\n---------------------------------------------"
echo "Copying configuration files ..."
echo -e "---------------------------------------------\n\n"
sleep 2

cp ~/devlix/.zshrc ~/.zshrc
echo ".zshrc Done"
cp ~/devlix/.zprofile ~/.zprofile
echo ".zprofile Done"
cp ~/devlix/.xinitrc ~/.xinitrc
echo ".xinitrc Done"
cp ~/devlix/.p10k.zsh ~/.p10k.zsh
echo ".p10k.zsh Done"

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

#----------------------------------------------------

terminate_sudo

if whiptail --title "Finished !" --yesno \
"Thanks for installing Devlix WM!\nFor more information about Devlix WM, please visit:\nhttps://devlix.org\nor if you want to read the Devlix documentation and guide, visit:\nhttps://wiki.devlix.org\n\nDo you want to kill all background processes and log out to see changes?" \
15 78
then
    kill %1
    pkill -KILL -u $USER
else
    whiptail --title "Finished !" --msgbox "Logout and login back to see changes" 8 78
fi