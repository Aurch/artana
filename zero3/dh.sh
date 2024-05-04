#!/bin/bash

# 定义新的PS1变量值
new_PS1='\[\e[33m\]Hei任雕\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[33m\]\@\[\e[m\]\[\e[36m\] \w\[\e[m\]\e[5m\] \$\e[0m\]: '

# 将新的PS1写入到~/.bashrc文件
echo "export PS1=\"$new_PS1\"" >> ~/.bashrc

# 通知用户已修改并提示重新加载bashrc
echo "PS1已更新，为了使更改生效，请运行以下命令："
echo "source ~/.bashrc"

# 可选：直接执行source命令让修改立即生效，而不是让用户手动执行
source ~/.bashrc