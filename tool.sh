#!/bin/bash
TOOL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$TOOL_DIR/.modules/colors.sh"
version=$(cat "$TOOL_DIR/.modules/version.txt")

load_quick_tip() {
    tips=(
        "Available options aren't case sensitive."
        "Press Ctrl + C to force close the program."
    )
    random_tip=${tips[$RANDOM % ${#tips[@]}]}
    echo -e "${Y}Tip:${RST} $random_tip"
}

menu_UI() {
    clear
    #DEBUG
	echo "DEBUG: TOOL_DIR: $TOOL_DIR"
    echo -e "${C}===================================================${RST}"
    echo -e "${YB} MyTool - v$version ${RST}"
    echo -e "${C}---------------------------------------------------${RST}"
    echo -e " ${GB}[1]${RST} - About."
    echo -e " ${GB}[2]${RST} - Jenkins HTTPS Cert renewal related."
    echo -e " ${GB}[99]${RST} - Testing Ground [Experimental]"
    echo -e " ${RB}[Q]${RST} - Quit/Exit."
    echo -e "${C}---------------------------------------------------${RST}"
    load_quick_tip
    echo -e "${C}===================================================${RST}"
}

while true; do
    menu_UI
    read -r -p "Choose option: " availableOptions

    case $availableOptions in
        1) source "$TOOL_DIR/.modules/about.sh" ;;
    	2) source "$TOOL_DIR/.modules/jenkins_https.sh" ;;
    	99) source "$TOOL_DIR/.modules/test.sh" ;;
        Q|q|0) echo "Exiting.." ; exit 1 ;;
        *) source "$TOOL_DIR/.modules/handle_error.sh" "$availableOptions" ;;
    esac
done
