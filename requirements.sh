clear
echo 'updating repos..'
sudo apt update
clear
echo 'installing depens..'
sudo apt install qemu-system-x86 extlinux syslinux-utils musl-tools gcc genisoimage python3-pip
python3 -m pip install nuitka simple_term_menu
echo ''
echo 'DONE!'
