@echo off

for /F "eol=# delims=| tokens=1-5" %%a in (compilers-win.cfg) do call :PERFORM_CC "%%a" "%%b" "%%c" "%%d" "%%e"

erase *.obj *.o temp.cmd

goto :EOF

:PERFORM_CC
setlocal
  call :TRIM "%~1"
  set NAME=%TRIM_RESULT%
  call :TRIM "%~2"
  set CPPLINE=%TRIM_RESULT%
  call :TRIM "%~3"
  set EXEOPT=%TRIM_RESULT%
  call :TRIM "%~4"
  set ENV=%TRIM_RESULT%
  call :TRIM "%~5"
  set CCPATH=%TRIM_RESULT%

  echo set ENV=%%ENV:{CCPATH}=%CCPATH%%%> temp.cmd
  echo %%ENV%%>> temp.cmd
  echo set CPPLINE=%%CPPLINE:{CCPATH}=%CCPATH%%%>> temp.cmd
  echo @echo %%PATH%%>> temp.cmd
  call temp.cmd

  %CPPLINE% %EXEOPT%test.%NAME%.exe test.cpp

  erase *.obj *.o temp.cmd

endlocal
goto :EOF

:TRIM
  set TRIM_RESULT=%~1
  if "%TRIM_RESULT%"=="" goto :EOF
:TRIM_begin
  if not "%TRIM_RESULT:~0,1%"==" " goto TRIM_end
  set TRIM_RESULT=%TRIM_RESULT:~1%
  if "%TRIM_RESULT%"=="" goto :EOF
  goto TRIM_begin
:TRIM_end
  if not "%TRIM_RESULT:~-1%"==" " goto :EOF
  set TRIM_RESULT=%TRIM_RESULT:~0,-1%
  if "%TRIM_RESULT%"=="" goto :EOF
  goto TRIM_end
goto :EOF