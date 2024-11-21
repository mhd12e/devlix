#!/bin/bash

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
        *)
            echo "Unknown argument: $arg"
            exit 1
            ;;
    esac
done

# If no valid mode is set, print an error
if ! $mode_set; then
    echo "Error: No valid --mode specified. Please use --mode=tui or --mode=cli."
    exit 1
fi

# Remove the log file if it exists
rm ~/devlix/installation_script/install.log

# Log commit hash and system info
echo "Commit Hash: $(git log -1 --format=%H)" >> ~/devlix/installation_script/install.log
date >> ~/devlix/installation_script/install.log
system_info >> ~/devlix/installation_script/install.log
echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== Installation ===" >> ~/devlix/installation_script/install.log

# Run the correct installation based on mode
if [ "$mode" == "tui" ]; then
    ~/devlix/installation_script/tui_install.sh | tee -a ~/devlix/installation_script/install.log
elif [ "$mode" == "cli" ]; then
    ~/devlix/installation_script/cli_install.sh | tee -a ~/devlix/installation_script/install.log
fi

echo -e "\n\n" >> ~/devlix/installation_script/install.log
echo "=== End of Installation ===" >> ~/devlix/installation_script/install.log
