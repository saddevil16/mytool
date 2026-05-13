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

test_pass() {
    loadEnv
    local pass="$SUDO_PASS"
    echo "$pass" | sudo -S ls
    unset pass

    read -r -p "Press any key to continue.."
}

test_pass
