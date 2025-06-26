#!/bin/bash

INTERFACE="eth0"

read_bytes() {
    line=$(grep "$INTERFACE:" /proc/net/dev)
    RX_BYTES=$(echo "$line" | awk '{print $2}')
    TX_BYTES=$(echo "$line" | awk '{print $10}')
}

bytes_to_mb() {
    echo "scale=2; $1/1024/1024" | bc
}

bytes_to_kbps() {
    echo "scale=2; $1/1024" | bc
}

read_bytes
RX_PREV=$RX_BYTES
TX_PREV=$TX_BYTES

while true; do
    sleep 2
    read_bytes

    RX_TOTAL_MB=$(bytes_to_mb $RX_BYTES)
    TX_TOTAL_MB=$(bytes_to_mb $TX_BYTES)

    # نسبت دانلود به آپلود (D:U)
    if [ "$TX_BYTES" -eq 0 ] || [ "$RX_BYTES" -eq 0 ]; then
        RATIO_STR="∞"
    else
        RATIO_FLOAT=$(echo "scale=2; $RX_BYTES / $TX_BYTES" | bc)
        INV_RATIO=$(echo "scale=2; $TX_BYTES / $RX_BYTES" | bc)
        COMPARE=$(echo "$RATIO_FLOAT >= 1" | bc)
        if [ "$COMPARE" -eq 1 ]; then
            N=$(printf "%.1f" "$RATIO_FLOAT")
            RATIO_STR="1:$N"
        else
            N=$(printf "%.1f" "$INV_RATIO")
            RATIO_STR="$N:1"
        fi
    fi

    RX_DIFF=$((RX_BYTES - RX_PREV))
    TX_DIFF=$((TX_BYTES - TX_PREV))

    RX_SPEED_BPS=$((RX_DIFF / 2))
    TX_SPEED_BPS=$((TX_DIFF / 2))

    RX_SPEED_KBPS=$(bytes_to_kbps $RX_SPEED_BPS)
    TX_SPEED_KBPS=$(bytes_to_kbps $TX_SPEED_BPS)

    RX_PREV=$RX_BYTES
    TX_PREV=$TX_BYTES

    clear
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}\
   ▄████████  ▄█     █▄       ▄█ 
  ███    ███ ███     ███     ███ 
  ███    ███ ███     ███     ███ 
  ███    ███ ███     ███     ███ 
▀███████████ ███     ███     ███ 
  ███    ███ ███     ███     ███ 
  ███    ███ ███ ▄█▄ ███     ███ 
  ███    █▀   ▀███▀███▀  █▄ ▄███ 
                         ▀▀▀▀▀▀        r${NC}"

    echo "📊 Network Usage Monitor - Interface: $INTERFACE"
    echo "=============================="
    echo "🔁 Total Usage:"
    echo "Download (D): $RX_TOTAL_MB MB"
    echo "Upload   (U): $TX_TOTAL_MB MB"
    echo "Ratio (D:U): $RATIO_STR"
    echo
    echo "⚡ Live Speed (averaged over 2 sec):"
    echo "Download Speed (D): $RX_SPEED_KBPS KB/s"
    echo "Upload Speed   (U): $TX_SPEED_KBPS KB/s"
done
