#!/bin/bash

if [ -z "$SRPATH" ]; then
  echo Set SRPATH environment:
  echo "  SRPATH=~/refal-5-lambda $ME"
  exit 1
fi

if [ -n "$1" ]; then
  COUNT=$1
fi

run_test() {
  OPT="$1"
  OPT_TXT="$2"

  if [ -z "$PROGRAM" ]; then
    return 1
  fi

  rm -f out.tmp

  "$SRPATH/bin/srmake" $OPT "$PROGRAM" 2>/dev/null
  echo Perform $OPT_TXT:

  for i in $(seq $COUNT); do
    echo $i
    "./$PROGRAM" $ARGS >/dev/null 2>>out.tmp
  done

  sort out.tmp > "TIME-$PROGRAM-$OPT_TXT.txt"
  rm out.tmp
}

run_test "" no-opt
run_test "-X-OP" OP
run_test "-X-OQ" OQ
run_test "--scratch -X-Od" Od
run_test "--scratch -X-OdP" OdP
run_test "--scratch -X-OdQ" OdQ
