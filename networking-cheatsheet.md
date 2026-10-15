# 🌐 Linux Networking Cheatsheet

## 1. Network Interfaces

| Command | Meaning |
|---------|---------|
| `ip addr` | Ipakita lahat ng IP addresses (modern ifconfig) |
| `ip link` | Interface status (up/down) |
| `ip route` | Routing table — saan dadaan ang traffic |
| `ifconfig` | Legacy version ng `ip addr` |

## 2. DNS

| Command | Meaning |
|---------|---------|
| `cat /etc/resolv.conf` | Tingnan ang DNS servers |
| `nslookup google.com` | DNS lookup (simple) |
| `dig google.com` | Detailed DNS info |
| `host google.com` | Simpleng DNS lookup |

## 3. Connectivity Tests

| Command | Meaning |
|---------|---------|
| `ping -c 4 8.8.8.8` | Test internet (IP address) |
| `ping -c 4 google.com` | Test internet + DNS |
| `traceroute google.com` | Route path ng packets |
| `curl -I https://google.com` | HTTP headers lang |
| `wget -qO- https://ipinfo.io` | Check public IP |

## 4. Ports at Services

| Command | Meaning |
|---------|---------|
| `ss -tuln` | List listening ports (modern) |
| `netstat -tuln` | Legacy version |
| `sudo lsof -i :22` | Sino gumagamit ng port 22? |
| `sudo lsof -i :80` | Sino gumagamit ng port 80? |

## 5. Firewall (UFW)

```bash
sudo ufw status              # Check status
sudo ufw enable              # Enable
sudo ufw allow 22            # Allow SSH
sudo ufw allow 80            # Allow HTTP
sudo ufw allow 443           # Allow HTTPS
sudo ufw deny 3306           # Deny MySQL
sudo ufw status verbose      # Detailed view
6. Common Ports
Port	Service	Notes
22	SSH	Remote login
80	HTTP	Web (unencrypted)
443	HTTPS	Web (encrypted)
3306	MySQL	Database
5432	PostgreSQL	Database
27017	MongoDB	NoSQL Database
6379	Redis	Cache/Queue
8080	HTTP Alt	Common for apps
7. /etc/hosts
bash
cat /etc/hosts
# Mag-add ng custom host:
echo "127.0.0.1 myapp.local" | sudo tee -a /etc/hosts
ping myapp.local
8. DNS Troubleshooting Steps
Check if DNS servers are configured: cat /etc/resolv.conf

Test DNS resolution: nslookup google.com

Test raw internet: ping -c 4 8.8.8.8

If IP works but domain doesn't → DNS issue

Try another DNS: nslookup google.com 1.1.1.1

Flush DNS cache: sudo systemd-resolve --flush-caches

text

**Save:** `Ctrl+O`, Enter, `Ctrl+X`

**Push:**
```bash
git add networking-cheatsheet.md
git commit -m "Day 3: Add networking cheatsheet"
git push



