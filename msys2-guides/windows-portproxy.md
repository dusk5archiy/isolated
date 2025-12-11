# Windows Portproxy

```cmd
netsh interface portproxy add v4tov4 listenport=192.168.137.1 listenport=53 connectaddress=192.168.138.102 connectport=53
