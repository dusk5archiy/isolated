sudo apt update
sudo apt upgrade
cat <<EOF >/etc/wsl.conf
[boot]
systemd=true

[user]
default=$USER

[interop]
appendWindowsPath=false
EOF
# Then restart wsl
exit
# (Outside WSL)
# wsl --shutdown
# wsl -d Ubuntu
