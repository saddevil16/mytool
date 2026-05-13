#!/bin/bash

check_update() {
	local repo_version_url="https://raw.githubusercontent.com/saddevil16/mytool/refs/heads/main/.modules/version.txt"
	local repo_url="https://github.com/saddevil16/mytool.git"
	local currentVersion
	local latestVersion

	currentVersion=$(cat "$TOOL_DIR/.modules/version.txt")
	latestVersion=$(curl -s "$repo_version_url")

	echo " Current version: v$currentVersion"
	if [ "$latestVersion" != "$currentVersion" ]; then
		echo " New version available: v$latestVersion"
		echo ""
		echo " Obtain latest update from $repo_url"
	else
		echo " No new update."
	fi
}