# Isolated

- Install MSYS2.

- Download this repo (assume that the root folder of this repo is `$ISOLATED_DIR`).

- Change the content of the file `$ISOLATED_DIR/SETUP/MSYS2_DIR.txt` into the MSYS2 installation folder.

- Run `$ISOLATED_DIR/setup-msys2.cmd`, then `$ISOLATED_DIR/open-msys2.cmd` to open a MSYS2 shell.

- In the terminal, run these commands to install the essential packages:

```bash
pacman -Syu         # Getting the latest updates, run this TWICE
msys2-packages.sh   # Install essential packages, this script is from $ISOLATED_DIR/msys2-scripts
```

- Close the terminal.

- Run `$ISOLATED_DIR/wezterm-activate-env-run-as-admin.cmd` with admin rights.

- Open `$ISOLATED_DIR/wezterm.cmd`. When a Wezterm window opens, pin the window to the taskbar.
Next time, you just need to click the icon on the taskbar in order to open the environment.

After that, you may do more things like:

Install VSCode

```bash
install-vscode.sh   # This script is from $ISOLATED_DIR/msys2-scripts
code                # Open VSCode
```

Install Lazyvim:

```bash
install-lazyvim.sh  # This script is from $ISOLATED_DIR/msys2-scripts
nvim                # To continue in-app installation
```

Create SSH keys (for Github):

```bash
# These scripts are all from $ISOLATED_DIR/msys2-scripts
new-ssh.sh          # Create a new SSH key
copy-ssh.sh         # Copy the public key to the clipboard
```

To have an automatic background that changes every day, install **Bing Wallpaper**.
Check the `$ISOLATED_DIR/auto-scripts/wezterm-background.sh` file for more investigation.
