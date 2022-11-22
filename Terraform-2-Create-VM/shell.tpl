#!/bin/bash 

cd /root

#Update/Download packages
apt update
apt -y full-upgrade
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt install -y azure-cli nodejs chromium-browser unzip gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget libgbm-dev libglib2.0-0



#Download file
az login --identity
az storage blob download --account-name "${storage_account_name}" --container-name "${container_name}" --name Puppeteer_Framework.zip -f Puppeteer_Framework.zip --auth-mode login

#Install npm packages
unzip Puppeteer_Framework.zip
cd Puppeteer_Framework
npm i


#Upload log file
az login --identity
echo "This is a log file" > Log_16_10_2022.txt
az storage blob upload --account-name "${storage_account_name}" --container-name "${container_name}" --name Log_16_10_2022.txt --file Log_16_10_2022.txt --auth-mode login
