#!/bin/bash

# set +e # Continue to run even if any commands fails
# set -e # Exit if one of the commands fails

set -e
(
  set -e
  pacman -Syu --noconfirm # Update the package manager
  # Install necessary packages
  ## sudo: to let users run lower-level commands
  ## vim: a text editor
  pacman -S --noconfirm \
    sudo vim less which
  # Make sure that every users of group wheel can run sudo without passwords
)
(
  sed -i '/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers # Basically, this command below is to uncomment a line.
  set +e
  read -p "Set up new username: " username_
  read -s -p "Set up new password: " password_ # -s tag to hide the entry
  echo ""
  echo "root:$password_" | chpasswd
  useradd -m -G wheel $username_ # create a user of group named 'wheel'
  echo "$username_:$password_" | chpasswd
  # set up default user and avoid appending windows paths
  # [interop]
  # appendWindowsPath=false
  cat <<EOF >/etc/wsl.conf
[boot]
systemd=true

[user]
default=$username_
EOF

  localedef -i en_US -f UTF-8 en_US.UTF-8 # create locale files
)

echo "=== NOTICE ==="
echo "Run 'exit', then 'wsl --shutdown' to shut down wsl, then run 'wsl' to start wsl again."
