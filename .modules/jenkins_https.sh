#!/bin/bash

source "$TOOL_DIR/.modules/colors.sh"

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

checkCert() {
	local pass="$SUDO_PASS"
	local jenkins_cert_path="$JENKINS_FULLCHAIN_PEM"
	local certbot_jenkins_cert_path="$LETSENCRYPT_FULLCHAIN_PEM"

	echo -e "${G}Jenkins Cert Expiry: ${RST}"
	echo "Checking '$jenkins_cert_path' expiry.."
    openssl x509 -in "$jenkins_cert_path" -noout -enddate

    echo ""
    echo -e "${G}Certbot Renewed Cert Expiry:${RST}"
    echo "Checking $certbot_jenkins_cert_path expiry.."
    echo "${pass}" | sudo -S openssl x509 -in "$certbot_jenkins_cert_path" -noout -enddate

    read -r -p "Press any key to continue.."
}

show_UI() {
    clear
    echo -e "${C}===================================================${RST}"
    echo -e "${Y} Jenkins HTTPS Cert renewal related stuff${RST}"
    echo -e "${C}---------------------------------------------------${RST}"
    echo " Available options:"
    echo -e "${G} [1]${RST} - Check processed Jenkins HTTPS cert expiry."
    echo -e "${R} [B]${RST} - Back to main menu."
    echo -e "${C}===================================================${RST}"
}

while true; do
    show_UI
    read -r -p "Choose option: " option
    
    case $option in
        1) 
        	loadEnv && checkCert 
        	unset SUDO_PASS JENKINS_FULLCHAIN_PEM LETSENCRYPT_FULLCHAIN_PEM
        	;;
        b|B) return 0 ;;
        *) 
            source "$TOOL_DIR/.modules/handle_error.sh" "$option" 
            ;;
    esac
    
done