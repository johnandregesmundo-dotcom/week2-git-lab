#Week 2 Git lab
# 🚀 Week 2: Git, Scripting, at Networking

DevOps Apprentice - Phase 1, Week 2

## 📁 Project Structure
week2-git-lab/
├── README.md
├── backup.sh # Automated backup script
├── user-manager.sh # User management
├── disk-monitor.sh # Disk usage monitor
├── log-analyzer.sh # Log analysis
├── service-manager.sh # Systemd service manager
├── setup-dev-env.sh # Capstone: full setup
├── networking-cheatsheet.md
└── log-analyzer/
├── sample.log
└── log-analyzer.sh

text

## 🛠️ Scripts

### backup.sh
Automated backup of any directory. Keeps last 5 backups.

```bash
./backup.sh ~/my-folder
user-manager.sh
Create, delete, or list system users.

bash
./user-manager.sh create juan
./user-manager.sh delete juan
./user-manager.sh list
disk-monitor.sh
Monitor disk usage with warnings above 80%.

bash
./disk-monitor.sh
log-analyzer.sh
Analyze log files (INFO, WARN, ERROR counts).

bash
./log-analyzer.sh sample.log
service-manager.sh
Manage systemd services.

bash
./service-manager.sh list
./service-manager.sh status ssh
./service-manager.sh restart nginx
setup-dev-env.sh
Full automated dev environment setup (Docker, kubectl, firewall).

bash
./setup-dev-env.sh
