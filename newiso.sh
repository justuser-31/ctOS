tar -xvzf ctCoreOS.zip ./rootfs # "bop it" : unzip CoreOS rootfs
cp ./progs/binary_files/* ./rootfs/bin # "twist it" : copy progs
cp ./packages ./rootfs/* # "pull it" : copy packages and scripts 
sudo chroot ./rootfs packages/prepare_rootfs.sh # "extend it" : prepare rootfs and install packages
sudo genisoimage -o "./ctOS.iso" -r -J -V "ctOS_userdebug" ./rootfs # "suck it" : generate iso