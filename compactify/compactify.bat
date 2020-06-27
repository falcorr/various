:: Compactify
@setlocal EnableDelayedExpansion
@echo off

echo [Compactify]
echo.

set /A bytesTotal=0
set /A bytesCompressed=0
set output=""
set /A ratio=0

echo XPRESS4K
for /f "delims=" %%i in (%~dp0\XPRESS4K.txt) do ( 
	echo %%i
	for /f "delims=" %%j in (%~dp0\targeted_extensions.txt) do ( 
		echo|set /p=%%j...
		
		compact.exe /c /s /i /exe:XPRESS4K "%%i\*.%%j" >nul
	)
)

echo XPRESS8K
for /f "delims=" %%i in (%~dp0\XPRESS8K.txt) do ( 
	echo %%i
	for /f "delims=" %%j in (%~dp0\targeted_extensions.txt) do ( 
		echo|set /p=%%j...
		
		compact.exe /c /s /i /exe:XPRESS8K "%%i\*.%%j" >nul
		REM for /f "tokens=* delims=" %%k in ('compact.exe /c /s /i /exe:XPRESS8K ""%%i\*.%%j"" ^| find /I "" bytes.""') do ( 
		REM 	set output=%%k
		REM ) 
		REM echo/%%myvar%%=%myvar% 
		
		REM  12,223,564 total bytes of data are stored in 123,642 bytes.
		REM for /f "tokens=1,9 delims=" %%l in output do ( 
		REM 	set bytesTotal=bytesTotal+%%l
		REM 	set bytesCompressed=bytesCompressed+%%m
		REM )
	)
)
::set ratio=bytesTotal/bytesCompressed
::echo %ratio%

echo XPRESS16K
for /f "delims=" %%i in (%~dp0\XPRESS16K.txt) do ( 
	echo %%i
	for /f "delims=" %%j in (%~dp0\targeted_extensions.txt) do ( 
		echo|set /p=%%j...
		
		compact.exe /c /s /i /exe:XPRESS16K "%%i\*.%%j" >nul
	)
)

echo LZX
for /f "delims=" %%i in (%~dp0\LZX.txt) do ( 
	echo %%i
	for /f "delims=" %%j in (%~dp0\targeted_extensions.txt) do ( 
		echo|set /p=%%j...
		
		compact.exe /c /s /i /exe:LZX "%%i\*.%%j" >nul
	)
)

echo [done]
REM pause
