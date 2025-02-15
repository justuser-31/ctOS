if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi
shopt -s expand_aliases
alias rt="./run_tracker/rtracker"

rt "[BUILD]: MOUNT boot.img TO mounted/..." \
	%t mount boot.img mounted/
rt "[BUILD]: RM boot_backup.img..." \
	%t rm boot_backup.img
rt "[BUILD]: BACKUP boot.img..." \
	%% cp boot.img boot_backup.img
rt "[BUILD]: RM old files" \
	%% find mounted/ ! -name 'mounted' ! -name 'lost+found' ! -name 'ldlinux.sys' ! -name 'ldlinux.c32' -delete
rt "[BUILD]: MAKE full rootfs..." \
	%% ./make_rootfs.sh
rt "[BUILD]: COPY rootfs in drive..." \
	%% cp -r rootfs_full/* mounted/
rt "[BUILD]: COPY SYSLINUX TO mounted/..." \
	%% cp -r syslinux mounted/
#chmod -R 777 mounted/syslinux/
#chmod 777 mounted/syslinux/
# А нужно ли это?
