#!/bin/bash
cd ../image

#第一步 SATA的硬盘其控制器是intelAHCI
VBoxManage storagectl CherryOS --name "SATA" --add sata --controller IntelAhci --portcount 1
#第二步
VBoxManage closemedium disk ./hd.vdi #删除虚拟硬盘UUID并重新分配
#将虚拟硬盘挂到虚拟机的硬盘控制器
VBoxManage storageattach CherryOS --storagectl "SATA" --port 1 --device 0 --type hdd --medium ./hd.vdi
cd ../hack
