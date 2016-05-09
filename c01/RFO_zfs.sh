apt-get install -y zfsutils-linux zfs-initramfs
# ZFS pool en mirror sobre /dev/sd{a,b}3
zpool create zpool1 -O compression=lz4 mirror /dev/sda3 /dev/sdb3

# Ya tenemos un pool para las instancias de openstack, lo ab-usamos
# para crear otro FS para mover algunos LXCs
zfs create -o mountpoint=/srv/nova/instances zpool1/nova
zfs create -o mountpoint=/srv/lxc -o recordsize=16k zpool1/lxc


# Movemos el LXC_NAME que hostea a mysql DB
lxc-stop -n $LXC_NAME
mv /var/lib/lxc/$LXC_NAME /srv/lxc/$LXC_NAME
ln -s /srv/lxc/$LXC_NAME /var/lib/lxc
lxc-start -n $LXC_NAME
