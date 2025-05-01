if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi
shopt -s expand_aliases
alias rt="$(pwd)/rtracker"

rt "[BUILD]: COPY kernel to boot..." \
	%% cp rootfs/bzImage isofiles/boot/bzImage
rt "[BUILD]: MAKE full rootfs..." \
	%t ./make_rootfs.sh
rt "[BUILD]: RM old rootfs..." \
	%t rm -r isofiles/rootfs
rt "[BUILD]: MKDIR rootfs..." \
	%% mkdir isofiles/rootfs
rt "[BUILD]: COPY rootfs..." \
	%% cp -r rootfs_full/* isofiles/rootfs/
rt "[BUILD]: COPY init script to rootfs..." \
	%% cp isofiles/init rootfs/init

cd rootfs
rt "[BUILD]: GENERATE initrd.img..." \
	%% 'find . | cpio -o -H newc | gzip -c > ../isofiles/boot/initrd.img'
cd ../

rt "[BUILD]: RM init script in rootfs..." \
	%% rm rootfs/init
rt "[BUILD]: GENERATE iso..." \
	%% grub-mkrescue -o ctOS.iso isofiles/
