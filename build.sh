if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

echo "[BUILD]: MOUNT boot.img TO mounted/..."
mount boot.img mounted/
echo "[BUILD]: RM boot_backup.img..."
rm boot_backup.img
echo "[BUILD]: BACKUP boot.img..."
cp boot.img boot_backup.img
echo "[BUILD]: RM old files"
find mounted/ ! -name 'mounted' ! -name 'lost+found' ! -name 'ldlinux.sys' ! -name 'ldlinux.c32' -delete
echo "[BUILD]: MAKE full rootfs..."
./make_rootfs.sh
echo "[BUILD]: COPY rootfs..."
cp -r rootfs_full/* mounted/
echo "[BUILD]: COPY SYSLINUX TO mounted/..."
cp -r syslinux mounted/
chmod -R 777 mounted/syslinux/
chmod 777 mounted/syslinux/
