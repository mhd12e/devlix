#!/bin/bash

set -e  # Exit immediately if any command exits with a non-zero status


cd ~

sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh vim go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl wget flameshot bluez-obex bluez bluez-utils blueman pulsemixer nvim

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

exit