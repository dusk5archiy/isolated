# Create VHDX

```cmd
diskpart
create vdisk file="I:\vm\Ubuntu.vhdx" maximum=128000 type=expandable
```

Attach the virtual disk

```cmd
select vdisk file="I:\vm\Ubuntu.vhdx"
attach vdisk
```
