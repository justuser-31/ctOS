echo "[BUILD]: MOUNT boot.img TO mounted/ ..."
sudo mount boot.img mounted/
echo "[BUILD]: RM boot_backup.img..."
rm boot_backup.img
echo "[BUILD]: BACKUP boot.img..."
cp boot.img boot_backup.img
echo "[BUILD]: RM old files"
sudo find mounted/ ! -name 'mounted' ! -name 'lost+found' ! -name 'ldlinux.sys' ! -name 'ldlinux.c32' -delete
echo "[BUILD]: CREATE ADDITIONAL DIRECTORIES..."
sudo mkdir mounted/files mounted/progs
echo "[BUILD]: COPY ROOTFS TO mounted/..."
sudo cp -r rootfs/* mounted/
echo "[BUILD]: COPY ADDITIONAL_FILES TO mounted/files/..."
sudo cp -r additional_files/* mounted/files/
echo "[BUILD]: COPY PROGS TO mounted/progs/..."
sudo cp -r progs/binary_files/* mounted/progs
echo "[BUILD]: COPY SYSLINUX TO mounted/..."
sudo cp -r syslinux mounted/
sudo chmod -R 777 mounted/syslinux/
sudo chmod 777 mounted/syslinux/
