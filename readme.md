
# Network Monitor

A simple bash script to monitor your server's network traffic live, using `vnstat` data.  
Shows lifetime download/upload, live network activity, and download/upload ratio.

---

## Features

- Displays total lifetime download and upload data for the server network interface.
- Shows real-time upload and download speeds.
- Calculates and displays download/upload ratio in a readable format.
- Lightweight and runs in terminal.
- Easy installation and usage.

---

## Prerequisites

- Ubuntu or Debian-based Linux server
- `vnstat` installed and initialized for your network interface (e.g., `eth0`)
- `bc` command-line calculator installed

To install prerequisites:

```bash
sudo apt update
sudo apt install -y vnstat bc
```

Make sure `vnstat` is monitoring your interface:

```bash
sudo vnstat -u -i eth0
sudo systemctl restart vnstat
```

---

## Installation

### 1. Clone or download the repository

```bash
git clone https://github.com/AwJHub/Network-Monitor.git
cd netm
```

or simply download the ZIP and extract it.

### 2. Run the install script

This script will:

- Install required packages if needed (`bc`)
- Copy the main script `netm.sh` to `/usr/local/bin`
- Make it executable
- Add an alias `netm` to your `~/.bashrc`

```bash
chmod +x install_netm.sh
./install_netm.sh
```

### 3. Reload your shell or source `.bashrc`

```bash
source ~/.bashrc
```

---

## Usage

Simply run:

```bash
netm
```

This will display your network usage stats live in the terminal.

---

## Customization

- The default monitored interface is `eth0`.  
- To monitor a different interface, edit `netm.sh` and change the interface name on top:

```bash
INTERFACE="your_interface_name"
```

---

## Troubleshooting

- If lifetime usage shows zeros or incorrect values, ensure `vnstat` is correctly tracking your interface.
- To initialize `vnstat` on a new interface:

```bash
sudo vnstat -u -i your_interface_name
sudo systemctl restart vnstat
```

- Make sure `bc` is installed as it is required for calculations.

---

## Contributing

Feel free to fork and submit pull requests to improve the script.

---

## License

MIT License

---

## Contact

Created by Your Name.  
For questions or suggestions, open an issue or contact me at your.email@example.com.
