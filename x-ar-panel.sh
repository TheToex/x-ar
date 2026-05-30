#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

while true; do
    source /opt/x-ar/x-ar.conf

    echo -e "${CYAN}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "     XRAY AUTO RESTART PANEL"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${NC}"

    echo -e "${GREEN}[1]${NC} Start Service"
    echo -e "${GREEN}[2]${NC} Stop Service"
    echo -e "${GREEN}[3]${NC} Restart Service"
    echo -e "${GREEN}[4]${NC} Change Interval"
    echo -e "${GREEN}[5]${NC} Remove x-ar"
    echo -e "${GREEN}[0]${NC} Exit"

    read -p "Choose: " choice

    case $choice in
        1)
            systemctl start x-ar
            read -p "Press Enter to continue..."
            ;;
        2)
            systemctl stop x-ar
            read -p "Press Enter to continue..."
            ;;
        3)
            systemctl restart x-ar
            read -p "Press Enter to continue..."
            ;;
        4)
            current_min=$(($INTERVAL / 60))
            echo -e "Current interval (minutes): ${GREEN}$current_min${NC}"
            read -p "Enter new interval (minutes): " interval
            
            if [[ "$interval" =~ ^[0-9]+$ ]]; then
                interval=$((interval * 60))
                sed -i "s/^INTERVAL=.*/INTERVAL=$interval/" /opt/x-ar/x-ar.conf
                echo -e "${GREEN}Interval updated successfully.${NC}"
            else
                echo -e "${RED}Please enter a valid number.${NC}"
            fi
            read -p "Press Enter to continue..."
            ;;
        5)
            echo -e "${RED}Are You Sure? (y/n):${NC}"
            read stat

            if [[ "$stat" == "y" ]]; then
                systemctl stop x-ar
                systemctl disable x-ar

                rm -rf /opt/x-ar
                rm -f /usr/local/bin/x-ar
                rm -f /etc/systemd/system/x-ar.service

                systemctl daemon-reload

                echo -e "${GREEN}x-ar removed successfully.${NC}"
            else
                echo -e "${RED}Cancelled${NC}"
                continue
            fi
            
            break
            ;;
        0)
            break
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done