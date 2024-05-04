#!/bin/bash  
  
# 检查是否是root用户运行脚本  
if [[ $EUID -ne 0 ]]; then  
   echo "这个脚本必须用root用户来执行"  
   exit 1  
fi  
  
# 定义Docker的安装包和版本（这里使用默认的最新版本）  
DOCKER_PACKAGE="docker-ce"  
  
# 根据不同的Linux发行版安装Docker  
function install_docker_debian() {  
    # 更新软件包列表  
    apt-get update  
  
    # 安装必要的软件包以允许apt使用HTTPS仓库  
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common  
  
    # 添加Docker官方GPG密钥  
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  
  
    # 添加Docker官方仓库  
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"  
  
    # 再次更新软件包列表  
    apt-get update  
  
    # 安装Docker CE  
    apt-get install -y $DOCKER_PACKAGE  
  
    # 启动Docker服务  
    systemctl start docker  
  
    # 设置Docker服务开机自启  
    systemctl enable docker  
  
    echo "Docker已安装并启动"  
}  
  
function install_docker_rpm() {  
    # 安装必要的软件包以允许yum使用HTTPS仓库  
    yum install -y yum-utils device-mapper-persistent-data lvm2  
  
    # 添加Docker官方仓库  
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo  
  
    # 安装Docker CE  
    yum install -y $DOCKER_PACKAGE  
  
    # 启动Docker服务  
    systemctl start docker  
  
    # 设置Docker服务开机自启  
    systemctl enable docker  
  
    echo "Docker已安装并启动"  
}  
  
# 根据不同的Linux发行版调用相应的安装函数  
if [[ -f /etc/debian_version ]]; then  
    install_docker_debian  
elif [[ -f /etc/redhat-release ]]; then  
    install_docker_rpm  
else  
    echo "无法确定Linux发行版，无法自动安装Docker"  
    exit 1  
fi  
  
# 脚本结束  
exit 0