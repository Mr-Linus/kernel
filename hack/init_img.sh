#!/bin/bash
green='\e[1;32m' # green
red='\e[1;31m' # red
blue='\e[1;34m' # blue  
nc='\e[0m' # normal

local_dir=`pwd`
create_img(){
        cd .. 
        cdir=`pwd` echo "create image dir in $cdir ..."
        mkdir image  
	echo "==> create hd.img with 512 block, 100MB..."
        dd bs=512 if=/dev/zero of=hd.img count=204800 
        print_result
        echo "==> set img to loop device..."
        losetup /dev/loop0 hd.img 
        print_result
        echo "==> build file system to loop device..."
        mkfs.ext4 -q /dev/loop0 
        print_result
        echo "==> mount loop device to hdisk..."
        mkdir hdisk 
        mount -o loop ./hd.img ./hdisk/ 
  	print_result
        echo "==> create boot dir..."
        mkdir ./hdisk/boot/
        print_result
        echo "==> install grub to img..."
        grub-install --boot-directory=./hdisk/boot/ --force --allow-floppy /dev/loop0
        print_result
        create_grub_cfg
        print_result
}

create_grub_cfg(){
	echo "==> create grub config file..."
	cat > ./hdisk/boot/grub/grub.cfg << EOF
menuentry 'CherryOS' {
    insmod part_msdos
    insmod ext2
    set root='hd0,msdos1' #我们的硬盘只有一个分区所以是'hd0,msdos1'
    multiboot2 /boot/HelloOS.eki #加载boot目录下的HelloOS.eki文件
    boot #引导启动
}
set timeout_style=menu
if [ "${timeout}" = 0 ]; then
  set timeout=10 #等待10秒钟自动启动
fi
EOF
chmod +x ./hdisk/boot/grub/grub.cfg
}

print_result(){
        if [ $? == 0 ] ; then
                echo -e "[${green}success!${nc}]"
        else
                echo -e "[${red}failed!${nc}]"
                exit 1
        fi
}

read -p "press key Y/y to create a img file:" key
case $key in 
	"y"|"Y"|"")	
		create_img
                cd $local_dir
	;;
	*)
		exit
        ;;
esac
