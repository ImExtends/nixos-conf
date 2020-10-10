#!/bin/sh
#should be executed by root, try sudo -i

sgdisk --zap-all /dev/sda #zap your datas
SDA_ID="$(ls /dev/disk/by-id/ | grep '^[ata]')"
DISK=/dev/disk/by-id/$SDA_ID

function partitionning() {
	sgdisk -n 0:0:+1GiB -t 0:EF00 -c 0:boot $DISK #EFI partition
	sgdisk -n 0:0:+8GiB -t 0:8200 -c 0:swap $DISK #Swap partition
	sgdisk -n 0:0:0 -t 0:BF01 -c 0:ZFS $DISK #Main partition
}

BOOT=$DISK-part1
SWAP=$DISK-part2
ZFS=$DISK-part3

function pool() {
	zpool create -o ashift=12 -o altroot="/mnt" -O mountpoint=none -O encryption=aes-256-gcm -O keyformat=passphrase rpool $ZFS
	zfs create -o mountpoint=none rpool/nixos
	zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=true rpool/nixos/home
	zfs set compression=lz4 rpool/nixos/home
	zfs create -o mountpoint=legacy rpool/nixos/root
	zfs create -o mountpoint=legacy rpool/store
	zfs create -o mountpoint=legacy rpool/store/nix
}

function mounting(){
	mount -t zfs rpool/nixos/root /mnt
	mkdir /mnt/{home,nix}
	mount -t zfs rpool/nixos/home /mnt/home
	mount -t zfs rpool/store/nix /mnt/nix
}

function format() {
	mkfs.vfat $BOOT
	mkdir -p /mnt/boot
	mount $BOOT /mnt/boot

	mkswap -L swap $SWAP
}

HOST_ID=$(head -c 8 /etc/machine-id)

function nix-rel() {
	nix build github:ImExtends/etc-nixos\#sigma
	nixos-install --root /mnt --system ./result
}

partitionning
pool
mounting
format
nix-rel
