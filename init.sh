echo "[BUILD]: UMOUNT boot.img..."
sudo umount mounted/
echo "[BUILD]: RM boot.img..."
rm boot.img
echo "[BUILD]: CREATE NEW boot.img..."
truncate -s 1GB boot.img
chmod 777 boot.img
echo "[BUILD]: CREATE NEW mounted dir"
mkdir mounted
echo "[BUILD]: CREATE FILESYSTEM..."
sudo mkfs boot.img
echo "[BUILD]: MOUNT boot.img TO mounted/ ..."
sudo mount boot.img mounted/
echo "[BUILD]: INSTALLING SYSLINUX BOOTLOADER..."
sudo extlinux --install mounted/
