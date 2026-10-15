#!/bin/bash

# setup-dev-env.sh - Complete Dev Environment Setup
# Phase 1 - Week 2 Capstone Project
# DevOps Apprentice

set -e  # Exit on error

echo "=========================================="
echo "  DEVOPS APPRENTICE ENVIRONMENT SETUP"
echo "=========================================="
echo ""

# 1. System update
echo "[1/8] Updating system..."
sudo apt update && sudo apt upgrade -y

# 2. Install essential packages
echo "[2/8] Installing essential packages..."
sudo apt install -y \
    curl wget git vim nano \
    htop tree net-tools \
    traceroute dnsutils \
    zip unzip tar \
    build-essential

# 3. Install Docker
echo "[3/8] Installing Docker..."
if ! command -v docker &> /dev/null; then
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    echo "✅ Docker installed"
else
    echo "✅ Docker already installed"
fi

# 4. Install kubectl
echo "[4/8] Installing kubectl..."
if ! command -v kubectl &> /dev/null; then
    curl -LO "https://dl.k8s/release/$(curl -L -s https://dl.k8s/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    echo "✅ kubectl installed"
else
    echo "✅ kubectl already installed"
fi

# 5. Setup Git
echo "[5/8] Configuring Git..."
git config --global init.defaultBranch main
echo "✅ Git configured"

# 6. Create directory structure
echo "[6/8] Creating project structure..."
mkdir -p ~/devops-projects/{docker,kubernetes,terraform,scripts,backups}
echo "✅ Directories created"

# 7. Setup firewall
echo "[7/8] Configuring firewall..."
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable
echo "✅ Firewall configured"

# 8. System info
echo ""
echo "[8/8] Setup complete!"
echo "=========================================="
echo "  SYSTEM SUMMARY"
echo "=========================================="
echo "Hostname: $(hostname)"
echo "OS: $(lsb_release -d | cut -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo ""
echo "Installed tools:"
docker --version 2>/dev/null || echo "  Docker: Not installed"
kubectl version --client 2>/dev/null || echo "  kubectl: Not installed"
git --version
echo ""
echo "Project directories:"
tree -L 1 ~/devops-projects 2>/dev/null || ls ~/devops-projects
echo ""
echo "⚠️ NOTE: Logout and login again for Docker group changes to take effect"
echo "=========================================="
EOF

