#!/bin/bash

about_UI() {
	local version
	version="$(cat "$TOOL_DIR/.modules/version.txt")"
	clear
	echo -e "${C}===================================================${RST}"
	echo -e "${YB} MyTool - v$version${RST}"
	echo -e "${C}---------------------------------------------------${RST}"
	echo " Simple tool for my issues quick-fix."
	echo ""
	echo -e "${GB} Inquiry:${RST} contact@pejal.org"
	echo -e "${C}===================================================${RST}"
}

about_UI_updated() {
	# shellcheck disable=SC1091
	source "$TOOL_DIR/.modules/check_update.sh"
	local version
	version="$(cat "$TOOL_DIR/.modules/version.txt")"
	clear
	echo -e "${C}===================================================${RST}"
	echo -e "${Y} MyTool - v$version${RST}"
	echo -e "${C}---------------------------------------------------${RST}"
	echo " Simple tool for my issues quick-fix."
	echo ""
	check_update
	has_update=$?
	echo ""
	echo -e "${G} Inquiry:${RST} contact@pejal.org"
	echo -e "${C}===================================================${RST}"
	if [ "$has_update" -eq 0 ]; then
		read -r -p "Get new update? (y/n) or press any key to return.. " input
	else
		read -r -p "Press any key to return.."
	fi

	case "$input" in
		y|Y) 
			echo "Obtaining new update.."
			if git pull ; then
				echo "Updated successfully."
				sleep 2
				return 0
			else
				echo "Update failed.."
				sleep 2
				return 1
			fi
			;;
		*)	return 0 ;;
	esac
}

handle_about_input() {

	echo -e "${YB}Check for update?${RST} (y/n)"
	read -r -p "or press any key to return.. " input_about
	case "$input_about" in
		y|Y)
			about_UI_updated
			;;
		n|N|*)
			return 0;;
	esac
}

show_about() {
	about_UI
	handle_about_input
	return 0
}
