@echo off
:start
cls
echo.
echo.
echo TwitCast Downloader by Kassarin
echo.
echo Credits: https://github.com/niseyami
echo.
echo Commands:
echo download, convert, quit
echo.
SET /p c=
if %c%==download goto :predownload
if %c%==dl goto :predownload
if %c%==convert goto :convert
if %c%==quit goto exit
goto :notfound

:notfound
cls
echo Command not recognised
echo Returning to mainmenu
pause
goto :start

:predownload
cls
echo.
echo.
echo Paste the snippet below in the web console (F12 in Chrome):
echo let a=[];for(let _ of JSON.parse(document.querySelector("video")["dataset"]["moviePlaylist"])[2])a.push(_.source?.url);console.log(a.join("\n"))
echo.
echo Set TwitCast link:
set /p FileLink=
echo.
echo.
echo Set file name:
set /p FileName=
echo.
echo.
if "%FileLink%" == "" (
echo File link cannot be empty!
pause
goto :start
)
if "%FileName%" == "" (
set FileName = "TwitCastVideo" 
)
echo Link: %FileLink%
echo Name: %FileName%
echo.
echo Is this correct? (y/n)
set /p downloadAnswer=
if %downloadAnswer%==n goto :predownload
if %downloadAnswer%==y goto :download
goto :notfound

:download
cls
echo.
echo Twitcast Link: %FileLink%
echo File Name: %FileName%
echo.
echo Downloading...
ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i %FileLink% -c copy %FileName%.mkv
echo.
echo.
echo Executed. Please check the result.
echo.
echo Would you like to convert to MP4? (y/n)
set /p postDLAnswer=
if %postDLAnswer%==n goto :start
if %postDLAnswer%==y goto :immediateconvert
goto :notfound

:immediateconvert
cls
echo.
echo Converting...
ffmpeg -i %FileName%.mkv -codec copy %FileName%.mp4
echo.
echo.
echo Executed. Please check the result.
echo.
pause
goto :start

:convert
cls
echo.
echo Please enter a file name to convert:
set /p FileName=
echo.
if "%FileName%" == "" (
echo File name cannot be empty!
pause
goto :start)
echo Converting...
ffmpeg -i %FileName%.mkv -codec copy %FileName%.mp4
echo.
echo.
echo Executed. Please check the result.
echo.
pause
goto :start