#!/bin/bash

# Protection against running as root or with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root."
    exit 1
fi

set -e  # Exit immediately if any command exits with a non-zero status

sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &

cd ~

sudo pacman -Scc --noconfirm
sudo pacman -Syy --noconfirm

sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh vim go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl wget flameshot bluez-obex bluez bluez-utils blueman pulsemixer neovim

sudo rm -rf ~/yay
git clone https://aur.archlinux.org/yay.git ~/yay
(cd ~/yay && makepkg -sif --noconfirm)
sudo rm -rf ~/yay

yay -Syu --noconfirm epub-thumbnailer-git wkhtmltopdf-static 7-zip

rm -rf ~/.cache/wal
rm -rf ~/.config/wal

while [ -z "$wall_path" ]; do
    read -p "\nEnter the path of the wallpaper you want to set:\n " wall_path
    if [ -z "$wall_path" ]; then
        echo "You must provide a valid path. Please try again.\n"
    fi

    # Expand the tilde to full path
    wall_path=$(printf "%s" "$wall_path" | sed 's|^~|'$HOME'|')

    # Check if the file exists and is a valid image file (jpg, jpeg, png, gif)
    if [ ! -f "$wall_path" ]; then
        echo "The specified file does not exist. Please provide a valid path."
        wall_path=""
        continue
    fi

    # Check if the file has a valid image extension
    if [[ ! "$wall_path" =~ \.(jpg|jpeg|png|gif)$ ]]; then
        echo "The specified file is not a valid image format. Supported formats are: jpg, jpeg, png, gif."
        wall_path=""
        continue
    fi
done
wal -i "$wall_path"


cp -r ~/devlix/configs/* ~/.config
touch ~/.zshrc

(cd ~/devlix/dwm && sudo make clean install)
(cd ~/devlix/dmenu && sudo make clean install)
(cd ~/devlix/dwmblocks && sudo make clean install)
(cd ~/devlix/lfimg && make install)

chsh -s /usr/bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

cp ~/devlix/.zshrc ~/.zshrc
cp ~/devlix/.zprofile ~/.zprofile
cp ~/devlix/.xinitrc ~/.xinitrc
cp ~/devlix/.p10k.zsh ~/.p10k.zsh

echo 'Finished !'

read -p "Do you want to kill all background processes and log out? (Y/n): " confirm
confirm="${confirm:-y}"  # Set default to 'y' if the user presses Enter without input
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    kill %1
    pkill -KILL -u $USER
else
    echo "Background processes not killed. Exiting script."
    exit 0
fi
