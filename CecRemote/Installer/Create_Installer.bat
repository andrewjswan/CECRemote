@echo off
cls
Title Creating MediaPortal CECRemote Installer

IF NOT "%1"=="" (
  SET ARCH=%1
) ELSE (
  SET ARCH=x64
)

ECHO Building Installer %ARCH% ...

:: Check for modification
REM svn status ..\source | findstr "^M"
REM if ERRORLEVEL 1 (
REM    echo No modifications in source folder.
REM ) else (
REM    echo There are modifications in source folder. Aborting.
REM    pause
REM    exit 1
REM )

if "%programfiles(x86)%XXX"=="XXX" goto 32BIT
    :: 64-bit
    set PROGS=%programfiles(x86)%
    goto CONT
:32BIT
    set PROGS=%ProgramFiles%
:CONT

IF NOT EXIST "%PROGS%\Team MediaPortal\MediaPortal\" SET PROGS=C:

:: Get version from DLL
FOR /F "tokens=1-3" %%i IN ('Tools\sigcheck.exe "..\Source\bin\Release\CECRemote.dll"') DO ( IF "%%i %%j"=="File version:" SET version=%%k )

:: trim version
SET version=%version:~0,-1%

:: Temp xmp2 file
copy CECRemote_%ARCH%.xmp2 CECRemoteTemp.xmp2

:: Sed "CECRemote-{VERSION}.xml" from xmp2 file
Tools\sed.exe -i "s/CECRemote-%ARCH%-{VERSION}.xml/CECRemote-%ARCH%-%version%.xml/g" CECRemoteTemp.xmp2

:: Build MPE1
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" CECRemoteTemp.xmp2 /B /V=%version% /UpdateXML

:: Cleanup
del CECRemoteTemp.xmp2

:: Sed "CECRemote-{VERSION}.mpe1" from CECRemote.xml
Tools\sed.exe -i "s/CECRemote-%ARCH%-{VERSION}.mpe1/CECRemote-%ARCH%-%version%.mpe1/g" ..\Release\CECRemote-%ARCH%-%version%.xml

:: Parse version (Might be needed in the futute)
FOR /F "tokens=1-4 delims=." %%i IN ("%version%") DO ( 
    SET major=%%i
    SET minor=%%j
    SET build=%%k
    SET revision=%%l
)

:: Rename MPE1
if exist "..\Release\CECRemote-%ARCH%-%major%.%minor%.%build%.%revision%.mpe1" del "..\Release\CECRemote-%ARCH%-%major%.%minor%.%build%.%revision%.mpe1"
rename ..\Release\CECRemote-%ARCH%-MAJOR.MINOR.BUILD.REVISION.mpe1 "CECRemote-%ARCH%-%major%.%minor%.%build%.%revision%.mpe1"
