@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
title Windows�˿�ת��
color 0a
:starting
echo.
echo ***�ű���ʹ��windows�Դ���netsh���ж˿�ת����Ĭ��360�����ء�***
echo.
set /p des=Ŀ��ip��
set /p des_port=Ŀ��˿ڣ�
set /p local_port=���ض˿ڣ�
echo.
echo [+] �����˿�ת����
netsh interface portproxy add v4tov4 listenport=%local_port% connectaddress=%des% connectport=%des_port%
echo.
echo [+] ���ʱ�����%local_port%�˿ڼ��ɷ���%des%��%des_port%�˿ڡ�
echo.
echo ============���еĶ˿�ת���б�============
netsh interface portproxy show all
echo. 
echo [*] Ҫɾ���˿�ת����ִ���������
echo [*] netsh interface portproxy delete v4tov4 listenaddress=* listenport=%local_port%
echo.
echo [*] ɾ�����еĶ˿�ת����netsh interface portproxy reset
echo.
echo ִ����ϣ���������˳���
pause >nul