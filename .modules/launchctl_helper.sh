#!/bin/bash

loadEnv() {
    local envFile="$TOOL_DIR/.env"
    if [ ! -f "${envFile}" ]; then
        echo "[Error] env file not found at ${envFile}"
        return 1
    fi
    set -a
    # shellcheck disable=SC1090
    source "${envFile}"
    set +a
}

list_services() {
	# shellcheck disable=SC2153
	local services_path="$LAUNCHAGENTS_PATH"

	if [ -z "$services_path" ]; then
		echo "[Error] 'LAUNCHAGENTS_PATH' not set in .env"
	else
		ls "$services_path"
	fi

	read -r -p "Press any key to continue.."
}

check_service() {
	local service_name

	echo "Example: com.unity3d.accelerator"
	read -r -p "Enter service name: " service_name

	launchctl print "gui/$(id -u)/$service_name"

	read -r -p "Pres any key to continue.."
}

start_service() {
	local launchAgents_path="$LAUNCHAGENTS_PATH"
	local plist

	if [ -z  "$launchAgents_path" ]; then
		echo "[Error] 'LAUNCHAGENTS_PATH' not set in .env"
		read -r -p "Press any key to continue.."
		return 1
		# exit 1
	fi

	echo "Example: com.unity3d.accelerator"
	read -r -p "Enter service name: " service

	plist="$launchAgents_path/${service}.plist"

	echo "🚀 Starting $service..."
	if launchctl bootstrap "gui/$(id -u)" "$plist"; then
		echo "✅ $service started successfully"
	    return 0    
	else
	    echo "❌ Failed to start $service"
	    return 1
	fi
}

stop_service() {
	local launchAgents_path="$LAUNCHAGENTS_PATH"
	local plist

	if [ -z  "$launchAgents_path" ]; then
		echo "[Error] 'LAUNCHAGENTS_PATH' not set in .env"
		read -r -p "Press any key to continue.."
		return 1
		# exit 1
	fi

	echo "Example: com.unity3d.accelerator"
	read -r -p "Enter service name: " service

	plist="$launchAgents_path/${service}.plist"

	echo "Stopping $service..."
	if launchctl bootout "gui/$(id -u)" "$plist"; then
		echo "✅ $service stopped successfully"
	    return 0    
	else
	    echo "❌ Failed to stop $service"
	    return 1
	fi
}

check_os() {
	local op_sys
	op_sys="$(uname -a | grep -o '^\w*')"

	if [ "$op_sys" != "Darwin" ]; then
		echo -e "${YB}[Warn] Launchctl cli is for macOS, not other system.${RST}"
	else
		return 0
	fi

	read -r -p "Press B to return or any key to continue.." input
	case "$input" in 
		b|B) return 1 ;;
		*)	return 0;;
	esac
}

launchctl_helper_UI() {
	if ! check_os; then
		return
	fi

	clear
	echo -e "${C}===================================================${RST}"
	echo -e "${Y} Launchctl Helper${RST}"
	echo -e "${C}---------------------------------------------------${RST}"
    echo " Available options:"
    echo -e "${G} [1]${RST} - Check service running"
    echo -e "${G} [2]${RST} - List services"
    echo -e "${G} [3]${RST} - Stop Service"
    echo -e "${G} [4]${RST} - Start Service"
    echo ""
    echo -e "${R} [B]${RST} - Back to main menu."
	echo -e "${C}===================================================${RST}"

	read -r -p "Choose option: " options

	case "$options" in
		1)	check_service ;;
		2)	loadEnv && list_services 
			unset LAUNCHAGENTS_PATH ;;
		3)	loadEnv && stop_service
			unset LAUNCHAGENTS_PATH ;;
		4)	loadEnv && start_service
			unset LAUNCHAGENTS_PATH ;;
		b|B) return 0 ;;
		*)	source "$TOOL_DIR/.modules/handle_error.sh" "$options" ;;
	esac
} 