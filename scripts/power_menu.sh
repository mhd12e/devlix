#!/bin/bash

# Options for dmenu
options="Shutdown\nRestart\nSleep"

# Get user choice using dmenu with specified options
choice=$(echo -e "$options" | dmenu -c -l 20 -i -p "Choose an action:")

# Execute the chosen action
case "$choice" in
    Shutdown)
        shutdown now
        ;;
    Restart)
        reboot
        ;;
    Sleep)
        systemctl suspend
        ;;
    *)
        echo "No valid option selected."
        ;;
esac

