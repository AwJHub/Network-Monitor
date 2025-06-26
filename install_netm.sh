#!/bin/bash

# نصب bc اگر نصب نیست
if ! command -v bc &> /dev/null; then
  echo "Installing bc..."
  sudo apt-get update
  sudo apt-get install -y bc
fi

# دانلود اسکریپت اصلی netm.sh به /usr/local/bin/netm
echo "Downloading netm.sh..."
curl -s https://raw.githubusercontent.com/AwJHub/Network-Monitor/main/netm.sh -o /usr/local/bin/netm
chmod +x /usr/local/bin/netm

# اضافه کردن alias به bashrc اگر قبلا اضافه نشده
if ! grep -q 'alias netm=' ~/.bashrc; then
  echo "alias netm='/usr/local/bin/netm'" >> ~/.bashrc
fi

echo "Installation done! Please run 'source ~/.bashrc' or open a new terminal."
