read -p "Email: " email
mkdir -p $HOME/.ssh
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -C "$email"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_ed25519
cat $HOME/.ssh/id_ed25519.pub | clip
