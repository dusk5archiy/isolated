# Create VHDX

```cmd
diskpart
create vdisk file="I:\vm\Ubuntu.vhdx" maximum=128000 type=expandable
```

(or `type=fixed`)

Attach the virtual disk

```cmd
select vdisk file="I:\vm\Ubuntu.vhdx"
attach vdisk
```
