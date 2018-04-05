@echo off

if x"%SRPATH%"==x"" (
  echo Set SRPATH environment:
  echo   set SRPATH=C:\path\to\simpler-refal
  echo   %~nx0
  goto :EOF
)

if not exist SCP4\install.ref (
  echo Please unpack sources of supercompiler to SCP4 directory
  exit /b 1
)

setlocal
  set PATH=%SRPATH%\distrib\bin;%PATH%
  if not exist SCP4\scp4a.bat (
    cd SCP4
    call srmake install.ref
    ren install.exe prepare.exe
    prepare.exe windowsNT
    call refcall.bat
    cd ..
  )
  set PATH=SCP4;%PATH%
  call SCP4\inref4p nemytykh-RefalMachine.ref
endlocal

set TMPSCP=SCP4

set ME=%~nx0
set COUNT=13
set PROGRAM=nemytykh-scp4
set ARGS=nemytykh-RefalMachine.mst
call lib\include.bat "%1"
