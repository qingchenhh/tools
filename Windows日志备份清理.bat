@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

rem mode con cols=120 lines=40
rem title Windows��־��������v0.1 by:�峿
rem color 0a

rem PowerShell -Command "& {Get-Date -Format 'yyyy-MM-dd H:m:s'}" > date

set tmp_date=%date:~0,4%%date:~5,2%%date:~8,2%

echo %tmp_date%

set "save_path=C:\Users\Administrator\Desktop\%tmp_date%\"
set "Application_log=%SystemRoot%\System32\Winevt\Logs\Application.evtx"
set "Security_log=%SystemRoot%\System32\Winevt\Logs\Security.evtx"
set "System_log=%SystemRoot%\System32\Winevt\Logs\System.evtx"
set "Setup_log=%SystemRoot%\System32\Winevt\Logs\Setup.evtx"

echo %Application_log%
echo %Security_log%
echo %System_log%
echo %Setup_log%

if exist "%save_path%" (
	echo.
	echo [*] ����%save_path%Ŀ¼������ִֹͣ�У�
	exit
) else ( echo.
	md %save_path%
)

if exist "%Application_log%" (
	echo.
	echo [*] ����Application��־�ļ���������Application��־�ļ����ݡ�
	copy %Application_log% %save_path%
) else ( echo.
	echo [-] ������Application��־�ļ�������ִֹͣ�У���
	exit
)

if exist "%Security_log%" (
	echo.
	echo [*] ����Security��־�ļ���������Security��־�ļ����ݡ�
	copy %Security_log% %save_path%
) else ( echo.
	echo [-] ������Security��־�ļ�������ִֹͣ�У���
	exit
)

if exist "%System_log%" (
	echo.
	echo [*] ����System��־�ļ���������System��־�ļ����ݡ�
	copy %System_log% %save_path%
) else ( echo.
	echo [-] ������System��־�ļ�������ִֹͣ�У���
	exit
)

if exist "%Setup_log%" (
	echo.
	echo [*] ����Setup��־�ļ���������Setup��־�ļ����ݡ�
	copy %Setup_log% %save_path%
) else ( echo.
	echo [-] ������Setup��־�ļ�������ִֹͣ�У���
	exit
)

PowerShell -Command "& {Clear-Eventlog -Log Application,System,Security}"

rem Get-WinEvent -ListLog Application,Setup,Security -Force | % {Wevtutil.exe cl $_.Logname}

echo.
echo �밴������˳���
pause >nul