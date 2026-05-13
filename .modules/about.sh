#!/bin/bash

version="$(cat "$TOOL_DIR/.modules/version.txt")"
clear
echo -e "${C}===================================================${RST}"
echo -e "${Y} MyTool - v$version${RST}"
echo -e "${C}---------------------------------------------------${RST}"
echo " Simple tool for my issues quick-fix."
echo ""
echo -e "${G} Inquiry:${RST} contact@pejal.org"
echo -e "${C}===================================================${RST}"
read -r -p "Press any key to continue.. "
return
