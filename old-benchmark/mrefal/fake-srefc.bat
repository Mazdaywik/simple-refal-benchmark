@echo off
:LOOP
if "%1"=="" goto :EOF
if exist "%~1" (
  if not exist "%~dpn1".cpp echo.>"%~dpn1".cpp
)
shift
goto :LOOP