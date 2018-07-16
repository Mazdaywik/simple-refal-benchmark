@echo off

set ME=%~nx0
set COUNT=13
set PROGRAM=synthetic-grammar
set ARGS=
set CFLAGS=-X-OC-
call lib\include.bat "%1"
