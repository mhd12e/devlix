#!/bin/bash

# Protection against running as root or with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root."
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


# Change directory to home
cd ~

# Hello !

cat ~/devlix/art/hello.txt

read -p "Start Devlix Installation (Y/n): " confirm
confirm="${confirm:-y}"  # Set default to 'y' if the user presses Enter without input

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Starting Devlix Installation..."
    # Add installation commands here
else
    echo "Installation canceled."
    exit 0
fi


# Clean package manager cache for pacman and yay

echo "Cleaning package manager cache for pacman and yay (if installed) ..."

sudo pacman -Scc --noconfirm
sudo pacman -Syy --noconfirm

if command -v yay &> /dev/null; then
    # yay is installed, proceed with your yay commands
    yay -Scc --noconfirm
    yay -Syy --noconfirm
else
    # yay is not installed, skip yay commands and continue with the rest of the script
    echo "yay is not installed, skipping yay commands."
fi

echo "Done."

# Update system and install a set of packages

echo "Updating system and installing packages ..."

sudo pacman -Syu --noconfirm alacritty xorg-server xorg-xinit xorg-xsetroot xorg-xrandr feh picom python-pywal neofetch lf ueberzug ffmpegthumbnailer imagemagick poppler base-devel git bat chafa unzip p7zip unrar catdoc docx2txt odt2txt gnumeric zsh vim go webkit2gtk libxft libxinerama libx11 ttf-jetbrains-mono-nerd alsa-utils scrot python3 networkmanager curl wget flameshot bluez-obex bluez bluez-utils blueman pulsemixer neovim

echo "Done."

# Remove and rebuild yay from AUR

echo "Installing yay for the AUR ..."

sudo rm -rf ~/yay
git clone https://aur.archlinux.org/yay.git ~/yay || { echo "Error: Failed to clone yay repository."; exit 1; }
(cd ~/yay && makepkg -sif --noconfirm)
sudo rm -rf ~/yay

echo "Done."

# Install additional packages via yay

echo "Installing additional packages via yay ..."

yay -Syu --noconfirm epub-thumbnailer-git wkhtmltopdf-static 7-zip

echo "Done."

# Remove wal cache and configuration files

echo "Removing old wal colors ..."

rm -rf ~/.cache/wal
rm -rf ~/.config/wal

echo "Done."

#----------------------------------------------------

echo "Setting the wallpaper and color scheme ..."

# Valid image extensions supported by pywal
valid_extensions=("jpg" "jpeg" "png" "bmp" "gif" "tiff")

# Function to check if the input has a valid image extension
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

# Loop until a valid wallpaper path is entered
while true; do
    echo -e "\nEnter the path of the wallpaper you want to set:"
    read wall_path
    
    # Trim leading/trailing spaces from input
    wall_path=$(echo "$wall_path" | xargs)
    
    # Check if the input is empty or only spaces
    if [[ -z "$wall_path" ]]; then
        echo "Path cannot be empty or just spaces. Please try again."
        continue
    fi
    
    # Expand the tilde (~) to the home directory
    wall_path_expanded="${wall_path/#\~/$HOME}"
    
    # Check if the directory exists
    if [[ ! -e "$wall_path_expanded" ]]; then
        echo "The file or directory does not exist. Please enter a valid path."
        continue
    fi
    
    # Check if the file has a valid image extension
    if ! is_valid_image "$wall_path_expanded"; then
        echo "The file is not a valid image. Please enter a file with a valid image extension (jpg, png, etc.)."
        continue
    fi
    
    # If all checks pass, break the loop and apply the wallpaper
    wal -i "$wall_path_expanded"
    feh --bg-fill "$wall_path_expanded"
    break
done

echo "Done."

#----------------------------------------------------

# Copy Devlix configuration files to the appropriate directories

echo "Copy Devlix configuration files ..."

cp -r ~/devlix/configs/* ~/.config
touch ~/.zshrc

echo "Done."

# Build and install Devlix packages (dwm, dmenu, dwmblocks, lfimg)

echo "Building Devlix WM ..."

(cd ~/devlix/dwm && sudo make clean install)
(cd ~/devlix/dmenu && sudo make clean install)
(cd ~/devlix/dwmblocks && sudo make clean install)
(cd ~/devlix/lfimg && make install)

echo "Done."

# Change the default shell to zsh

echo "Changing the default shell to zsh ..."

chsh -s /usr/bin/zsh

echo "Done."

# Install Oh My Zsh automatically

echo "Installing Oh My Zsh ..."

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Done."

# Set up zsh plugins and themes

echo "Setting up zsh plugins and themes ..."

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || { echo "Error: Failed to clone zsh-autosuggestions repository."; exit 1; }
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || { echo "Error: Failed to clone zsh-syntax-highlighting repository."; exit 1; }
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k || { echo "Error: Failed to clone powerlevel10k repository."; exit 1; }

echo "Done."

# Copy Devlix zsh and X configuration files

echo "Copying configuration files ..."

cp ~/devlix/.zshrc ~/.zshrc
echo ".zshrc Done"
cp ~/devlix/.zprofile ~/.zprofile
echo ".zprofile Done"
cp ~/devlix/.xinitrc ~/.xinitrc
echo ".xinitrc Done"
cp ~/devlix/.p10k.zsh ~/.p10k.zsh
echo ".p10k.zsh Done"

echo "Done."

#----------------------------------------------------

cat ~/devlix/art/finish.txt

#----------------------------------------------------

terminate_sudo

# Prompt user to kill all background processes and log out
read -p "Do you want to kill all background processes and log out? (Y/n): " confirm
confirm="${confirm:-y}"  # Set default to 'y' if the user presses Enter without input
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    kill %1
    pkill -KILL -u $USER
else
    echo "Logout and login back to see changes"
    echo "Background processes not killed. Exiting script."
    exit 0
fi
