@echo off

if "%~1"=="" (
  echo run: %0 opt-flag
  exit
)

set OPT=NOOPT
set OPTFLAG=
call :PERFORM_ALL

set OPT=OPT
set OPTFLAG=-X%~1
call :PERFORM_ALL

erase *.obj *.o temp.cmd

goto :EOF

:PERFORM_ALL
setlocal
  for /F "eol=# delims=| tokens=1-5" %%a in (compilers-win.cfg) do (
    call :PERFORM_CC "%%a" "%%b" "%%c" "%%d" "%%e"
  )
endlocal
goto :EOF

:PERFORM_CC
setlocal
  call :TRIM "%~1"
  set CCNAME=%TRIM_RESULT%
  call :TRIM "%~2"
  set CPPLINE=%TRIM_RESULT%
  call :TRIM "%~3"
  set EXEOPT=%TRIM_RESULT%
  call :TRIM "%~4"
  set ENV=%TRIM_RESULT%
  call :TRIM "%~5"
  set CCPATH=%TRIM_RESULT%

  echo C++ compiler: %CCNAME%

  for /F "eol=# delims=| tokens=1-4" %%f in (benchmarks-win.cfg) do (
    call :PERFORM_SR "%%f" "%%g" "%%h" "%%i"
  )

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

:PERFORM_SR
setlocal
  call :TRIM "%~1"
  set TESTNAME=%TRIM_RESULT%
  call :TRIM "%~2"
  set TESTDIR=%TRIM_RESULT%
  call :TRIM "%~3"
  set TESTSRMAKEFLAGS=%TRIM_RESULT%
  call :TRIM "%~4"
  set TESTFLAGS=%TRIM_RESULT%

  echo Benchmark: %TESTNAME%

  echo set ENV=%%ENV:{CCPATH}=%CCPATH%%%> temp.cmd
  echo %%ENV%%>> temp.cmd
  echo set CPPLINE=%%CPPLINE:{CCPATH}=%CCPATH%%%>> temp.cmd
  echo @echo %%PATH%%>> temp.cmd
  call temp.cmd > out.%CCNAME%.txt 2> err.%CCNAME%.txt

  set CCEXE=test.%CCNAME%.exe
  %CPPLINE% %EXEOPT%%CCEXE% test.cpp >> out.%CCNAME%.txt 2>> err.%CCNAME%.txt
  set TEXE=%TESTNAME%.%CCNAME%.%OPT%.exe
  set TEXE_NOOPT=%TESTNAME%.%CCNAME%.NOOPT.exe

  if not errorlevel 1 (
    erase out.%CCNAME%.txt err.%CCNAME%.txt
    pushd %TESTDIR%
    call srmake %TESTNAME% %TESTSRMAKEFLAGS% -X-F%EXEOPT%%TEXE% %OPTFLAG% ^
      > %TEXE%.out.txt 2>%TEXE%.err.txt
    if errorlevel 1 (
      echo   can't make %TESTNAME%
      endlocal
      popd
      goto :EOF
    )
    erase %TEXE%.runout.txt %TEXE%.profile.txt >NUL
    for /L %%M in (1, 1, 2) do (
      %TEXE% %TESTFLAGS% >>%TEXE%.runout.txt 2>>%TEXE%.profile.txt
      if errorlevel 1 (
        echo   failed run %TESTNAME%
        endlocal
        popd
        goto :EOF
      )
    )
    erase *.obj *.tds *.o ^
      %TEXE% ^
      %TEXE%.out.txt ^
      %TEXE%.err.txt ^
      %TEXE%.runout.txt
    popd
  ) else (
    echo   failed
  )

  if {%OPT%}=={OPT} (
    echo Analysis here: compare %TEXE%.profile.txt and %TEXE_NOOPT%.profile.txt
  )

  erase *.obj *.tds *.o %CCEXE% temp.cmd
endlocal
goto :EOF
