@echo off

if not {%SRPATH%}=={} goto :PATH_IS_SET

set SRPATH=C:\Users\Mazdaywik\Documents\Simple Refal
set COUNT=33

:PATH_IS_SET
erase *.tmp

call "%SRPATH%\bin\srmake" nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-no-opt.tmp
)

call "%SRPATH%\bin\srmake" -X-OC nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OC.tmp
)

call "%SRPATH%\bin\srmake" -X-OR nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OR.tmp
)

call "%SRPATH%\bin\srmake" -X-OCR nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OCR.tmp
)

call "%SRPATH%\bin\srmake" --scratch -X-Od nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-Od.tmp
)

call "%SRPATH%\bin\srmake" --scratch -X-OdC nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OdC.tmp
)

call "%SRPATH%\bin\srmake" --scratch -X-OdR nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OdR.tmp
)

call "%SRPATH%\bin\srmake" --scratch -X-OdCR nemytykh-random-program-generator.ref
for /L %%i in (1, 1, %COUNT%) do (
  echo %%i
  nemytykh-random-program-generator.exe 30 >NUL 2>> _1-OdCR.tmp
)

for %%f in (*.tmp) do sort %%f > %%~nf.time

erase *.exe *.rasl *.cpp *.obj *.o *.tds *.tmp
erase test-*.ref