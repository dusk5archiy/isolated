set query=NFS
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*%query%*.mum >temp.txt
for /f %%i in ('findstr /i . temp.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del temp.txt
pause
