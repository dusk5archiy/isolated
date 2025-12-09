read -p "Email: " email
mkdir -p $HOME/.ssh
ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519" -C "$email"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_ed25519
if [[ -x $(command -v -- clip) ]]; then
  cat $HOME/.ssh/id_ed25519.pub | clip
else
  cat $HOME/.ssh/id_ed25519.pub
fi
