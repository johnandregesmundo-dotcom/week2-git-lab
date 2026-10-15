#!/bin/bash

# service-manager.sh - Manage systemd services
# DevOps Apprentice - Week 2 Day 5

ACTION=$1
SERVICE=$2

case $ACTION in
    list)
        echo "📋 Running services:"
        systemctl list-units --type=service --state=running
        ;;
    status)
        if [ -z "$SERVICE" ]; then
            echo "Usage: $0 status <service>"
            exit 1
        fi
        systemctl status "$SERVICE"
        ;;
    start)
        sudo systemctl start "$SERVICE"
        echo "✅ $SERVICE started"
        ;;
    stop)
        sudo systemctl stop "$SERVICE"
        echo "🛑 $SERVICE stopped"
        ;;
    restart)
        sudo systemctl restart "$SERVICE"
        echo "🔄 $SERVICE restarted"
        ;;
    enable)
        sudo systemctl enable "$SERVICE"
        echo "✅ $SERVICE enabled on boot"
        ;;
    disable)
        sudo systemctl disable "$SERVICE"
        echo "❌ $SERVICE disabled on boot"
        ;;
    *)
        echo "Usage: $0 {list|status|start|stop|restart|enable|disable} [service]"
        exit 1
        ;;
esac
Save: Ctrl+O, Enter, Ctrl+X

Test:

bash
chmod +x service-manager.sh
./service-manager.sh list
./service-manager.sh status ssh
