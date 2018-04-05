@echo off

set ME=%~nx0
set COUNT=13
set PROGRAM=nemytykh-random-program-generator
set ARGS=20
call lib\include.bat "%1"
erase test-*.ref
