# Create WSL

Install

```bash
wsl --install -d Ubuntu --location I:/vm/wsl-ubuntu --name wsl-ubuntu
```

Open

```bash
wsl -d wsl-ubuntu
```

Use NAT in WSL:

Modify `C:\Users\<your_username>\.wslconfig` file:

```txt
[wsl2]
networkingMode=nat
```

Import

```bash
wsl --import wsl-ubuntu I:/vm/wsl-ubuntu I:/vm/wsl-ubuntu.vhdx --vhd
```

Export

```bash
wsl --export wsl-ubuntu I:/vm/wsl-ubuntu.vhdx --vhd
```
