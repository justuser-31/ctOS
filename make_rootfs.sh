if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi
shopt -s expand_aliases
alias rt="./rtracker"

rt "[BUILD]: RM old rootfs..." \
	%t rm -rf rootfs_full
rt "[BUILD]: MK rootfs_full..."\
	%% mkdir -p rootfs_full/progs
rt "[BUILD]: CP rootfs..." \
	%% cp -r rootfs/* rootfs_full
rt "[BUILD]: CP progs..." \
	%% cp -r progs/binary_files/* rootfs_full/progs/
rt "[BUILD]: CP additional files..." \
	%% cp -r additional_files/*/* rootfs_full/
rt "[BUILD]: CP packages into rootfs_full..." \
	%% cp -rf packages rootfs_full/packages
rt "[BUILD]: INSTALL packages..." \
	%% chroot ./rootfs_full packages/prepare_rootfs.sh

