#!/bin/sh

# /dev/nvme0n1p1 efi partition
# /dev/nvme0n1p2 swap partition
# /dev/nvme0n1p3 btrfs root partition, with subvolumes for all the things

mount -o relatime,space_cache=v2,ssd,compress=zstd,subvol=@ /dev/nvme0n1p3 /mnt
mount -o relatime,space_cache=v2,ssd,compress=zstd,subvol=@log /dev/nvme0n1p3 /mnt/var/log
mount -o relatime,space_cache=v2,ssd,compress=zstd,subvol=@pkg /dev/nvme0n1p3 /mnt/var/cache/pacman/pkg
mount -o relatime,space_cache=v2,ssd,compress=zstd,subvol=@tmp /dev/nvme0n1p3 /mnt/tmp
mount -o relatime,space_cache=v2,ssd,compress=zstd,subvol=@home /dev/nvme0n1p3 /mnt/home
mount -o relatime,space_cache=v2,ssd,compress=zstd,subvolid=5 /dev/nvme0n1p3 /mnt/btrfs
mount /dev/nvme0n1p1 /mnt/boot/efi

echo done
