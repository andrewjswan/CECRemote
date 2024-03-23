@echo off
cls
Title Creating MediaPortal CECRemote Installer

ECHO Building Installer ...

if "%programfiles(x86)%XXX"=="XXX" goto 32BIT
    :: 64-bit
    set PROGS=%programfiles(x86)%
    goto CONT
:32BIT
    set PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=*" %%i IN ('Tools\sigcheck.exe /accepteula /nobanner /n "..\Source\bin\Release\CECRemote.dll"') DO (SET version=%%i)

:: Build MPE1
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" CECRemote.xmp2 /B /V=%version% /UpdateXML
