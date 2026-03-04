#!/bin/sh

cp -rfv /usr/src/linux/arch/x86/boot/bzImage /boot/vmlinuz-$versao
cp -rfv /usr/src/linux/System.map /boot/System.map-$versao
cp -rfv /usr/src/linux/.config /boot/config-$versao
echo

sleep 4

cd /boot
ln -sf vmlinuz-$versao vmlinuz
ln -sf System.map-$versao System.map
ln -sf config-$versao config
echo

sleep 4

mkinitrd -c -k $versao -f xfs -r /dev/sda3 -m xhci-pci:ohci-pci:ehci-pci:xhci-hcd:uhci-hcd:ehci-hcd:hid:usbhid:i2c-hid:hid_generic:hid-asus:hid-cherry:hid-logitech:hid-logitech-dj:hid-logitech-hidpp:hid-lenovo:hid-microsoft:hid_multitouch:xfs -u -o /boot/initrd.img

rm -rf initrd-tree
mv initrd.img initrd-$versao.img

echo
sleep 2

grub-mkconfig -o /boot/grub/grub.cfg

echo
echo "concluido!!!"
