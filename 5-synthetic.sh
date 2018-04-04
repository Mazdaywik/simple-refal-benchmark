#!/bin/bash

if [ -z "$SRPATH" ]; then
  SRPATH=~/simple-refal
fi
$SRPATH/bin/srmake synthetic-grammar.ref >NUL 2>NUL
./synthetic-grammar 2>__1.txt
$SRPATH/bin/srmake synthetic-grammar.ref -X-OC >NUL 2>NUL
./synthetic-grammar 2>__2.txt