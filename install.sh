#!/bin/bash

# Function to check the operating system
check_os() {
    if ! grep -q "^ID=arch$" /etc/os-release; then
        echo "Error: This script is designed for Arch Linux only. Other distributions, including Manjaro or EndeavourOS, are not supported."
        exit 1
    fi
}

# Call the OS check function
check_os

usage() {
    echo "Usage: $(basename "$0") [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --mode=tui          Run the installation in TUI (Text User Interface) mode."
    echo "  --mode=cli          Run the installation in CLI (Command Line Interface) mode."
    echo "  -y                  Skip confirmation prompts during installation."
    echo "  -h, --help          Display this help message and exit."
    echo "  --version           Display version information and exit."
    echo ""
    echo "Description:"
    echo "  Devlix is a window manager based on dwm 6.5, designed to provide a lightweight, efficient,"
    echo "  and customizable environment for users who prefer minimalism and simplicity. Built with"
    echo "  performance in mind, Devlix focuses on delivering a streamlined user interface that enhances"
    echo "  productivity with minimal system resource usage."
}


version() {
    echo "Devlix WM Installer Script"
    echo "Version: 1.0.0"
    echo "Based on dwm 6.5"
}

mode="tui"
mode_set=false
yes_flag=false  # Default to no for -y flag

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

# Process arguments
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
        -h|--help)
            usage
            exit 0
            ;;
        --version)
            version
            exit 0
            ;;
        -y)
            yes_flag=true
            ;;
        *)
            echo -e "Unknown argument: $arg\n"
            usage
            exit 1
            ;;
    esac
done

# Remove old log file
rm -f ~/devlix/installation_script/install.log

echo "Commit Hash: $(git log -1 --format=%H)" >> ~/devlix/installation_script/install.log
date >> ~/devlix/installation_script/install.log
uname -a >> ~/devlix/installation_script/install.log
echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== Installation ===" >> ~/devlix/installation_script/install.log

# Run the correct installation based on the mode and -y flag
if [ "$mode" == "tui" ]; then
    if $yes_flag; then
        ~/devlix/installation_script/tui_install.sh -y | tee -a ~/devlix/installation_script/install.log
    else
        ~/devlix/installation_script/tui_install.sh | tee -a ~/devlix/installation_script/install.log
    fi
elif [ "$mode" == "cli" ]; then
    if $yes_flag; then
        ~/devlix/installation_script/cli_install.sh -y | tee -a ~/devlix/installation_script/install.log
    else
        ~/devlix/installation_script/cli_install.sh | tee -a ~/devlix/installation_script/install.log
    fi
fi

echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== End of Installation ===" >> ~/devlix/installation_script/install.log
