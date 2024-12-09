#!/bin/bash

# Function to update the system and installed tools
update_system() {
    echo "Updating system and tools..."
    sudo apt update && sudo apt upgrade -y
    sudo apt autoremove -y
}

# Function to check and install missing tools
install_tool() {
    tool=$1
    if ! command -v $tool &> /dev/null; then
        echo "$tool not found. Installing..."
        sudo apt update && sudo apt install -y $tool
    else
        echo "$tool is already installed."
    fi
}


# Update system and tools at the start
update_system

# Install basic hacking tools if they are not installed
install_tool "nmap"
install_tool "netcat"
install_tool "hydra"
install_tool "aircrack-ng"
install_tool "john"

# Tool selection menu
echo "Select a tool to use:"
echo "1. Nmap Ping Scan"
echo "2. Nmap Scan"
echo "3. Netcat Listener"
echo "4. Hydra Brute Force"
echo "5. Aircrack-ng"
echo "6. John the Ripper"

read -p "Enter the number of the tool you want to use: " choice

case $choice in
    1)
        # Nmap Ping Scan
        read -p "Enter the IP address: " ip
        nmap -sn $ip
        ;;
    2)
        # Nmap Scan
        read -p "Enter the IP address: " ip
        nmap $ip
        ;;
    3)
        # Netcat Listener
        read -p "Enter the port to listen on: " port
        nc -lvp $port
        ;;
    4)
        # Hydra Brute Force
        read -p "Enter the target IP address: " ip
        read -p "Enter the username: " username
        read -p "Enter the password list location: " passlist
        hydra -l $username -P $passlist $ip ssh
        ;;
    5)
        # Aircrack-ng (simple example)
        read -p "Enter the path to the capture file: " capture_file
        read -p "Enter the path to the wordlist: " wordlist
        aircrack-ng $capture_file -w $wordlist
        ;;
    6)
        # John the Ripper
        read -p "Enter the hash file: " hash_file
        john $hash_file
        ;;
    *)
        echo "Invalid choice!"
        ;;
esac
