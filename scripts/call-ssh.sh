read -p "Address: " addr
ssh -i ~/.ssh/id_ed25519 -o UserKnownHostsFile=~/.ssh/known_hosts $addr
