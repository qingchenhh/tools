@echo off
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

rem mode con cols=120 lines=40
rem title Windows日志备份清理v0.1 by:清晨
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
	echo [*] 存在%save_path%目录，程序将停止执行！
	exit
) else ( echo.
	md %save_path%
)

if exist "%Application_log%" (
	echo.
	echo [*] 存在Application日志文件，将进行Application日志文件备份。
	copy %Application_log% %save_path%
) else ( echo.
	echo [-] 不存在Application日志文件，程序将停止执行！。
	exit
)

if exist "%Security_log%" (
	echo.
	echo [*] 存在Security日志文件，将进行Security日志文件备份。
	copy %Security_log% %save_path%
) else ( echo.
	echo [-] 不存在Security日志文件，程序将停止执行！。
	exit
)

if exist "%System_log%" (
	echo.
	echo [*] 存在System日志文件，将进行System日志文件备份。
	copy %System_log% %save_path%
) else ( echo.
	echo [-] 不存在System日志文件，程序将停止执行！。
	exit
)

if exist "%Setup_log%" (
	echo.
	echo [*] 存在Setup日志文件，将进行Setup日志文件备份。
	copy %Setup_log% %save_path%
) else ( echo.
	echo [-] 不存在Setup日志文件，程序将停止执行！。
	exit
)

PowerShell -Command "& {Clear-Eventlog -Log Application,System,Security}"

rem Get-WinEvent -ListLog Application,Setup,Security -Force | % {Wevtutil.exe cl $_.Logname}

echo.
echo 请按任意键退出。
pause >nul