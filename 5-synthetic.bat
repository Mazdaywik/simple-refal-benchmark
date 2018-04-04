if not {%SRPATH%}=={} goto :PATH_IS_SET

set SRPATH=C:\Users\AKonovalov\Documents\Simple Refal (distr)

:PATH_IS_SET
call "%SRPATH%\bin\srmake" synthetic-grammar.ref >NUL 2>NUL
synthetic-grammar.exe 2>__1.txt
call "%SRPATH%\bin\srmake" synthetic-grammar.ref -X-OC >NUL 2>NUL
synthetic-grammar.exe 2>__2.txt