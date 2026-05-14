# mytool
MyTool, mytool, myTool or Mytool (depends on my typo in program :P) is just a simple tool for my issues quick-fix.
Mostly personal tool for administrative, troubleshooting or repetitive tasks.
This tool have many various original private offline versions, moving them from one machine to another was a pain
due to security, privacy and configurations.
Hence this general public online version is created, though configuration is still required to use it.
This tool version may not catch up with the original version due to it's faster to develop the private one.
So it is what it is and it is as it is. No guarantee, no warranty or whatsoever as it was originally for private use.


## Setup
1. Create tool dir using `mkdir -p` to your desired location.
   ```#!/bin/bash
   # Creates dir mytool at /home/user/mytool
   mkdir -p ~/mytool  
   ```
2. Clone this repo into tool dir.
   ```#!/bin/bash
   # CD into previously created dir
   cd ~/mytool
   # Clone repo into mytool dir
   git clone git@github.com:saddevil16/mytool.git .
   ```
3. Create .env file using ur fav txt editor. eg: `vim .env` or `nano .env`
   ```.env
   SUDO_PASS="PASSWORD123"
   
   # Env for jenkins_https module
   JENKINS_FULLCHAIN_PEM_PATH="/path/to/your/fullchain/pem"
   LETSENCRYPT_FULLCHAIN_PEM_PATH="/etc/letsencrypt/live/your.domain.name/"
   
   # Env for launchctl_helper module
   LAUNCHAGENTS_PATH="/Users/username/Library/LaunchAgents"
   ```
4. Run tool.  
   ```#!/bin/bash
   # Give permission for tool to run
   chmod +x tool.sh
   # Run the tool
   ./tool.sh
   ```
   
## Update  
You can check for update from tool option `[1] - About` and type `y` when prompted `Check for update? (y/n)`.  
or  
you can simply do `git pull` and fetch the latest update from this repo.  

Updating is simply by doing `git pull` to fetch the latest repo update.  
for example:
```
# cd into mytool dir
cd ~/mytool
# pull latest changes
git pull
```

## Uninstall or removing  
Simply delete the tool directory when you do setup, where this repo is cloned into.  
for example:
```
rm -rf ~/mytool
```
