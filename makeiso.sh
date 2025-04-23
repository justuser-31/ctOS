if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi
shopt -s expand_aliases
alias rt="$(pwd)/rtracker"

rt "[BUILD]: MAKE full rootfs..." \
	%t ./make_rootfs.sh
# Присваивание прав на папку rootfs root-пользователю
# Иначе не будет грузиться при запуске
#chown -R root:root rootfs_iso/
rt "[BUILD]: CHANGE owner of rootfs_iso to root..." \
	%% chown -R root:root rootfs_iso/
rt "[BUILD]: CP rootfs..." \
	%% cp -r rootfs_full/* iso/

cd rootfs_iso
rt "[BUILD]: GENERATE initrd..." \
	%% find . -path "./src" -prune -o -print0 | cpio --null -H newc -o > ../iso/boot/initrd
cd ..

# Генерация iso файла
rt "[BUILD]: GENERATE iso..." \
	%% genisoimage -quiet -o ctOS.iso -b isolinux/isolinux.bin \
	-c isolinux/boot.cat -no-emul-boot -boot-load-size 4 \
	-boot-info-table -J -R -V 'ctOS' iso/

# Сделать iso возможным для записи на флешку
# Пока не уверен, что работает
rt "[BUILD]: MAKE bootable..." \
	%% isohybrid ctOS.iso

# Вернуть права
user=${SUDO_USER:-$(whoami)}
rt "[BUILD]: CHANGE owner of rootfs_iso back..." \
	%%  chown -R $user:$user rootfs_iso/; \
	chown $user:$user rootfs_iso/
