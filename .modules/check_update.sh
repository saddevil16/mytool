#!/bin/bash

version_cmp() {
    local v1="$1"
    local v2="$2"

    if [ "$v1" = "$v2" ]; then
        echo "equal"
        return
    fi

    if [ "$(printf '%s\n%s\n' "$v1" "$v2" | sort -V | head -n1)" = "$v1" ]; then
        echo "less"
    else
        echo "greater"
    fi
}

url_reachable() {
    local url=$1
    local status

    curl "$url" &>/dev/null
    status="$?"

    if [ "$status" != 0 ]; then
        echo -e " ${YB}[Warn]${RST} Unable to check version, please check your"
        echo " internet connection."
        echo ""
    fi
}

check_update() {
	local repo_version_url="https://raw.githubusercontent.com/saddevil16/mytool/refs/heads/main/.modules/version.txt"
	local currentVersion
	local latestVersion

	currentVersion=$(cat "$TOOL_DIR/.modules/version.txt")
	#latestVersion=$(curl -s "$repo_version_url")

    if url_reachable "$repo_version_url"; then
        latestVersion=$(curl -s "$repo_version_url")
    else
        latestVersion="$currentVersion"
    fi

	case "$(version_cmp "$latestVersion" "$currentVersion")" in
	    greater)
	    	echo " Current version: v$currentVersion"
	        echo " New version available: v$latestVersion"
	        return 0 # update available
	        ;;
	    equal)
	    	echo " Current version: v$currentVersion"
	        echo " Already up to date."
	        return 1 # no new update
	        ;;
	    less)
	    	# Display current version as latese version since repo_version_url value is not yet updated (network delay)
	    	echo " Current version: v$currentVersion"
	    	echo " Already up to date."
	        return 1 # no new update
	        ;;
	esac
}
