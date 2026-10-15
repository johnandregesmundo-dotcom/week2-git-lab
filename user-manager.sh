#!/bin/bash

# user-manager.sh - User management automation
# DevOps Apprentice - Week 2 Day 2

ACTION=$1
USERNAME=$2

case $ACTION in
    create)
        if id "$USERNAME" &>/dev/null; then
            echo "User $USERNAME ay umiiral na!"
        else
            sudo useradd -m -s /bin/bash "$USERNAME"
            echo "✅ User $USERNAME ay nalikha na."
        fi
        ;;
    delete)
        if id "$USERNAME" &>/dev/null; then
            sudo userdel -r "$USERNAME"
            echo "✅ User $USERNAME ay nabura na."
        else
            echo "User $USERNAME ay hindi umiiral!"
        fi
        ;;
    list)
        echo "System users:"
        cut -d: -f1 /etc/passwd | sort
        ;;
    *)
        echo "Usage: $0 {create|delete|list} [username]"
        exit 1
        ;;
esac
