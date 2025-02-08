if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

echo "[BUILD]: MOUNT boot.img TO mounted/ ..."
mount boot.img mounted/
echo "[BUILD]: RM boot_backup.img..."
rm boot_backup.img
echo "[BUILD]: BACKUP boot.img..."
cp boot.img boot_backup.img
echo "[BUILD]: RM old files"
find mounted/ ! -name 'mounted' ! -name 'lost+found' ! -name 'ldlinux.sys' ! -name 'ldlinux.c32' -delete
echo "[BUILD]: CREATE ADDITIONAL DIRECTORIES..."
mkdir mounted/files mounted/progs
echo "[BUILD]: COPY ROOTFS TO mounted/..."
cp -r rootfs/* mounted/
echo "[BUILD]: COPY ADDITIONAL_FILES TO mounted/files/..."
cp -r additional_files/* mounted/files/
echo "[BUILD]: COPY PROGS TO mounted/progs/..."
cp -r progs/binary_files/* mounted/progs
echo "[BUILD]: COPY SYSLINUX TO mounted/..."
cp -r syslinux mounted/
chmod -R 777 mounted/syslinux/
chmod 777 mounted/syslinux/
