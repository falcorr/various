:: Get IP of Domain name
@setlocal EnableDelayedExpansion
@echo off

if not [%2]==[] (
	goto :usage
)
set "var="&for /f "delims=0123456789." %%i in ("%1") do set var=%%i
if defined var goto :usage
if [%1]==[/?] (
	goto :usage
)
if [%1]==[?] (
	goto :usage
)
if [%1]==[/h] (
	goto :usage
)
if [%1]==[/help] (
	goto :usage
)
if [%1]==[help] (
	goto :usage
)

goto :main

:usage
echo.
echo Add domains found listed, one per line, in routes.txt as static routes with default gateway
echo ... Usage: %0
echo Specify gateway
echo ... Usage: %0 [gateway]
echo ... e.g. %0 192.168.1.5
exit /b 0

:main
if [%1]==[] (
	for /f "tokens=2 delims=:" %%g in ('netsh interface ip show address 
	"Ethernet" ^| findstr "Default"') do set gateway=%%g
) else (
	set gateway=%1
)
set gateway=%gateway: =%


echo Adding domains listed in routes.txt as static routes via "%gateway%"
echo.
for /f "delims=" %%i in (%~dp0\routes.txt) do call :addroute %%i %gateway%

exit

:addroute 
set domain=%~1
for /f "tokens=1,2 delims=[]" %%a in ('ping -n 1 !domain!') do (
	if "%%b" NEQ "" set domainIP=%%b
)

if [%domain%] == [%gateway%] goto :eof
if not [%domain%] == [] (
	echo Domain "%domain%" resolved to "%domainIP%"
	echo Creating route ...
	route add %domainIP% mask 255.255.255.255 %gateway%
)

goto :eof
