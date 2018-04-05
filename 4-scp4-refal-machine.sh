#!/bin/bash

if [ -z "$SRPATH" ]; then
  echo Set SRPATH environment:
  echo "  SRPATH=~/simple-refal $0"
  exit 1
fi

if [ ! -e SCP4/install.ref ]; then
  echo Please unpack sources of supercompiler to SCP4 directory
  exit 1
fi

(
  PATH="$SRPATH/distrib/bin":$PATH
  if [ ! -e SCP4/scp4a ]; then
    cd SCP4
    srmake install.ref
    ./install linux
    ./refcall.bat
    cd ..
  fi
  PATH=SCP4:$PATH
  SCP4/inref4p nemytykh-RefalMachine.ref
)

TMPSCP=SCP4

ME=$0
COUNT=13
PROGRAM=nemytykh-scp4
ARGS=nemytykh-RefalMachine.mst
source lib/include.sh "$1"
