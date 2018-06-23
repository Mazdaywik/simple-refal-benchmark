@echo off

set ME=%~nx0
set COUNT=13
set PROGRAM=SR-Lexer
set ARGS=SR-Lexer.sref
call lib\include.bat "%1"
erase test-*.ref
