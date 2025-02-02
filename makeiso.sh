if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi

rm -rf rootfs_iso/*
rm -r iso/files
rm -r iso/progs

# Создание папок и добавление всех файлов
mkdir rootfs_iso
cp -r rootfs/* rootfs_iso/

mkdir iso/files iso/progs
cp -r additional_files/* iso/files/
cp -r progs/binary_files/* iso/progs

# Добавление скрипта инициализации
cp iso/init rootfs_iso/

# Присваивание прав на папку rootfs root-пользователю
# Иначе не будет грузиться при запуске
chown -R root:root rootfs_iso/

# Генерация initrd
cd rootfs_iso
find . -path "./src" -prune -o -print0 | cpio --null -H newc -o > ../iso/boot/initrd
cd ..

# Генерация iso файла
genisoimage -o ctOS.iso -b isolinux/isolinux.bin \
-c isolinux/boot.cat -no-emul-boot -boot-load-size 4 \
-boot-info-table -J -R -V "ctOS" iso/
