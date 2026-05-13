#!/bin/bash
# colors.sh - ANSI color definitions

# Text color (short name)
export R='\033[0;31m' # RED
export G='\033[0;32m' # GREEN
export Y='\033[0;33m' # YELLOW
export B='\033[0;34m' # BLUE
export M='\033[0;35m' # MAGENTA
export C='\033[0;36m' # CYAN
export W='\033[0;37m' # WHITE
export RST='\033[0m'  # RESET (not color)

# BOLD Text color (short name)
export RB='\033[1;31m' # RED
export GB='\033[1;32m' # GREEN
export YB='\033[1;33m' # YELLOW
export BB='\033[1;34m' # BLUE
export MB='\033[1;35m' # MAGENTA
export CB='\033[1;36m' # CYAN
export WB='\033[1;37m' # WHITE
export RST='\033[0m'  # RESET (not color)

# Background colors (optional)
export BG_RED='\033[41m'
export BG_GREEN='\033[42m'
export BG_YELLOW='\033[43m'
export BG_BLUE='\033[44m'
export BG_MAGENTA='\033[45m'
export BG_CYAN='\033[46m'
