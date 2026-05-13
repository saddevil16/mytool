#!/bin/bash

check_update() {
	local repo_url="https://raw.githubusercontent.com/saddevil16/mytool/refs/heads/main/.modules/version.txt"
	local currentVersion
	local latestVersion

	currentVersion=$(cat "$TOOL_DIR/.modules/version.txt")
	latestVersion=$(curl -s "$repo_url")

	echo " Current version: v$currentVersion"
	if [ "$latestVersion" != "$currentVersion" ]; then
		echo " New version available: v$latestVersion"
	else
		echo " No new update."
	fi
}