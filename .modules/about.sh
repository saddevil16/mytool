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
	echo ""
	echo -e "${G} Inquiry:${RST} contact@pejal.org"
	echo -e "${C}===================================================${RST}"
	read -r -p "Press any key to return.."
	return 0
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
