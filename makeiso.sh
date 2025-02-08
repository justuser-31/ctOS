if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

echo "[BUILD]: MAKE full rootfs..."
./make_rootfs.sh

# Присваивание прав на папку rootfs root-пользователю
# Иначе не будет грузиться при запуске
chown -R root:root rootfs_iso/

echo "[BUILD]: CP rootfs..."
cp -r rootfs_full/* iso/

echo "[BUILD]: GENERATE initrd..."
# Генерация initrd
cd rootfs_iso
find . -path "./src" -prune -o -print0 | cpio --null -H newc -o > ../iso/boot/initrd
cd ..

echo "[BUILD]: GENERATE iso..."
# Генерация iso файла
genisoimage -o ctOS.iso -b isolinux/isolinux.bin \
-c isolinux/boot.cat -no-emul-boot -boot-load-size 4 \
-boot-info-table -J -R -V "ctOS" iso/

echo "[BUILD]: MAKE bootable..."
# Сделать iso возможным для записи на флешку
# Пока не уверен, что работает
isohybrid ctOS.iso

# Вернуть права
user=${SUDO_USER:-$(whoami)}

chown -R $user:$user rootfs_iso/
chown $user:$user rootfs_iso/
