# 📖 Week 2 Review — Git, Scripting, at Networking

**DevOps Apprentice Journey — Week 2 Complete Review**

Ito ang kumpletong review ng lahat ng natutunan ko sa Week 2. Hindi lang ito listahan ng commands — ipinapaliwanag ko rin ang **bakit** at **paano** gamitin ang bawat isa.

---

## 🎯 Ano ang Week 2?

Ang Week 1 ay foundation (Linux basics). Ang Week 2 ay ang **unang tunay na DevOps skills** — yung mga bagay na araw-araw mong gagamitin sa trabaho.

| Day | Focus | Deliverable |
|-----|-------|-------------|
| 1 | Git Deep Dive | Branches, merge, conflict, tags |
| 2 | Advanced Bash | 3 scripts (backup, user-manager, disk-monitor) |
| 3 | Networking Basics | Networking cheatsheet |
| 4 | Text Processing | Log analyzer script |
| 5 | Process & Service | Service manager script |
| 6 | Capstone | setup-dev-env.sh |
| 7 | Review | Documentation (ito!) |

---

## 📅 Day 1: Git Deep Dive

### Bakit Mahalaga ang Git sa DevOps?

Sa DevOps, **hindi ka nagtatrabaho mag-isa**. Yung code mo, may kasamang team. Git ang paraan para:
- Mag-track ng changes
- Mag-collaborate nang hindi nagbabanggaan
- Mag-rollback kung may mali
- Mag-release ng versions

### Ano ang Natutunan Ko

**1. Branches — "Parallel Universe" ng Code**

Ang branch ay hiwalay na kopya ng code mo. Pwede kang mag-experiment doon nang hindi nasisira yung main.

```bash
git checkout -b feature-1    # Gumawa at lumipat sa bagong branch
git branch                    # Tingnan lahat ng branches
git checkout main             # Bumalik sa main
Analogy: Parang "draft" ng Facebook post. Pwede mong i-edit, tapos i-"publish" (merge) kapag okay na.

2. Merging — Pagsasama ng Branch

bash
git merge feature-1
Dalawa ang uri:

Fast-forward — Walang conflict, deretso lang. Linear history.

Merge commit — May conflict o divergent history. May special commit na nagsasabi "pinagsama ko 'to".

3. Conflict Resolution — Pag-aayos ng Banggaan

Nangyayari 'to kapag dalawang branch ay nag-edit ng same line.

bash
# Markers sa file:
<<<<<<< HEAD
Yung laman ng current branch mo
=======
Yung laman ng branch na ini-merge
>>>>>>> feature-b
Paano i-resolve:

I-edit ang file — pumili ka kung alin ang panatilihin (o pagsamahin)

Alisin ang markers (<<<<<<<, =======, >>>>>>>)

git add <file>

git commit -m "Resolve merge conflict"

4. Stashing — "Save for Later"

Kapag may urgent na kailangan gawin pero may changes ka pang hindi pa ready i-commit.

bash
git stash        # Itago muna
git stash list   # Tingnan ang listahan
git stash pop    # Ibalik
5. Tagging — Mark ng Releases

bash
git tag -a v1.0 -m "Week 2 release"
git push origin v1.0              # Specific tag
git push origin --tags            # Lahat ng tags
Note: Ang tag ay hindi lumalabas sa default view ng GitHub repo. Nasa /tags URL siya.

📅 Day 2: Advanced Bash Scripting
Bakit Bash?
Bash ang lingua franca ng Linux automation. Kahit may Python, Ansible, o Terraform na, hindi mawawala ang Bash — lalo na para sa quick scripts at system administration.

Script 1: backup.sh
Purpose: Automated backup ng directory na may cleanup ng lumang backups.

Key Concepts:

$1 — First argument (source directory)

$(date +"%Y%m%d_%H%M%S") — Timestamp para sa unique filename

tar -czf — Create compressed archive

[ -z "$VAR" ] — Check kung empty

[ ! -d "$DIR" ] — Check kung hindi directory

$? — Exit code ng last command (0 = success)

ls -t | tail -n +6 | xargs -r rm — Keep 5 latest, delete the rest

Bakit useful: Sa production, kailangan mong mag-backup regularly. Hindi pwedeng manual. Automation ang sagot.

Script 2: user-manager.sh
Purpose: Create, delete, o list ng system users.

Key Concepts:

case statement — Para sa multiple conditions (mas malinis kaysa if-elif-else)

id "$USERNAME" &>/dev/null — Check kung existing user (&>/dev/null = suppress output)

sudo useradd -m -s /bin/bash — -m = create home directory, -s = shell

sudo userdel -r — Delete user at home directory

cut -d: -f1 /etc/passwd — Extract usernames from passwd file

Bakit useful: Sa onboarding ng bagong team member, kailangan mag-create ng user accounts. Pwede itong i-automate.

Script 3: disk-monitor.sh
Purpose: Monitor disk usage, mag-warning kapag above 80%.

Key Concepts:

df -h — Disk Free, human-readable (MB/GB instead of bytes)

awk 'NR==1 || /^\/dev/' — Print header at /dev lines lang

while read -r line — Loop through lines

printf — Formatted output

$(echo "$percent" | tr -d '%') — Remove % character

Bakit useful: Disk full = server down. Kailangan mo ng early warning system.

📅 Day 3: Linux Networking
Bakit Kailangan Mo ng Networking?
Sa DevOps, lahat ng server ay naka-network. Kailangan mong maintindihan:

Paano nag-uusap ang servers

Paano i-troubleshoot ang connection issues

Paano i-secure ang network

Core Commands
Interfaces:

ip addr — Modern replacement ng ifconfig. Ipinapakita lahat ng IP addresses.

ip link — Interface status (up/down)

ip route — Routing table (saan dadaan ang traffic)

DNS:

cat /etc/resolv.conf — DNS servers

dig google.com — Detailed DNS lookup

nslookup google.com — Simple version

host google.com — Pinaka-simple

Connectivity:

ping -c 4 8.8.8.8 — Test raw internet (bypass DNS)

ping -c 4 google.com — Test DNS + internet

traceroute google.com — Route path ng packets

curl -I https://google.com — HTTP headers lang

Ports:

ss -tuln — Listening ports (modern)

netstat -tuln — Legacy version

sudo lsof -i :22 — Sino gumagamit ng port 22?

Firewall:

sudo ufw status — Check status

sudo ufw enable — Enable

sudo ufw allow 22 — Allow SSH

sudo ufw allow 80 — Allow HTTP

Common Ports Table
Port	Service	Bakit
22	SSH	Remote login
80	HTTP	Web (unencrypted)
443	HTTPS	Web (encrypted)
3306	MySQL	Database
5432	PostgreSQL	Database
6379	Redis	Cache/Queue
27017	MongoDB	NoSQL
8080	HTTP Alt	Dev servers
DNS Troubleshooting Flow
Check config: cat /etc/resolv.conf

Test DNS: nslookup google.com

Test raw internet: ping -c 4 8.8.8.8

Analyze:

IP works, domain fails → DNS issue

Both fail → Network/Internet issue

Try another DNS: nslookup google.com 1.1.1.1

Flush cache: sudo systemd-resolve --flush-caches

📅 Day 4: Text Processing Mastery
Bakit Mahalaga ang grep/awk/sed sa DevOps?
Sa DevOps, lagi kang nakikipag-usap sa text:

Log files (milyon-milyong linya)

Config files

Output ng commands

CSV data

Hindi pwedeng basahin isa-isa. Kailangan mo ng tools para mag-extract ng insights.

GREP — Search Patterns
bash
grep "ERROR" file.log              # Find lines with ERROR
grep -c "ERROR" file.log           # Count
grep -i "error" file.log           # Case-insensitive
grep -v "INFO" file.log            # Exclude INFO
grep -E "(ERROR|WARN)" file.log    # Regex pattern
grep -n "ERROR" file.log           # With line numbers
grep "^J" file.txt                 # Lines starting with J
grep "0$" file.txt                 # Lines ending with 0
Use case: "Hanapin mo lahat ng ERROR sa log ng kahapon."

AWK — Column Processing
bash
awk -F, '{print $1}' file.csv                    # First column
awk -F, '$3 > 55000 {print $1, $3}' file.csv     # Filter by column 3
awk '{sum += $3} END {print sum}' file.txt       # Sum column
awk '/ERROR/ {print $1, $2}' file.log            # Specific lines
-F, = Field separator (comma)

$1, $2, $3 = Columns

END {} = Run after all lines processed

Use case: "Extract lahat ng usernames na may salary > 50000."

SED — Stream Editor
bash
sed 's/old/new/g' file.txt          # Replace all
sed -i 's/old/new/' file.txt        # In-place edit
sed -n '1,5p' file.txt              # Print lines 1-5
sed '2d' file.txt                    # Delete line 2
sed '/INFO/d' file.txt              # Delete lines with INFO
s/old/new/ = Substitute

g = Global (all occurrences)

-i = In-place (edit the file directly)

-n = Suppress automatic output

Use case: "Palitan lahat ng dev.server.com ng prod.server.com sa config."

Combination (PIPE)
bash
cat file.log | grep "ERROR" | awk '{print $1}' | sort | uniq -c
Ito yung tunay na power ng Linux. Kombinasyon ng tools.

📅 Day 5: Process & Service Management
Bakit Kailangan Mo?
Sa production, ang server ay tumatakbo ng maraming process. Kailangan mong:

Makita kung anong kumakain ng CPU/RAM

Patayin ang stuck processes

I-manage ang services (start, stop, restart)

Process Commands
bash
ps aux                                    # All processes
ps aux --sort=-%cpu | head -10            # Top CPU
ps aux --sort=-%mem | head -10            # Top Memory
kill -15 <PID>                            # Graceful terminate (SIGTERM)
kill -9 <PID>                             # Force kill (SIGKILL)
pkill -f "process_name"                   # Kill by name
Signals:

SIGTERM (15) — Graceful. "Tapusin mo yung ginagawa mo bago ka mag-exit."

SIGKILL (9) — Force. "Patayin ka ngayon din. Walang paliwanag."

Job Control
bash
sleep 300 &        # Run in background
jobs               # List background jobs
fg %1              # Bring job 1 to foreground
Ctrl+Z             # Suspend
bg %1              # Resume in background
Systemd Services (CRITICAL!)
Sa modern Linux, ang services ay mina-manage ng systemd.

bash
systemctl status ssh              # Check status
systemctl is-active ssh           # Active ba?
systemctl is-enabled ssh          # Enabled ba sa boot?
sudo systemctl start ssh          # Start
sudo systemctl stop ssh           # Stop
sudo systemctl restart ssh        # Restart
sudo systemctl enable ssh         # Enable on boot
sudo systemctl disable ssh        # Disable on boot
systemctl list-units --type=service   # List services
Custom Service
Gumawa ng /etc/systemd/system/myapp.service:

ini
[Unit]
Description=My DevOps App
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/devops-projects
ExecStart=/bin/bash /path/to/app.sh
Restart=always

[Install]
WantedBy=multi-user.target
Reload at start:

bash
sudo systemctl daemon-reload
sudo systemctl start myapp
sudo systemctl enable myapp
Bakit useful: Pwedeng mag-auto-restart kapag nag-crash. Production-grade reliability.

📅 Day 6: Capstone — setup-dev-env.sh
Ano Ito?
Isang master script na nag-a-automate ng buong dev environment setup.

What it does:

Update system (apt update && apt upgrade)

Install essential tools (curl, git, vim, htop, etc.)

Install Docker

Install kubectl

Configure Git

Create project structure

Setup firewall (UFW)

Display system summary

Key Concept: Idempotency
Yung script, safe to run multiple times. Hindi siya mag-du-double install ng packages.

bash
if ! command -v docker &> /dev/null; then
    # Install Docker
else
    echo "✅ Docker already installed"
fi
Bakit mahalaga: Sa DevOps, ang automation ay dapat idempotent — pwede mong i-run nang paulit-ulit, at same result pa rin.

set -e
bash
set -e  # Exit on error
Kapag may error, titigil agad yung script. Hindi na tutuloy sa susunod na commands.

🏆 Skills Summary
Technical Skills Learned
Category	Skills
Git	Branches, merge, conflict, stash, tags
Bash	Variables, loops, conditionals, functions, case, error handling
Networking	ip, ss, ping, traceroute, dig, ufw, ports
Text Processing	grep, awk, sed, pipes
Process	ps, kill, jobs, systemctl
Documentation	Markdown, README, blog posts
Soft Skills Learned
Automation mindset — Kung paulit-ulit, i-script mo.

Documentation habit — Yung notes mo, para sa future me.

Debugging patience — Basahin mo yung error message. Nasa details ang sagot.

Version control discipline — Commit often, descriptive messages.

⚠️ Challenges at Learnings
Challenge 1: Git Push Errors
rejected - fetch first — Kailangan mo munang git pull --rebase bago git push.

origin does not appear to be a git repository — Hindi pa naka-set yung remote.

Lesson: Basahin mo yung error message. Nasa loob ang sagot.

Challenge 2: Bash Syntax Quirks
[ -z "$VAR" ] vs [ "$VAR" = "" ] — pareho lang, pero -z mas malinis.

Yung $? ay exit code ng last command — kailangang i-check agad.

Lesson: Maraming quirks, pero sa practice, nagiging natural.

Challenge 3: Networking Concepts
Maraming protocols, ports, at commands.

Lesson: Hindi mo kailangan i-memorize lahat. Kailangan mo lang malaman saan hahanapin.

🎯 Ano ang Susunod (Week 3)
Planned Topics
Docker — Containerization, images, containers, Dockerfiles

CI/CD — GitHub Actions, automated testing

Cloud Basics — AWS/GCP fundamentals

Infrastructure as Code — Terraform

Expectations
Ang Week 3 ay game-changer. Matututo ako ng Docker, at makikita ko kung paano nag-wo-work ang containers sa production.

📝 Takeaways
Consistency beats intensity. 1-2 hours daily > 10 hours once a week.

Documentation is key. Yung notes ko, hindi lang para sa iba — para sa future me.

Failures are learning opportunities. Yung merge conflict na akala ko disaster, naging lesson.

Automation is the essence. Kung paulit-ulit, i-script mo.

Version control is a superpower. Every change, tracked. Every rollback, possible.





