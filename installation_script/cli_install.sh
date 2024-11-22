#!/bin/bash

clear

exito() {
    pkill tee
    exit $1
}

# Protection against running as root or with sudo
if [ "$(id -u)" -eq 0 ]; then
    echo "This script should not be run as root."
    exito 1
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

cat ~/devlix/installation_script/art/hello.txt

#!/bin/bash

# Check if -y is passed as an argument
if [[ "$1" == "-y" ]]; then
    confirm="y"
else
    read -p "Start Devlix Installation (Y/n): " confirm
    confirm="${confirm:-y}"  # Set default to 'y' if the user presses Enter without input
fi

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "\n\n---------------------------------------------"
    echo "Starting Devlix Installation..."
    echo -e "---------------------------------------------\n\n"
    sleep 2
else
    echo ""
    echo "Installation canceled."
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
if ! command -v yay &> /dev/null; then
    echo -e "\n\n---------------------------------------------"
    echo "Installing yay for the AUR ..."
    echo -e "---------------------------------------------\n\n"
    sleep 2

    sudo rm -rf ~/yay
    git clone https://aur.archlinux.org/yay.git ~/yay || { echo "Error: Failed to clone yay repository."; exito 1; }
    (cd ~/yay && makepkg -sif --noconfirm)
    sudo rm -rf ~/yay
    echo -e "\n\n---------------------------------------------"
    echo "Done."
    echo -e "---------------------------------------------\n\n"
    sleep 2
fi

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

echo -e "\n\n---------------------------------------------"
echo "Setting the wallpaper and color scheme ..."
echo -e "---------------------------------------------\n\n"
sleep 2

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
    ~/devlix/alacritty-color-export/script.sh
    break
done

echo -e "\n\n---------------------------------------------"
echo "Done."
echo -e "---------------------------------------------\n\n"
sleep 2

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
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || { echo "Error: Failed to clone zsh-autosuggestions repository."; exito 1; }
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || { echo "Error: Failed to clone zsh-syntax-highlighting repository."; exito 1; }
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k || { echo "Error: Failed to clone powerlevel10k repository."; exito 1; }

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

cat ~/devlix/installation_script/art/finish.txt
sleep 2

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
    sleep 1
    echo "Background processes not killed. Exiting script."
    exito 0
fi