# 🚀 Git Automation Scripts

A growing collection of shell scripts to automate Git and SSH workflows, especially useful when working with **multiple Git accounts** (personal, company, client).

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Why This Repository](#-why-this-repository)
- [Scripts](#-scripts)
    - [setup-git-ssh-interactive.sh](#1-setup-git-ssh-interactivesh)
- [How to Use](#-how-to-use)
- [Folder Structure](#-folder-structure)
- [Future Scripts](#-future-scripts)
- [Author](#-author)

---

## 📖 Overview

Managing multiple Git accounts can quickly become confusing and error-prone.  
This repository provides **interactive, reusable scripts** to standardize Git + SSH configuration across different projects and accounts.

---

## ❓ Why This Repository

This repo helps you:

- 🔐 Manage multiple SSH keys cleanly
- 🧠 Automatically switch Git identity by folder
- ⚙️ Avoid repetitive Git configuration
- 🚀 Onboard new projects faster
- 📁 Keep everything organized in one place

---

## 🧰 Scripts

### 1️⃣ setup-git-ssh-interactive.sh

**Purpose:**  
Interactive setup for Git + SSH account configuration.

| Item | Details |
|-----|--------|
| Script Name | `setup-git-ssh-interactive.sh` |
| Type | Bash (Interactive) |
| Use Case | Multiple GitHub accounts |
| Supports | Folder-based Git identity |

---

### 🔍 What this script does

- Prompts for:
    - SSH key name
    - Git username
    - Git email
    - Folder path for applying the account
- Generates SSH key (if not already present)
- Updates `~/.ssh/config`
- Creates account-specific Git config
- Links Git config using `includeIf`
- Prints SSH public key for GitHub

---

### ▶️ How to Run

```bash
chmod +x setup-git-ssh-interactive.sh
./setup-git-ssh-interactive.sh