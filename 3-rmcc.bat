@echo off

set ME=%~nx0
set COUNT=13
set PROGRAM=skor-rmcc
set ARGS=refal7.bnf refal7.tokens NUL NUL
call lib\include.bat "%1"
