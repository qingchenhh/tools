@echo off
rem %1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
rem cd /d "%~dp0"

rem mode con cols=120 lines=40
title rad和URLFinder扫描 --by 清晨
rem color 0a


set radpath="rad.exe"
set URLFinder="URLFinder.exe"

:start
set /p URL=请输入URL(输入q退出)：

if "%URL%" equ "" (
	goto start
) else if /i "%URL%" equ "q" ( 
	exit
) else (
	goto scan
)

:scan
if exist "%radpath%" (
	%radpath% -t "%URL%" --http-proxy http://127.0.0.1:8080
) else (
	echo [-] rad的路径错误！
)

if exist "%URLFinder%" (
	%URLFinder% -u "%URL%" -m 3 -s all -x http://127.0.0.1:8080
) else (
	echo [-] URLFinder的路径错误！
)
set URL=
goto start