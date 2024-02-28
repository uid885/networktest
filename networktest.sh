#!/bin/bash
# Author:      Christo Deale                  
# Date:        2024-02-28                
# networktest: Utility to test Internet & Network Speed

while true; do
    echo -e "\e[31mChoose an option:\e[0m"
    echo "1. Test Internet Speed"
    echo "2. Test Network Speed"
    echo "3. Quit"

    read -p "Enter your choice (1/2/3): " choice

    case $choice in
        1)
            # Test Internet Speed
            if ! command -v speedtest-cli &> /dev/null; then
                echo "speedtest-cli not found, installing..."
                cd $HOME || exit
                if [ -d "speedtest-cli" ]; then
                    echo "speedtest-cli directory already exists, skipping cloning."
                else
                    git clone https://github.com/sivel/speedtest-cli.git
                    cd speedtest-cli || exit
                fi
            else
                echo "speedtest-cli is already installed."
            fi

            if python $HOME/speedtest-cli/speedtest.py; then
                echo "Internet speed test successful."
            else
                echo -e "\e[31mError: Internet speed test failed.\e[0m"
            fi
            ;;
        2)
            # Test Network Speed
            if ! command -v iperf3 &> /dev/null; then
                echo "iperf3 not found, installing..."
                sudo yum install -y iperf3
            else
                echo "iperf3 is already installed."
            fi

            read -p "Enter IP address or website to test network speed to: " target
            echo "Running network speed test to $target..."
            iperf3 -c "$target"
            ;;
        3)
            # Quit
            echo "Exiting script. Goodbye!"
            exit 0
            ;;
        *)
            echo -e "\e[31mInvalid option. Please choose a valid option.\e[0m"
            ;;
    esac
done
