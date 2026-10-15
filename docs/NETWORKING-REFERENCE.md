# 🌐 Networking Reference Guide

Complete guide sa Linux networking commands na natutunan ko.

---

## 🔌 Network Interfaces

```bash
ip addr                    # List IP addresses (modern)
ip addr show eth0          # Specific interface
ip link                    # Interface status
ip link set eth0 up        # Bring up
ip link set eth0 down      # Bring down
ip -s link                 # Interface stats
ifconfig                   # Legacy (kailangan pa i-install)
🗺️ Routing
bash
ip route                   # Routing table
ip route add default via 192.168.1.1    # Add default route
ip route del default                    # Delete route
traceroute google.com      # Path ng packets
mtr google.com             # Realtime traceroute
🌍 DNS
bash
cat /etc/resolv.conf       # DNS servers
nslookup google.com        # Simple lookup
dig google.com             # Detailed
dig +short google.com      # IP lang
dig google.com A           # IPv4
dig google.com AAAA        # IPv6
dig MX gmail.com           # Mail records
host google.com            # Simplest

# Use specific DNS
dig @8.8.8.8 google.com
nslookup google.com 1.1.1.1
DNS Servers:

Google: 8.8.8.8, 8.8.4.4

Cloudflare: 1.1.1.1, 1.0.0.1

OpenDNS: 208.67.222.222, 208.67.220.220

📡 Connectivity Tests
bash
ping -c 4 8.8.8.8          # Test raw internet
ping -c 4 google.com       # Test DNS + internet
ping -c 4 -i 0.2 host      # Faster ping (0.2s interval)
curl -I https://google.com # HTTP headers
curl -v https://google.com # Verbose (full request/response)
wget -qO- https://ipinfo.io # Check public IP
Ping interpretation:

Gumagana ping 8.8.8.8 pero ping google.com hindi → DNS issue

Parehong hindi → Network/Internet issue

🔍 Ports at Services
bash
ss -tuln                   # Listening ports
ss -tulnp                  # With process IDs (sudo)
ss -tuln | grep :22        # Specific port
netstat -tuln              # Legacy
sudo lsof -i :22           # Sino may hawak ng port 22?
sudo lsof -i -P -n         # All network files
Legend:

-t = TCP

-u = UDP

-l = Listening

-n = Numeric (walang DNS lookup)

-p = Process info

🛡️ Firewall (UFW)
bash
sudo ufw status                    # Check status
sudo ufw status verbose            # Detailed
sudo ufw enable                    # Enable
sudo ufw disable                   # Disable
sudo ufw default deny incoming     # Default policies
sudo ufw default allow outgoing
sudo ufw allow 22                  # Allow SSH
sudo ufw allow 22/tcp              # TCP only
sudo ufw allow 80,443/tcp          # Multiple ports
sudo ufw allow from 192.168.1.0/24 # Specific subnet
sudo ufw deny 3306                 # Deny MySQL
sudo ufw delete allow 80           # Remove rule
sudo ufw reset                     # Reset all
📋 Common Ports
Port	Protocol	Service	Notes
21	TCP	FTP	File transfer (insecure)
22	TCP	SSH	Remote login
25	TCP	SMTP	Email
53	TCP/UDP	DNS	Name resolution
80	TCP	HTTP	Web (unencrypted)
443	TCP	HTTPS	Web (encrypted)
3306	TCP	MySQL	Database
5432	TCP	PostgreSQL	Database
6379	TCP	Redis	Cache
8080	TCP	HTTP Alt	Dev/proxy
27017	TCP	MongoDB	NoSQL
📁 Config Files
File	Purpose
/etc/hosts	Static hostname-to-IP map
/etc/resolv.conf	DNS servers
/etc/netplan/*.yaml	Network config (modern Ubuntu)
/etc/network/interfaces	Network config (legacy)
/etc/hostname	Hostname ng machine
🔧 /etc/hosts
bash
cat /etc/hosts

# Format:
# IP_ADDRESS    HOSTNAME    [ALIASES]
127.0.0.1       localhost
127.0.0.1       myapp.local
192.168.1.100   dbserver.local

# Add entry
echo "127.0.0.1 myapp.local" | sudo tee -a /etc/hosts

# Test
ping myapp.local
🚨 DNS Troubleshooting Flow
Step 1: Check DNS config

bash
cat /etc/resolv.conf
Step 2: Test DNS resolution

bash
nslookup google.com
Step 3: Test raw internet

bash
ping -c 4 8.8.8.8
Step 4: Analyze

IP works, domain fails → DNS issue

Both fail → Network issue

Step 5: Try another DNS

bash
nslookup google.com 1.1.1.1
Step 6: Flush DNS cache

bash
sudo systemd-resolve --flush-caches
Step 7: Restart network

bash
sudo systemctl restart systemd-resolved
🧪 Network Commands Cheat Sheet
bash
# BASIC
ip addr                      # IP addresses
ip route                     # Routes
ping -c 4 8.8.8.8            # Test connectivity
traceroute google.com        # Path
dig google.com               # DNS
ss -tuln                     # Ports

# FIREWALL
sudo ufw status              # Check
sudo ufw allow 22            # Allow SSH
sudo ufw deny 3306           # Deny MySQL

# CURL / WGET
curl -I https://google.com   # Headers
curl -X POST -d "data" URL   # POST request
wget file.txt URL            # Download
💡 Best Practices
Use ip instead of ifconfig — Modern, supported.

Use ss instead of netstat — Faster, modern.

Default deny, allow specific — Firewall rule.

Hindi 0.0.0.0 — Iwas expose sa lahat.

SSH keys, hindi passwords — Mas secure.

Monitor ports regularly — ss -tulnp.

Document your network — IPs, ports, services.

Part of DevOps Journey — Week 2 Documentation

text

**Save:** `Ctrl + O` → `Enter` → `Ctrl + X`

---

## 🚀 Push Lahat Sa GitHub

Ngayon, i-push mo na lahat:

```bash
# Pumasok sa repo
cd ~/devops-projects/week2-git-lab

# I-check yung status
git status

# I-add lahat
git add .

# I-commit
git commit -m "Day 7: Add comprehensive Week 2 documentation"

# I-push
git push
Dapat may lumabas:

text
Enumerating objects: X, done.
...
To github.com:johnandregesmundo-dotcom/week2-git-lab.git
   abc1234..def5678  main -> main
