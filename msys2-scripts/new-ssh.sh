read -p "Email: " email
mkdir -p $HOME/.ssh
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -C "$email"
