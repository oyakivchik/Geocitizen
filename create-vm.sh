#!/bin/sh
#The ifupdown-wait-online.service should recognize that the interface
#eth0 is already up and configure eth0:1. cat /etc/network/interfaces.d/eth0
#auto eth0
#iface eth0 inet dhcp
#
#auto eth0:1
#iface eth0:1 inet static
#    address 192.168.1.14
#    netmask 255.255.255.0
#    gateway 192.168.1.254
#
if [ -z "$1" ] ;
then
echo Specify a virtual-machine name.
exit 1
fi
yum install -y nmap
yum install -y qemu-kvm libvirt libvirt-python libguestfs-tools virt-install
systemctl enable libvirtd && systemctl start libvirtd
yum install -y qemu-kvm qemu-img virt-manager libvirt libvirt-python libvirt-client virt-install virt-viewer bridge-utils
yum install -y libguestfs-tools-c
virt-builder ubuntu-16.04 --size=8G --format qcow2 -o /var/lib/libvirt/images/$1-disk01.qcow2 --hostname $1 --network --timezone Europe/Kiev --firstboot-command "dpkg-reconfigure openssh-server" --edit '/etc/default/grub: s/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200n8"/' --run-command update-grub
virt-install --import --name $1 --ram 1024 --vcpu 1 --disk path=/var/lib/libvirt/images/$1-disk01.qcow2,format=qcow2 --os-variant ubuntu16.04 --network bridge=br0,model=virtio --noautoconsole


