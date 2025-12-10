# Ubuntu Server DNS Server

```bash
sudo apt install bind9
```

Example: Convert `itworks.sao` to `192.168.101.102`.

Open `/etc/bind/named.conf.local` with a text editor, then replace the content of the file by:

```txt
zone "itworks.sao" {
        type master;
        file "/etc/bind/zones/db.itworks.sao";
};
```

Create `/etc/bind/zones/db.itworks.sao` and write:

```txt
$TTL    604800
@       IN      SOA     itworks.sao. admin.itworks.sao. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      itworks.sao.
@       IN      A       192.168.101.102
```

Restart bind9:

```bash
sudo named-checkconf
sudo systemctl restart bind9
```
