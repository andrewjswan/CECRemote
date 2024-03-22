@echo off
cls
Title Building MediaPortal CEC Remote (RELEASE)

ECHO.
ECHO Building CECRemote ...

cd ..\Source

setlocal enabledelayedexpansion

if "%programfiles(x86)%XXX"=="XXX" goto 32BIT
	:: 64-bit
	set PROGS=%programfiles(x86)%
	goto CONT
:32BIT
	set PROGS=%ProgramFiles%
:CONT
IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Prepare version
for /f "tokens=*" %%a in ('git rev-list HEAD --count') do set REVISION=%%a 
set REVISION=%REVISION: =%
"..\Installer\Tools\sed.exe" -i "s/\$WCREV\$/%REVISION%/g" Properties\AssemblyInfo.cs

:: Prepare library
echo.
echo Copy %ARCH% library...
copy ..\External\x64\LibCecSharp.dll ..\External\

:: Build
"%WINDIR%\Microsoft.NET\Framework\v4.0.30319\MSBUILD.exe" /target:Rebuild /property:Configuration=RELEASE /fl /flp:logfile=CECRemote.log;verbosity=diagnostic CECRemote.sln

: Revert version
git checkout Properties\AssemblyInfo.cs 

cd ..\Installer

pause
