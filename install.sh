#!/bin/bash

clear

# Protection against running as root or with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root."
    exit 1
fi

set -e  # Exit immediately if any command exits with a non-zero status

# Function to keep sudo alive in the background
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

# Function to clean package manager cache for pacman and yay
clean_package_cache() {
    echo -e "\nCleaning package manager cache for pacman and yay (if installed)..."
    sudo pacman -Scc --noconfirm
    sudo pacman -Syy --noconfirm

    if command -v yay &> /dev/null; then
        yay -Scc --noconfirm
        yay -Syy --noconfirm
    else
        echo "yay is not installed, skipping yay commands."
    fi
}

# Function to update system and install packages
install_system_packages() {
    echo -e "\nUpdating system and installing packages..."
    sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl wget flameshot bluez-obex bluez bluez-utils blueman pulsemixer
}

# Function to install yay from AUR
install_yay() {
    echo -e "\nInstalling yay for the AUR..."
    sudo rm -rf ~/yay
    git clone https://aur.archlinux.org/yay.git ~/yay || { echo "Error: Failed to clone yay repository."; exit 1; }
    (cd ~/yay && makepkg -sif --noconfirm)
    sudo rm -rf ~/yay
}

# Function to install additional packages via yay
install_additional_packages() {
    echo -e "\nInstalling additional packages via yay..."
    yay -Syu --noconfirm epub-thumbnailer-git wkhtmltopdf-static 7-zip
}

# Function to remove old wal cache and configuration files
remove_wal_cache() {
    echo -e "\nRemoving old wal colors..."
    rm -rf ~/.cache/wal
}

# Function to copy Devlix configuration files
copy_devlix_configs() {
    echo -e "\nCopying Devlix configuration files..."
    cp -r ~/devlix/configs/* ~/.config
    touch ~/.zshrc
}

# Function to set the wallpaper and color scheme using pywal
set_wallpaper_and_colorscheme() {
    echo -e "\nSetting the wallpaper and color scheme..."
    valid_extensions=("jpg" "jpeg" "png" "bmp" "gif" "tiff")

    is_valid_image() {
        local file="$1"
        local ext="${file##*.}"
        for valid_ext in "${valid_extensions[@]}"; do
            if [[ "$ext" == "$valid_ext" ]]; then
                return 0  # Valid image extension
            fi
        done
        return 1  # Invalid image extension
    }

    while true; do
        echo -e "\nEnter the path of the wallpaper you want to set:"
        read wall_path
        wall_path=$(echo "$wall_path" | xargs)

        if [[ -z "$wall_path" ]]; then
            echo "Path cannot be empty or just spaces. Please try again."
            continue
        fi

        wall_path_expanded="${wall_path/#\~/$HOME}"

        if [[ ! -e "$wall_path_expanded" ]]; then
            echo "The file or directory does not exist. Please enter a valid path."
            continue
        fi

        if ! is_valid_image "$wall_path_expanded"; then
            echo "The file is not a valid image. Please enter a file with a valid image extension (jpg, png, etc.)."
            continue
        fi

        wal -i "$wall_path_expanded"
        ~/devlix/alacritty-color-export/script.sh
        break
    done
}

# Function to build and install Devlix WM packages
build_and_install_devlix_wm() {
    echo -e "\nBuilding Devlix WM..."
    sed -i "s/mohamed/$(whoami)/g" ~/devlix/dwm/config.def.h ~/devlix/dmenu/config.def.h
    [ -f ~/devlix/dwm/config.h ] && sed -i "s/mohamed/$(whoami)/g" ~/devlix/dwm/config.h ~/devlix/dmenu/config.h

    (cd ~/devlix/dwm && sudo make clean install)
    (cd ~/devlix/dmenu && sudo make clean install)
    (cd ~/devlix/dwmblocks && sudo make clean install)
    (cd ~/devlix/lfimg && make install)
}

# Function to change the default shell to zsh
change_default_shell() {
    echo -e "\nChanging the default shell to zsh..."
    while ! chsh -s /usr/bin/zsh; do
        echo "Retrying..."
        sleep 1
    done
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    echo -e "\nInstalling Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# Function to set up zsh plugins and themes
setup_zsh_plugins_and_themes() {
    echo -e "\nSetting up zsh plugins and themes..."
    ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}

# Function to copy Devlix zsh and X Server configuration files
copy_zsh_x_config_files() {
    echo -e "\nCopying configuration files..."
    cp ~/devlix/.zshrc ~/.zshrc
    cp ~/devlix/.zprofile ~/.zprofile
    cp ~/devlix/.xinitrc ~/.xinitrc
    cp ~/devlix/.p10k.zsh ~/.p10k.zsh
}

# Function to finish the installation process
finish_installation() {
    cat ~/devlix/art/finish.txt
    terminate_sudo
}

# Main installation process
main() {
    keep_sudo_alive

    clear

    cat ~/devlix/art/hello.txt

    read -p "Start Devlix Installation (Y/n): " confirm
    confirm="${confirm:-y}"

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "\nStarting Devlix Installation..."
        sleep 2
        clean_package_cache
        install_system_packages
        install_yay
        install_additional_packages
        remove_wal_cache
        copy_devlix_configs
        set_wallpaper_and_colorscheme
        build_and_install_devlix_wm
        change_default_shell
        install_oh_my_zsh
        setup_zsh_plugins_and_themes
        copy_zsh_x_config_files
        finish_installation
    else
        echo "Installation canceled."
        exit 0
    fi
}

# Run the installation
main
