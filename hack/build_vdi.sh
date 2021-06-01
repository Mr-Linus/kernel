#!/bin/bash
cd ../image
VBoxManage convertfromraw ../hd.img --format VDI ./hd.vdi
#convertfromraw 指向原始格式文件
#--format VDI  表示转换成虚拟需要的VDI格式
cd ../hack
