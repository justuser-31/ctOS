echo "[BUILD]: UMOUNT boot.img..."
sudo umount -l mounted/
echo "[BUILD]: RM boot_backup.img..."
rm boot_backup.img
echo "[BUILD]: BACKUP boot.img..."
cp boot.img boot_backup.img
echo "[BUILD]: RM boot.img..."
rm boot.img
echo "[BUILD]: CREATE NEW boot.img..."
truncate -s 1GB boot.img
echo "[BUILD]: CREATE FILESYSTEM..."
sudo mkfs boot.img
echo "[BUILD]: MOUNT boot.img TO mounted/ ..."
sudo mount boot.img mounted/
echo "[BUILD]: INSTALLING LINUX KERNEL..."
sudo extlinux --install mounted/
echo "[BUILD]: CREATE ADDITIONAL DIRECTORIES..."
sudo mkdir mounted/files mounted/progs
echo "[BUILD]: COPY ROOTFS TO mounted/..."
sudo cp -r rootfs/* mounted/
echo "[BUILD]: COPY ADDITIONAL_FILES TO mounted/files/..."
sudo cp -r additional_files/* mounted/files/
echo "[BUILD]: COPY PROGS TO mounted/progs/..."
sudo cp -r progs/binary_files/* mounted/progs