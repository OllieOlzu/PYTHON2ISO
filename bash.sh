#!/bin/sh

echo "📂 Boot script running..."
cp /python.py /MAIN/python.py
chmod +x /MAIN/python.py

for ext in /MAIN/*.tcz; do
    echo "📦 Loading extension: $(basename "$ext")"
    sudo -u tc tce-load -i "$ext"
done

clear
/usr/local/bin/python3 /MAIN/python.py
