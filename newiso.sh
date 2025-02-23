rm -rf ./rootfs # avoid T H E   I N T E R F E R E N C E
tar -xvzf ctCoreOS.tar.gz ./rootfs # "bop it" : unzip CoreOS rootfs
cp ./progs/binary_files/* ./rootfs/bin # "twist it" : copy progs
cp ./packages ./rootfs/* # "pull it" : copy packages and scripts 
sudo chmod -R 777 ./rootfs
sudo chroot ./rootfs packages/prepare_rootfs.sh # "extend it" : prepare rootfs and install packages 
sudo genisoimage -o "./ctOS.iso" -r -J -V "ctOS_userdebug" ./rootfs # "suck it" : generate iso
