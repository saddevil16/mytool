#!/bin/bash

getMachineIP() {
	local localIP
	local publicIP
	local OS

	OS=$(uname -a | grep -o '^\w*')

	if [ "$OS" = "Linux" ]; then
		localIP=$(hostname -I | cut -d' ' -f1)
	elif [ "$OS" = "Darwin" ]; then
		localIP=$(ipconfig getifaddr en1)
	else
		echo "[Warn] Mytool may or may not be able to check your OS local ip."
		localIP=$(hostname -I | cut -d' ' -f1)
	fi

	publicIP=$(curl -s ifconfig.me)

	echo "Public IP: $publicIP"
	echo "Local IP : $localIP"

	read -r -p "Press any key to continue.."
}

checkListenPort() {

	checkCertainPort() {
		read -r -p "Enter port to check: " portNum
		sudo lsof -i -n -P | grep :"$portNum"
		read -r -p "Press any key to continue.."
	}

	echo "Available options:"
	echo " [1] - Show ALL listening port"
	echo " [2] - Check certain port number"
	echo " [B] - Back"
	read -r -p "Choose option: " input

	case "$input" in
		1) 
			sudo lsof -i -n -P | grep LISTEN
			read -r -p "Press any key to continue.." ;;
		2) checkCertainPort ;;
		b|B) return 0;;
		*) # shellcheck disable=SC1091
        	source "$TOOL_DIR/.modules/handle_error.sh" "$input" ;;
	esac
}

show_UI() {
    clear
    echo -e "${C}===================================================${RST}"
    echo -e "${Y} Networking Tool${RST}"
    echo -e "${C}---------------------------------------------------${RST}"
    echo " Available options:"
    echo -e "${G} [1]${RST} - Get Local & Public IP."
    echo -e "${G} [2]${RST} - Check listening port."
    echo -e "${R} [B]${RST} - Back to main menu."
    echo -e "${C}===================================================${RST}"
}

while true; do
	show_UI
	read -r -p "Choose option: " option
	case "$option" in
		1)	getMachineIP ;;
		2)	checkListenPort ;;
		b|B)	return 0 ;;
		*)	
			# shellcheck disable=SC1091
        	source "$TOOL_DIR/.modules/handle_error.sh" "$option" ;;
	esac
done
