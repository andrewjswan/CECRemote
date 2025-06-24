@echo off
cls
Title Building MediaPortal CEC Remote (RELEASE)

ECHO.
ECHO Building CECRemote ...

cd ..\Source

setlocal enabledelayedexpansion

:: Prepare version
for /f "tokens=*" %%a in ('git rev-list HEAD --count') do set REVISION=%%a 
set REVISION=%REVISION: =%
"..\Installer\Tools\sed.exe" -i "s/\$WCREV\$/%REVISION%/g" Properties\AssemblyInfo.cs

:: Prepare library
echo.
echo Copy x64 LibCecSharp library...
copy ..\External\x64\LibCecSharp.dll ..\External\

:: Build
FOR %%p IN ("%PROGRAMFILES(x86)%" "%PROGRAMFILES%") DO (
  FOR %%s IN (2019 2022) DO (
    FOR %%e IN (Community Professional Enterprise BuildTools) DO (
      SET PF=%%p
      SET PF=!PF:"=!
      SET MSBUILD_PATH="!PF!\Microsoft Visual Studio\%%s\%%e\MSBuild\Current\Bin\MSBuild.exe"
      IF EXIST "!MSBUILD_PATH!" GOTO :BUILD
    )
  )
)

:BUILD

%MSBUILD_PATH% /target:Rebuild /property:Configuration=RELEASE /fl /flp:logfile=CECRemote.log;verbosity=diagnostic CECRemote.sln

: Revert version
git checkout Properties\AssemblyInfo.cs 

cd ..\Installer

pause
