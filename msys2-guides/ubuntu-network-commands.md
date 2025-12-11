# Ubuntu Network Commands

Show IP Address

```bash
ip a
```

Enable interface

```bash
sudo ip link set "<interface-name>" up
```

Run dhcp

```bash
sudo dhcpcd
```

Configure network settings

```bash
sudo vim /etc/netplan/...
```

```txt
network:
  ethernets:
    eth0:
      dhcp4: true
      dhcp6: true
      match:
        macaddress: 00:15:5d:38:01:08
      set-name: eth0
    eth1:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.138.102/24
      routes:
        - to: default
          via: 192.168.138.1
  version: 2
```

Apply changes

```bash
sudo netplan apply
```
