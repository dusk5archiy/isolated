# Create WSL

Install

```bash
wsl --install -d archlinux --location I:/vm/archlinux
```

Use NAT in WSL:

Modify `C:\Users\<your_username>\.wslconfig` file:

```txt
[wsl2]
networkingMode=nat
```
