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

processCert() {
	local PASS="$SUDO_PASS"
	local https_dir="$JENKINS_FULLCHAIN_PEM_PATH"
	local cert_dir="$LETSENCRYPT_FULLCHAIN_PEM_PATH"

	if [ ! -d "$https_dir" ]; then
 	    mkdir -p "$https_dir"
    else
		echo "Forcefully removing $https_dir"
	 	echo "$PASS" | sudo -S rm -r "$https_dir"
        mkdir -p "$https_dir"
    fi

    # shellcheck disable=SC2024
    echo "$PASS" | sudo -S cat "$cert_dir/fullchain.pem" > $https_dir/fullchain.pem
    # shellcheck disable=SC2024
    echo "$PASS" | sudo -S cat "$cert_dir/privkey.pem" > $https_dir/privkey.pem
    unset PASS

    echo "Generated $https_dir/jenkins.jks"
    
    echo "Finished processing certificate."
    read -r -p "Press any key to continue.. "
}

checkCert() {
	local pass="$SUDO_PASS"
	local jenkins_cert_path="$JENKINS_FULLCHAIN_PEM_PATH"
	local certbot_jenkins_cert_path="$LETSENCRYPT_FULLCHAIN_PEM_PATH"

	echo -e "${G}Jenkins Cert Expiry: ${RST}"
	echo "Checking $jenkins_cert_path/fullchain.pem expiry.."
    openssl x509 -in "$jenkins_cert_path/fullchain.pem" -noout -enddate

    echo ""
    echo -e "${G}Certbot Renewed Cert Expiry:${RST}"
    echo "Checking $certbot_jenkins_cert_path/fullchain.pem expiry.."
    echo "${pass}" | sudo -S openssl x509 -in "$certbot_jenkins_cert_path/fullchain.pem" -noout -enddate
    unset pass

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
        	unset SUDO_PASS JENKINS_FULLCHAIN_PEM_PATH LETSENCRYPT_FULLCHAIN_PEM_PATH
        	;;
        2)
        	loadEnv && processCert
        	unset SUDO_PASS JENKINS_FULLCHAIN_PEM_PATH LETSENCRYPT_FULLCHAIN_PEM_PATH
        	;;
        b|B) return 0 ;;
        *) 
            source "$TOOL_DIR/.modules/handle_error.sh" "$option" 
            ;;
    esac
    
done