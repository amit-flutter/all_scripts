#!/bin/bash

echo "🚀 Git + SSH Multi-Account Setup"
echo "--------------------------------"

# 1️⃣ Ask inputs
read -p "🔑 Enter SSH key name (example: tibicle): " ACCOUNT_NAME
read -p "👤 Enter Git user name: " GIT_NAME
read -p "📧 Enter Git email: " GIT_EMAIL
read -p "📁 Enter base folder path (apply to all repos inside): " BASE_PATH

SSH_KEY="$HOME/.ssh/id_rsa_$ACCOUNT_NAME"
SSH_CONFIG="$HOME/.ssh/config"
GIT_CONFIG="$HOME/.gitconfig-$ACCOUNT_NAME"
GLOBAL_GITCONFIG="$HOME/.gitconfig"

echo ""
echo "🛠 Starting setup for account: $ACCOUNT_NAME"
echo "--------------------------------------------"

# 2️⃣ Create SSH key
if [ -f "$SSH_KEY" ]; then
  echo "⚠️ SSH key already exists: $SSH_KEY"
else
  echo "🔐 Creating SSH key..."
  ssh-keygen -t rsa -b 4096 -C "$GIT_EMAIL" -f "$SSH_KEY" -N ""
fi

# 3️⃣ Add SSH config
echo "🧩 Updating SSH config..."
mkdir -p ~/.ssh
touch "$SSH_CONFIG"

if ! grep -q "github-$ACCOUNT_NAME" "$SSH_CONFIG"; then
cat >> "$SSH_CONFIG" <<EOF

# $ACCOUNT_NAME Account
Host github-$ACCOUNT_NAME
    HostName github.com
    User git
    IdentityFile $SSH_KEY
    IdentitiesOnly yes
EOF
else
  echo "ℹ️ SSH config already contains github-$ACCOUNT_NAME"
fi

# 4️⃣ Create account-specific git config
echo "📝 Creating Git config: $GIT_CONFIG"
cat > "$GIT_CONFIG" <<EOF
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL

[core]
    sshCommand = ssh -i $SSH_KEY
EOF

# 5️⃣ Link folder-based Git config
echo "📂 Linking folder-based Git identity..."
touch "$GLOBAL_GITCONFIG"

if ! grep -q "$BASE_PATH" "$GLOBAL_GITCONFIG"; then
cat >> "$GLOBAL_GITCONFIG" <<EOF

[includeIf "gitdir:$BASE_PATH/"]
    path = $GIT_CONFIG
EOF
else
  echo "ℹ️ Folder already linked in global git config"
fi

# 6️⃣ Final output
echo ""
echo "✅ Setup completed successfully!"
echo "--------------------------------"
echo "📌 Use this SSH URL format when cloning:"
echo "👉 git@github-$ACCOUNT_NAME:ORG/REPO.git"
echo ""
echo "🔑 Your SSH Public Key (add this to GitHub):"
echo "--------------------------------------------"
cat "$SSH_KEY.pub"
echo ""
echo "🎉 All done! Happy coding 🚀"