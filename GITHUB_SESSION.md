# Git & GitHub Session

Student handout — from first install to publishing a project.

**Course project:** Dental Recap (Flutter)

This document is a complete walkthrough for the GitHub session. Read it in order. First you learn what Git and GitHub are, then you install the tools, then you practice the commands, then you create a repository and publish a project.

---

## 1. What is Git? What is GitHub?

Git and GitHub are related but not the same thing. Students often mix them up. Keep this distinction clear:

- **Git** is a version control system that runs on your computer. It records snapshots of your files (commits) so you can go back in time, work on branches, and merge work.
- **GitHub** is a website ([github.com](https://github.com)) that hosts Git repositories in the cloud. It is where you publish projects, collaborate, open Pull Requests, and share code with the class or a teacher.
- **Analogy:** Git is like the camera that takes photos of your project. GitHub is like the album online where you store and share those photos.

You can use Git without GitHub (everything stays on your laptop). You cannot meaningfully use GitHub as a developer without Git on your machine.

---

## 2. Core ideas (learn these words first)

| Term | Meaning |
| --- | --- |
| Repository (repo) | A project folder tracked by Git. Contains files plus a hidden `.git` folder with history. |
| Working directory | The files you see and edit in VS Code / Cursor / Android Studio. |
| Staging area (index) | A waiting room. You choose which changes will go into the next snapshot. |
| Commit | A saved snapshot of staged files, with a message explaining why you changed them. |
| Branch | A line of work. `main` is the default. Feature branches keep experiments separate. |
| Remote | A copy of the repo on another machine or on GitHub. Usually named `origin`. |
| Clone | Download a full GitHub repo (files + history) to your computer. |
| Push | Upload your local commits to GitHub. |
| Pull | Download new commits from GitHub and merge them into your local branch. |
| Fetch | Download new commits from GitHub but do not merge yet. Safer inspection. |
| Merge | Combine one branch into another. |
| Pull Request (PR) | A GitHub request: “please review and merge my branch into `main`.” |
| `.gitignore` | A file that lists files Git should never track (build folders, secrets, `.env`). |
| `HEAD` | A pointer to the commit you currently have checked out. |

---

## 3. Before you start — accounts and install

### 3.1 Create a GitHub account

1. Go to [https://github.com](https://github.com) and sign up with your student email.
2. Verify the email GitHub sends you.
3. Optional but useful: enable two-factor authentication in **Settings → Password and authentication**.
4. Optional: apply for [GitHub Student Developer Pack](https://education.github.com) for extra benefits.

### 3.2 Install Git

**Windows (recommended for this class):**

1. Download Git for Windows from [https://git-scm.com/download/win](https://git-scm.com/download/win).
2. Run the installer. Keep the default editor or choose VS Code / Cursor.
3. Leave **Git from the command line and also from 3rd-party software** selected.
4. Finish the installer, then close and reopen the terminal.

Check that Git works:

```bash
git --version
```

You should see something like `git version 2.4x.x`.

### 3.3 Tell Git who you are (do this once per computer)

Every commit stores an author name and email. Use the same email as your GitHub account so commits appear as yours on the website.

```bash
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
git config --global -l
```

What these do:

- `user.name` — name shown on every commit.
- `user.email` — email shown on every commit (should match GitHub).
- `init.defaultBranch main` — new repos use `main` instead of the old name `master`.
- `-l` (list) — prints your current Git settings so you can check them.

### 3.4 Sign in from the computer (HTTPS vs SSH)

When you push to GitHub, GitHub must know it is you. Two common methods:

- **HTTPS + Personal Access Token (PAT):** GitHub no longer accepts your account password for `git push`. Create a token: GitHub → **Settings → Developer settings → Personal access tokens**. Use the token as the password when Git asks.
- **SSH keys (preferred for daily work):** generate a key, add the public key to GitHub, then push without typing a password each time.

Create an SSH key (Windows PowerShell or Git Bash):

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
# press Enter to accept the default file path
# set a passphrase (recommended) or leave empty
```

Print the public key (PowerShell):

```powershell
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub
```

Copy the printed public key (starts with `ssh-ed25519`). On GitHub: **Settings → SSH and GPG keys → New SSH key → paste → Save**.

Test the connection:

```bash
ssh -T git@github.com
```

First time, type `yes` to trust GitHub. Success looks like: `Hi USERNAME! You've successfully authenticated...`

---

## 4. The daily Git cycle (the most important picture)

Almost every day you will repeat this loop:

```text
1. Edit files in your editor
2. git status           → see what changed
3. git add ...          → stage the files you want to save
4. git commit -m "..."  → save a snapshot locally
5. git push             → publish that snapshot to GitHub
```

Remember: **commit** saves on **your computer**. **Push** publishes to **GitHub**. If you only commit and never push, the teacher cannot see your work online.

---

## 5. Command catalog — from beginning to end

Learn the left column by heart. The right column is what you should say out loud when someone asks “what does this do?”

### 5.1 Getting help and identity

| Command | What it does |
| --- | --- |
| `git --version` | Shows the installed Git version. Confirms Git is installed. |
| `git help <command>` | Opens documentation for a command, e.g. `git help commit`. |
| `git config --global user.name "Name"` | Sets your name for all repos on this computer. |
| `git config --global user.email "email"` | Sets your email for all repos on this computer. |
| `git config --global -l` | Lists global Git settings. |
| `git config user.name` | Shows the name Git will put on commits in this repo. |

### 5.2 Creating and copying repositories

| Command | What it does |
| --- | --- |
| `git init` | Turns the current folder into a new Git repository (creates `.git`). |
| `git init -b main` | Same as init, and names the first branch `main`. |
| `git clone <url>` | Copies a remote repo (files + full history) into a new folder. |
| `git clone <url> my-folder` | Clones into a folder name you choose. |

### 5.3 Seeing what is going on

| Command | What it does |
| --- | --- |
| `git status` | Shows branch name, staged files, unstaged files, and untracked files. Use this constantly. |
| `git status -sb` | Short status: branch plus a compact list of changed files. |
| `git log` | Shows commit history (messages, authors, dates). Press `q` to quit. |
| `git log --oneline` | One line per commit. Easy to read. |
| `git log --oneline --graph --all` | History as a graph, all branches. Great for explaining merges. |
| `git show` | Shows the latest commit: message plus the actual diff. |
| `git show <hash>` | Shows one specific commit. |
| `git diff` | Shows unstaged changes (working files vs staging area). |
| `git diff --staged` | Shows what is already staged and will go into the next commit. |
| `git diff main..feature` | Shows differences between two branches. |

### 5.4 Saving work (add, commit, restore)

| Command | What it does |
| --- | --- |
| `git add <file>` | Stages one file for the next commit. |
| `git add .` | Stages all changes in this folder and subfolders (respects `.gitignore`). |
| `git add -A` | Stages all changes in the whole repository, including deletions. |
| `git add -p` | Stage hunks interactively (advanced; pick pieces of a file). |
| `git commit -m "message"` | Creates a snapshot of staged files with a short message. |
| `git commit` | Opens an editor for a longer commit message. |
| `git commit --amend` | Adds extra staged changes into the **last** commit or edits its message. Only if you have not pushed yet. |
| `git rm <file>` | Deletes a tracked file and stages the deletion. |
| `git mv old new` | Renames or moves a tracked file and stages it. |
| `git restore <file>` | Discards unstaged edits in a file (back to last commit). Dangerous if you need those edits. |
| `git restore --staged <file>` | Unstages a file but keeps the edits in the working folder. |
| `git reset HEAD~1` | Undo the last commit, keep the file changes unstaged. Careful. |
| `git reset --hard HEAD~1` | Undo the last commit **and** throw away those changes. Very dangerous. |

### 5.5 Branches

| Command | What it does |
| --- | --- |
| `git branch` | Lists local branches. `*` marks the current one. |
| `git branch <name>` | Creates a new branch pointing at the current commit. Does not switch. |
| `git switch <name>` | Moves you onto an existing branch. |
| `git switch -c <name>` | Creates a new branch and switches to it (modern way). |
| `git checkout -b <name>` | Older equivalent of `git switch -c`. |
| `git checkout <name>` | Older way to switch branches. |
| `git merge <name>` | Brings commits from `<name>` into the branch you are on now. |
| `git branch -d <name>` | Deletes a fully merged local branch. |
| `git branch -D <name>` | Force-deletes a local branch even if not merged. |
| `git stash` | Temporarily shelves uncommitted work so you can switch branches cleanly. |
| `git stash pop` | Brings the stashed work back and removes it from the stash list. |
| `git stash list` | Shows saved stashes. |

### 5.6 Talking to GitHub (remotes)

| Command | What it does |
| --- | --- |
| `git remote -v` | Lists remote names and URLs (fetch and push). |
| `git remote add origin <url>` | Adds GitHub as a remote named `origin` (the usual first remote). |
| `git remote set-url origin <url>` | Changes the GitHub URL if you typed it wrong or switched HTTPS/SSH. |
| `git remote remove origin` | Removes the `origin` remote. |
| `git fetch` | Downloads new commits from GitHub without merging them. |
| `git fetch origin` | Same, but only from the remote named `origin`. |
| `git pull` | Fetch + merge the current branch’s remote tracking branch into your local branch. |
| `git pull origin main` | Fetch from origin and merge `origin/main` into the branch you are on. |
| `git push` | Uploads your local commits to the matching remote branch. |
| `git push -u origin main` | Pushes local `main` to origin and remembers the link (`-u` / upstream). |
| `git push origin <branch>` | Pushes a named branch to GitHub. |
| `git push -u origin HEAD` | Pushes the current branch and sets upstream. Handy on feature branches. |
| `git push origin --delete <branch>` | Deletes a branch on GitHub (not locally). |

### 5.7 Tags (versions / releases)

| Command | What it does |
| --- | --- |
| `git tag` | Lists tags (often version numbers like `v1.0.0`). |
| `git tag v1.0.0` | Creates a lightweight tag on the current commit. |
| `git tag -a v1.0.0 -m "First release"` | Creates an annotated tag with a message (better for releases). |
| `git push origin v1.0.0` | Publishes one tag to GitHub. |
| `git push origin --tags` | Publishes all local tags to GitHub. |

### 5.8 Ignoring files

| Command / file | What it does |
| --- | --- |
| `.gitignore` | Not a command. A text file Git reads to skip files (build output, keys, IDE junk). |
| `git check-ignore -v <file>` | Explains why a file is ignored (which rule matched). |
| `git rm --cached <file>` | Stops tracking a file that was committed by mistake, without deleting it from disk. |

Typical Flutter `.gitignore` already ignores `/build`, `.dart_tool`, and local IDE files. Never commit:

- `upload-keystore.jks`, `key.properties`, secrets
- `.env` files, API keys, passwords
- large generated folders

### 5.9 GitHub on the website (not terminal, but part of the session)

| Action on github.com | What it does |
| --- | --- |
| New repository | Creates an empty (or README-only) project on GitHub. |
| Add a README | Creates `README.md` so visitors know what the project is. |
| Add `.gitignore` | GitHub can offer a Flutter template when creating the repo. |
| Add a license | States how others may use the code (MIT, Apache, etc.). |
| Issues | A todo / bug list attached to the repo. |
| Pull requests | Review and merge a branch into `main` with discussion. |
| Releases | Named downloads of a version (often from a git tag). |
| Settings → Collaborators | Invite classmates or the teacher. |
| Settings → Pages | Optional: publish a website from the repo (useful for Flutter web later). |
| Fork | Copy someone else’s repo under your account so you can push to your copy. |
| Star / Watch | Bookmark a repo or get notifications. |

### 5.10 GitHub CLI (optional extra)

If students install [GitHub CLI](https://cli.github.com):

| Command | What it does |
| --- | --- |
| `gh auth login` | Logs the CLI into GitHub (browser or token). |
| `gh repo create` | Creates a GitHub repo from the current folder and can push it. |
| `gh repo view --web` | Opens the current repo in the browser. |
| `gh pr create` | Opens a Pull Request from the current branch. |
| `gh pr list` | Lists open Pull Requests. |
| `gh pr checkout 12` | Downloads PR number 12 as a local branch. |
| `gh issue create` | Creates an Issue from the terminal. |

---

## 6. Steps: create a repo and publish a project

There are two good classroom paths.

- **Path A** starts on GitHub (easier for beginners).
- **Path B** starts with an existing Flutter project on the laptop (this is the path for Dental Recap).

### Path A — Empty project: GitHub first, then clone

1. Sign in at [github.com](https://github.com).
2. Click the **+** menu (top right) → **New repository**.
3. Repository name: e.g. `dental_recap` or `flutter-lab-01`. Use letters, numbers, hyphens, underscores. No spaces.
4. Choose **Public** (anyone can see) or **Private** (only you and people you invite). For class homework, follow the teacher’s rule.
5. Check **Add a README file** so the repo is not completely empty.
6. Add **.gitignore** → template **Flutter** (recommended).
7. Optionally choose a license (MIT is common for class demos).
8. Click **Create repository**.
9. Click the green **Code** button. Copy the URL.
   - SSH: `git@github.com:USERNAME/REPO.git`
   - HTTPS: `https://github.com/USERNAME/REPO.git`
10. On the computer, open a terminal in the folder where you want the project (e.g. Documents).

```bash
git clone git@github.com:USERNAME/REPO.git
cd REPO
```

11. Open the folder in your editor and start coding.
12. When you have changes:

```bash
git status
git add .
git commit -m "Describe what you did"
git push
```

After the first successful push, refresh github.com — your files appear there. That is “published.”

### Path B — You already have a Flutter project (publish Dental Recap)

Use this when the app already exists on disk and GitHub does not have it yet.

#### Step 1 — Open a terminal in the project folder

```bash
cd "d:\flutter projects 2\dental_recap"
```

#### Step 2 — Confirm Git is tracking the project

```bash
git status
```

If you see “not a git repository”, initialize it. If you already see a branch name (`main`), skip `git init`.

```bash
git init -b main
```

#### Step 3 — Make sure `.gitignore` is present

Flutter projects created with `flutter create` already include `.gitignore`. Open it and confirm build folders are ignored. Do not add keystore files, passwords, or secret JSON if the teacher said those stay local.

#### Step 4 — Stage and commit locally

```bash
git status
git add .
git status
git commit -m "Initial commit: Flutter Dental Recap project"
```

Now the project is saved in Git on the laptop. It is **not** on GitHub yet.

#### Step 5 — Create the empty repo on GitHub

1. github.com → **+** → **New repository**.
2. Name it (example: `dental_recap`).
3. Do **not** add a README, `.gitignore`, or license this time — the project already has files. An extra README on GitHub would cause a merge conflict on the first pull.
4. Click **Create repository**.
5. GitHub will show commands. You will use the **existing repository** block.

#### Step 6 — Connect the local project to GitHub

SSH (recommended if you set up a key):

```bash
git remote add origin git@github.com:USERNAME/dental_recap.git
git remote -v
git push -u origin main
```

HTTPS (if you did not set up SSH):

```bash
git remote add origin https://github.com/USERNAME/dental_recap.git
git push -u origin main
```

If Git asks for credentials on HTTPS, username is your GitHub username, password is a **Personal Access Token**, not your GitHub login password.

`-u` (set upstream) means: from now on, `git push` and `git pull` on this branch know that `origin/main` is the partner branch.

#### Step 7 — Confirm it is published

1. Refresh the repository page on GitHub. You should see `lib/`, `pubspec.yaml`, README, etc.
2. The last commit message should match what you wrote.
3. Share the URL with the teacher: `https://github.com/USERNAME/dental_recap`

---

## 7. After it is published — everyday student workflow

Each work session:

```bash
git pull                  # get classmates'/teacher updates first
# ... write code, run the app, test ...
git status
git add .
git commit -m "Add login validation"
git push
```

Good commit message rules for the class:

- Write in the imperative: “Add login screen”, not “Added login screen” or “fixes”.
- Say why / what, not “update” or “changes”.
- Small commits are easier to review than one giant commit at the end of the week.

---

## 8. Working with branches (demo for the session)

Why branches: keep `main` stable. New features live on a side line until they work.

```bash
git switch -c feature/login-ui
# edit files
git add .
git commit -m "Add login form layout"
git push -u origin HEAD
```

On GitHub: you will see a yellow banner **Compare & pull request**. Click it, write a title, create the Pull Request. After review:

- On the website: **Merge pull request → Confirm merge**.
- Or in the terminal, after switching to `main`:

```bash
git switch main
git pull
git merge feature/login-ui
git push
git branch -d feature/login-ui
```

---

## 9. Cloning someone else’s published project

```bash
git clone git@github.com:USERNAME/dental_recap.git
cd dental_recap
flutter pub get
flutter run
```

Clone **once**. After that, use `git pull` to update. Do not clone again every day.

---

## 10. If GitHub already has a README and your laptop also has commits

GitHub may refuse the first push with “rejected — fetch first”. Students hit this when they created the GitHub repo with a README. Fix:

```bash
git pull origin main --rebase
git push -u origin main
```

If Git talks about unrelated histories:

```bash
git pull origin main --allow-unrelated-histories
# resolve any README conflict in the editor, then:
git add .
git commit -m "Merge GitHub README with local project"
git push -u origin main
```

---

## 11. Common classroom errors and what they mean

| What you see | What to do |
| --- | --- |
| not a git repository | `cd` into the project folder, or run `git init`. |
| Please tell me who you are | Run `git config --global user.name` and `user.email`. |
| Permission denied (publickey) | SSH key is missing or not added to GitHub. Test with `ssh -T git@github.com`. |
| Authentication failed (HTTPS) | Use a Personal Access Token, not your GitHub password. |
| failed to push, non-fast-forward | Someone else pushed first. `git pull` then `git push`. |
| Your branch is ahead of `origin/main` | You committed locally but did not push yet. Run `git push`. |
| Your branch is behind `origin/main` | GitHub has commits you do not have. Run `git pull`. |
| error: src refspec main | Your branch might be named `master`. `git branch` to check, then push that name. |
| fatal: remote origin already exists | Remote was added before. Use `git remote set-url origin <url>`. |
| file is ignored | It is listed in `.gitignore` on purpose. Do not force-add secrets. |
| MERGE CONFLICT | Two edits of the same lines. Open the file, keep the correct code, delete `<<<<<<<` `=======` `>>>>>>>`, then `git add` and `git commit`. |

---

## 12. Commands you should NOT use in class unless the teacher says so

- `git push --force` / `git push -f` — rewrites history on GitHub and can erase classmates’ work.
- `git reset --hard` — permanently throws away uncommitted (and sometimes committed) work.
- Never commit passwords, keystores, or private API keys, even in a private repo if the teacher asked you not to.

---

## 13. Suggested live demo order (for the instructor)

1. Show github.com vs a local folder. Draw: Working directory → Staging → Commit → Push.
2. `git --version`, then config name/email.
3. Create a tiny folder, `git init`, create a file, `git status`, `git add`, `git commit`, `git log`.
4. Create a GitHub repo, `git remote add origin`, `git push -u origin main`. Refresh the website.
5. Edit a file, commit, push again. Show the new commit on GitHub.
6. `git switch -c feature/hello`, change README, push, open a Pull Request, merge it.
7. On another computer (or a second folder): `git clone`, prove the files arrived.
8. Optional: show Issues and the Flutter `.gitignore`.

---

## 14. One-page cheat sheet (print this)

```bash
# identity (once)
git config --global user.name "Your Name"
git config --global user.email "you@school.edu"

# new local repo
git init -b main
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:USER/REPO.git
git push -u origin main

# copy an existing GitHub project
git clone git@github.com:USER/REPO.git

# every day
git pull
git status
git add .
git commit -m "Short clear message"
git push

# branches
git switch -c feature/name
git push -u origin HEAD
git switch main
git merge feature/name

# inspect
git log --oneline
git diff
git remote -v
```

---

## 15. How this maps to Dental Recap

This repository is already a Git project. Publishing it means: create a repository on GitHub under the student or organization account, add `origin`, and `git push -u origin main` (or the current branch name). After that, every feature (auth, tweets, tests) should be committed with a clear message and pushed so the teacher can open the GitHub URL and see the history.

**End of session goal for each student:** a public or private GitHub URL that opens their project, at least one commit they wrote, and the ability to explain `status` → `add` → `commit` → `push` in their own words.

---

Commands assume Git 2.23+ (`git switch`). Older Git uses `git checkout -b` instead of `git switch -c`.
