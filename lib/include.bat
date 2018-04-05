if x"%SRPATH%"==x"" (
  echo Set SRPATH environment:
  echo   set SRPATH=C:\path\to\simpler-refal
  echo   %ME%
  goto :EOF
)

if not x"%~1"==x"" set COUNT=%~1

call :RUN_TEST "" no-opt
call :RUN_TEST "-X-OC" OC
call :RUN_TEST "-X-OR" OR
call :RUN_TEST "-X-ORC" ORC
call :RUN_TEST "--scratch -X-Od" Od
call :RUN_TEST "--scratch -X-OdC" OdC
call :RUN_TEST "--scratch -X-OdR" OdR
call :RUN_TEST "--scratch -X-OdRC" OdRC

erase *.exe *.rasl *.cpp *.obj *.o *.tds *.tmp

goto :EOF

:RUN_TEST
  set OPT=%~1
  set OPT_TXT=%~2

  if x"%PROGRAM%"==x"" goto :EOF

  if exist out.tmp erase out.tmp

  call "%SRPATH%\bin\srmake" %OPT% "%PROGRAM%.ref" 2>NUL
  echo Perform %OPT_TXT%:
  for /L %%i in (1, 1, %COUNT%) do (
    echo %%i
    "%PROGRAM%.exe" %ARGS% >NUL 2>> out.tmp
  )
  sort out.tmp > "TIME-%PROGRAM%-%OPT_TXT%.txt"
  erase out.tmp
goto :EOF
