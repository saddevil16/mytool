# mytool

## Setup
1. Create tool dir.  
   ```#!/bin/bash
   mkdir -p mytool
   ```
2. Clone repo into dir.  
   ```#!/bin/bash
   git clone git@github.com:saddevil16/mytool.git .
   ```
3. Create .env file and add secrets.
   Check [example .env](#Example-Env) file
   ```#!/bin/bash
   touch .env
   nano .env
   ```
4. Run tool.  
   ```#!/bin/bash
   cmod +x tool.sh
   ./tool.sh
   ```
5. tba

## Example Env
.env file:
```.env
SUDO_PASS="PASSWORD123"

# Env for jenkins_https modules
JENKINS_FULLCHAIN_PEM_PATH="/path/to/your/fullchain/pem"
LETSENCRYPT_FULLCHAIN_PEM_PATH="/etc/letsencrypt/live/your.domain.name/"
```
