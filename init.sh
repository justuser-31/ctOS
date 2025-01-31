echo "[INIT]: UMOUNT boot.img..."
sudo umount mounted/
echo "[INIT]: RM boot.img..."
rm boot.img
echo "[INIT]: CREATE NEW boot.img..."
truncate -s 1GB boot.img
chmod 777 boot.img
echo "[INIT]: CREATE NEW mounted dir"
mkdir mounted
echo "[INIT]: CREATE FILESYSTEM..."
sudo mkfs boot.img
echo "[INIT]: MOUNT boot.img TO mounted/ ..."
sudo mount boot.img mounted/
echo "[INIT]: INSTALLING SYSLINUX BOOTLOADER..."
sudo extlinux --install mounted/
