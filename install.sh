#!/bin/bash

if ! grep -q "Arch" /etc/os-release; then
  echo "Error: This script requires Arch Linux."
  exit 1
fi

login_managers=(
    "gdm"         # GNOME Display Manager
    "sddm"        # Simple Desktop Display Manager (for KDE)
    "lightdm"     # Lightweight Display Manager
    "xdm"         # X Display Manager
    "lxdm"        # LXDE Display Manager
    "slim"        # Simple Login Manager
    "mdm"         # Mint Display Manager
    "entranced"   # Enlightenment Display Manager
    "kdm"         # KDE Display Manager (old)
    "wxdm"        # Lightweight XDM replacement
    "nodm"        # Minimal auto-login display manager
    "cdm"         # Console Display Manager
    "ly"          # TUI (terminal-based) Display Manager
    "consolekit"  # Console-based session manager
    "xlogin"      # Basic X login manager
    "greetd"      # Minimal Wayland/X11 greeter
    "gdm3"        # GNOME Display Manager (modern)
    "photon-gdm"  # Photon GNOME Display Manager fork
    "lightdm-gtk-greeter" # GTK greeter for LightDM
    "lightdm-webkit-greeter" # Webkit-based greeter for LightDM
)

# Check for any installed login/display manager
for dm in "${login_managers[@]}"; do
    if command -v "$dm" &> /dev/null; then
        echo "Error: $dm is installed. This installer dosent support installing along side a login/display manager yet."
        exit 1
    fi
done

de_wm_list=(
    "gnome" "kde" "xfce4" "lxde" "lxqt" "cinnamon" "mate" "budgie" "deepin"
    "pantheon" "unity" "trinity" "cosmic" "sway" "hyprland" "wayfire"
    "dwm" "bspwm" "i3" "xmonad" "awesome" "herbstluftwm" "qtile" "spectrwm"
    "openbox" "fluxbox" "icewm" "jwm" "matchbox" "wmii" "blackbox" "fvwm"
    "ratpoison" "stumpwm" "notion" "pekwm" "cwm" "sawfish" "2bwm" "metacity"
    "compiz" "plasma-wm" "afterstep" "amethyst-linux" "dusk" "enlightenment"
    "river" "way-cooler" "labwc" "orbital" "velox" "hikari" "phoc"
    "mir-kiosk" "lavalauncher" "wio" "greenfield" "wayland-vnc"
    "echinus" "frankenwm" "berry" "yabai" "lazywm" "featherwm" "rooftopwm"
    "maximizedwm" "microwm" "tinywm-lite" "shimmerwm" "proto-wm" "omega-wm"
    "rockstarwm" "chaoswm" "dreamwm" "larswm" "nano-wm" "plwm" "golemwm"
    "dirtwm" "vwm" "grwm" "venomwm" "metalwm" "galaxywm" "amethyst-dev"
    "orbital-lite" "nebula-wm" "hivewm" "carpwm" "kaffee-wm" "pluto-wm"
    "9wm" "twm" "vtwm" "ctwm" "olvwm" "gemwm" "desqview" "uwin" "aewm"
    "evilwm" "windowlab" "moxwm" "rosawm" "sun-wm" "wilywm" "zappwm"
    "icewm-classic" "piewm" "fvwm-1" "aerosmith-wm" "super-wm"
    "tinywm" "awesome-lite" "matchbox-lite" "openmoko-wm" "xfce-lite"
    "sway-micro" "micro-wm" "smolwm" "wayland-micro"
    "dwm-patched" "dwm-rice" "hyprland-dev" "river-experimental"
    "wayfire-git" "cosmic-dev" "labwc-next" "moonlight-wm" "nebula-next"
    "qtile-rice" "awesome-modern" "i3-gaps" "i3-next" "bspwm-fork" "openbox-ng"
    "xlightwm" "gala" "dreamshell" "lotuswm" "echo-wm" "inter-wm" "zenith-wm"
    "vectorwm" "supernova-wm" "terra-wm" "galacticwm" "starrywm" "chaos-rice"
    "lumina" "mint-wm" "calypso-wm" "altwm" "kodi-wm" "dreamboxwm"
    "archangel-wm" "pinnacle-wm" "hikari-next"
    "starlight-wm" "infinity-wm" "driftwm" "velvetwm" "void-wm" "trinity-next"
    "freebirdwm" "alpha-wm" "betawave-wm" "gamma-wm" "zeta-wm" "river-rc"
    "aurorawm" "plasma-lite" "vulcanwm" "stratos-wm" "hyperlight-wm"
    "bliss-wm" "pico-wm" "archwm" "silverwolf-wm" "nextgen-wm" "euphoria-wm"
)

# Check for installed DEs/WMs
for de_wm in "${de_wm_list[@]}"; do
    if command -v "$de_wm" &> /dev/null; then
        echo "Error: $de_wm is installed. This installer dosen't support installing along side it yet."
        exit 1
    fi
done

version=$(cd ~/devlix && printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)")

usage() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --mode=tui          Run the installation in TUI (Text User Interface) mode."
    echo "  --mode=cli          Run the installation in CLI (Command Line Interface) mode."
    echo "  -u, --usage         Display this help message and exit."
    echo "  -y                  Automatically confirm and run the installation without further prompts."
    echo "  -v, --version       Display version information and exit."
    echo ""
    echo "Description:"
    echo "  Devlix is a window manager based on dwm 6.5, designed to provide a lightweight, efficient,"
    echo "  and customizable environment for users who prefer minimalism and simplicity. Built with"
    echo "  performance in mind, Devlix focuses on delivering a streamlined user interface that enhances"
    echo "  productivity with minimal system resource usage."
}

# Display version information
version() {
    echo "Devlix Installer Script"
    echo "Version: $version"
}

system_info() {
    echo "=== System Information ==="

    # CPU info
    echo "CPU: $(lscpu | grep 'Model name' | sed 's/Model name:\s*//')"

    # RAM info
    echo "RAM: $(free -h | grep 'Mem' | awk '{print $2}')"

    # GPU info
    echo "GPU: $(lspci | grep -i 'vga' | awk -F ': ' '{print $2}')"

    # Kernel version
    echo "Kernel version: $(uname -r)"

    # Linux distro
    echo "Linux distro: $(cat /etc/os-release | grep '^NAME' | sed 's/NAME=//g' | tr -d '"')"

    # Uptime
    echo "Uptime: $(uptime -p)"

    # Architecture
    echo "Architecture: $(uname -m)"

    # System load (1, 5, and 15 minute load averages)
    echo "System Load: $(uptime | awk -F'load average:' '{ print $2 }' | cut -d ',' -f1)"

    # Disk space usage
    echo "Disk Space: $(df -h | grep -E '^/dev' | awk '{print $1 ": " $5 " used, " $2 " available"}')"

    # Temperature (if supported)
    echo "Sensors: $(sensors)"

    echo "=== End of System Information ==="
}

# Default mode
mode="tui"
auto_confirm=false

# Flag to track if a mode is already set
mode_set=false

# Loop through the arguments
for arg in "$@"; do
    case $arg in
        --mode=tui)
            if $mode_set; then
                echo "Error: --mode option already set to $mode"
                exit 1
            fi
            mode="tui"
            mode_set=true
            ;;
        --mode=cli)
            if $mode_set; then
                echo "Error: --mode option already set to $mode"
                exit 1
            fi
            mode="cli"
            mode_set=true
            ;;
        -u|--usage)
            usage
            exit 0
            ;;
        -y)
            auto_confirm=true
            ;;
        -v|--version)
            version
            exit 0
            ;;
        *)
            echo "Unknown argument: $arg"
            exit 1
            ;;
    esac
done


# Remove the log file if it exists
rm -f ~/devlix/installation_script/install.log

# Log commit hash and system info
echo "Version: $version" >> ~/devlix/installation_script/install.log
date >> ~/devlix/installation_script/install.log
echo "" >> ~/devlix/installation_script/install.log
system_info >> ~/devlix/installation_script/install.log
echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== Installation ===" >> ~/devlix/installation_script/install.log

# Run the correct installation based on mode
if $auto_confirm; then
    # Run the installation scripts with -y flag if auto-confirm is enabled
    if [ "$mode" == "tui" ]; then
        ~/devlix/installation_script/tui_install.sh -y | tee -a ~/devlix/installation_script/install.log
    elif [ "$mode" == "cli" ]; then
        ~/devlix/installation_script/cli_install.sh -y | tee -a ~/devlix/installation_script/install.log
    fi
else
    # Otherwise, run the installation scripts normally
    if [ "$mode" == "tui" ]; then
        ~/devlix/installation_script/tui_install.sh | tee -a ~/devlix/installation_script/install.log
    elif [ "$mode" == "cli" ]; then
        ~/devlix/installation_script/cli_install.sh | tee -a ~/devlix/installation_script/install.log
    fi
fi

echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== End of Installation ===" >> ~/devlix/installation_script/install.log
