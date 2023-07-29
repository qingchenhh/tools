@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
title Windows端口转发
color 0a
:starting
echo.
echo ***脚本是使用windows自带的netsh进行端口转发，默认360会拦截。***
echo.
set /p des=目标ip：
set /p des_port=目标端口：
set /p local_port=本地端口：
echo.
echo [+] 开启端口转发！
netsh interface portproxy add v4tov4 listenport=%local_port% connectaddress=%des% connectport=%des_port%
echo.
echo [+] 访问本机的%local_port%端口即可访问%des%的%des_port%端口。
echo.
echo ============所有的端口转发列表============
netsh interface portproxy show all
echo. 
echo [*] 要删除端口转发请执行以下命令：
echo [*] netsh interface portproxy delete v4tov4 listenaddress=* listenport=%local_port%
echo.
echo [*] 删除所有的端口转发：netsh interface portproxy reset
echo.
echo 执行完毕！按任意键退出！
pause >nul