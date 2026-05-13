#!/bin/bash

handle_error() {
    local error_input=$1

    echo "Error: Option '$error_input' is invalid or was not ready yet."

    while true; do
        read -r -p "Do you want to return to the menu? (y/n): " choice
        case $choice in
            [Yy]) break ;;  # Return to the menu
            [Nn]) echo "Exiting..."; exit 1 ;;  # Exit program
            *) echo "Invalid input. Please enter 'y' or 'n'." ;;
        esac
    done
}


handle_error "$1"
