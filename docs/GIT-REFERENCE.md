# 🌿 Git Reference Guide

Complete guide sa Git commands na natutunan ko sa Week 1-2.

---

## 🔧 Setup (Once Lang)

```bash
git config --global user.name "Juan Dela Cruz"
git config --global user.email "juan@email.com"
git config --global init.defaultBranch main
git config --global core.editor nano
📦 Basic Workflow
bash
git init                       # Gawing git repo yung folder
git add .                      # I-stage lahat
git add file.txt               # I-stage specific file
git commit -m "message"        # I-commit
git push                       # I-push sa remote
git pull                       # I-pull from remote
git status                     # Anong state ng repo?
🌿 Branching
bash
git branch                     # List branches
git branch feature-1           # Gumawa (hindi lilipat)
git checkout -b feature-1      # Gumawa at lumipat
git switch feature-1           # Modern version ng checkout
git checkout main              # Lumipat sa main
git branch -d feature-1        # Delete branch
git branch -D feature-1        # Force delete
🔀 Merging
bash
git merge feature-1            # I-merge si feature-1 sa current
git merge --no-ff feature-1    # Always gumawa ng merge commit
git merge --abort              # Cancel merge kung may conflict
⚔️ Conflict Resolution
Kapag may conflict, lalabas sa file:

text
<<<<<<< HEAD
Yung laman mo
=======
Yung laman nila
>>>>>>> feature-b
Fix:

Edit yung file, pumili o pagsamahin

Alisin yung markers

git add conflict.txt

git commit -m "Resolve merge conflict"

📚 History
bash
git log                              # Detailed
git log --oneline                    # Compact
git log --oneline --graph            # With branches
git log --oneline --graph --all      # Kasama lahat ng branches
git show <commit-hash>               # Tingnan specific commit
git diff main feature-b              # Compare branches
git diff HEAD~1 HEAD                 # Compare sa prev commit
💾 Stashing
bash
git stash                     # Itago changes
git stash list                # List stashes
git stash pop                 # Ibalik at delete
git stash apply               # Ibalik pero keep sa list
git stash drop                # Delete stash
🏷️ Tagging
bash
git tag                              # List tags
git tag v1.0                         # Lightweight tag
git tag -a v1.0 -m "message"         # Annotated tag
git show v1.0                        # Tingnan tag
git push origin v1.0                 # Push specific tag
git push origin --tags               # Push lahat ng tags
git tag -d v1.0                      # Delete local
git push origin :refs/tags/v1.0      # Delete remote
Note: Tags ay hindi lumalabas sa default view ng GitHub. Nasa /tags URL.

🔙 Undo
bash
git checkout -- file.txt              # Discard changes (dangerous)
git reset HEAD file.txt               # Unstage file
git reset --soft HEAD~1               # Undo last commit, keep changes
git reset --hard HEAD~1               # Undo last commit, discard changes
git revert <commit-hash>              # Gumawa ng new commit na nagbabalik ng changes
Rule of thumb:

Local lang → git reset pwede

Naka-push na → git revert (safe, may history)

🌐 Remote
bash
git remote -v                                  # Tingnan remotes
git remote add origin <URL>                    # Add remote
git remote set-url origin <NEW-URL>            # Change URL
git remote remove origin                       # Remove remote
git push -u origin main                        # Push with tracking
git push origin main                           # Push specific branch
git push --force-with-lease origin main        # Force push (safer version)
🐛 Common Errors at Fixes
Error	Fix
fatal: not a git repository	git init muna
Permission denied (publickey)	Check SSH: ssh -T git@github.com
failed to push - fetch first	git pull --rebase origin main muna
'origin' does not appear to be a git repository	git remote add origin <URL>
Please tell me who you are	git config --global user.name/email
CONFLICT (content): Merge conflict in file	Edit file, then git add at git commit
💡 Best Practices
Commit often — Maliliit na commits, hindi malalaking "kitchen sink".

Descriptive messages — "Fix login bug" hindi "update".

Present tense — "Add feature" hindi "Added feature".

Pull before push — Iwas conflicts.

Use branches — Wag direkta sa main.

Review before commit — git diff at git status.

Never commit secrets — API keys, passwords.

.gitignore — Iwas commit ng node_modules/, *.log, .env.

📋 Git Workflow Cheat Sheet
bash
# NEW PROJECT
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:USER/REPO.git
git push -u origin main

# DAILY WORK
git pull                       # Get latest
nano file.txt                  # Edit
git add .
git commit -m "Description"
git push

# FEATURE BRANCH
git checkout -b feature-x
# ... do work ...
git add .
git commit -m "Add feature X"
git checkout main
git pull
git merge feature-x
git push

# RELEASE
git tag -a v1.0 -m "Release 1.0"
git push origin --tags
