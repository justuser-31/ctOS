echo "[BUILD]: RM old..."
rm -rf rootfs_full
mkdir rootfs_full

mkdir rootfs_full/progs

echo "[BUILD]: CP files..."
cp -r rootfs/* rootfs_full
cp -r progs/binary_files/* rootfs_full/progs/
cp -r additional_files/*/* rootfs_full/
