#!/bin/bash

INTERFACE="eth0"
REPO_RAW_URL="https://github.com/username/netm-monitor/raw/main"

# نصب پیش نیاز
if ! command -v bc &> /dev/null; then
    echo "Installing bc..."
    sudo apt update && sudo apt install -y bc
fi

# دانلود اسکریپت اصلی netm.sh
echo "Downloading netm.sh ..."
curl -s -O "$REPO_RAW_URL/netm.sh" || { echo "Download failed!"; exit 1; }

# کپی به /usr/local/bin
sudo mv netm.sh /usr/local/bin/netm.sh
sudo chmod +x /usr/local/bin/netm.sh

# اضافه کردن alias به bashrc
ALIAS_CMD="alias netm='/usr/local/bin/netm.sh'"
if ! grep -Fxq "$ALIAS_CMD" ~/.bashrc; then
    echo "$ALIAS_CMD" >> ~/.bashrc
    echo "Alias added to ~/.bashrc"
fi

echo "Installation complete! Run 'netm' to start the monitor."
