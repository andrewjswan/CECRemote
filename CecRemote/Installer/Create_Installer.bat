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

:: Temp xmp2 file
copy CECRemote%.xmp2 CECRemoteTemp.xmp2

:: Sed "{VERSION}" from xmp2 file
Tools\sed.exe -i "s/{VERSION}/%version%/g" CECRemoteTemp.xmp2

:: Build MPE1
"%PROGS%\Team MediaPortal\MediaPortal\MPEMaker.exe" CECRemoteTemp.xmp2 /B /V=%version% /UpdateXML

:: Cleanup
del CECRemoteTemp.xmp2

:: Parse version (Might be needed in the futute)
FOR /F "tokens=1-4 delims=." %%i IN ("%version%") DO ( 
    SET major=%%i
    SET minor=%%j
    SET build=%%k
    SET revision=%%l
)

:: Rename MPE1
if exist "..\Release\CECRemote-%major%.%minor%.%build%.%revision%.mpe1" del "..\Release\CECRemote-%major%.%minor%.%build%.%revision%.mpe1"
rename ..\Release\CECRemote-MAJOR.MINOR.BUILD.REVISION.mpe1 "CECRemote-%major%.%minor%.%build%.%revision%.mpe1"
