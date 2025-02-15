if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo."
    exit 1
fi
shopt -s expand_aliases
alias rt="./run_tracker/rtracker"

rt "[INIT]: UMOUNT boot.img..." \
	%t umount mounted/
rt "[INIT]: RM boot.img..." \
	%t rm boot.img
rt "[INIT]: CREATE NEW boot.img..." \
	%% truncate -s 1GB boot.img
rt "[INIT]: CHMOD 777 boot.img..." \
	%% chmod 777 boot.img
rt "[INIT]: CREATE NEW mounted dir" \
	%t mkdir mounted
rt "[INIT]: CREATE FILESYSTEM..." \
	%% mkfs boot.img
rt "[INIT]: MOUNT boot.img TO mounted/ ..." \
	%% mount boot.img mounted/
rt "[INIT]: INSTALLING SYSLINUX BOOTLOADER..." \
	%% extlinux --install mounted/
