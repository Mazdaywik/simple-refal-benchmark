# Можно переопределить в командной строке
OS=LINUX
ARCH=86

CCOMP=${CCOMP_COMMON} ${CCOMP_${OS}}
CCOMP_COMMON=GCC CLang

CCOMP_LINUX=

CCOMP_WINDOWS=${CCOMP_WINDOWS_${ARCH}}
CCOMP_WINDOWS_86=BCC MSVC86 Watcom
CCOMP_WINDOWS_64=${CCOMP_WINDOWS_86} MSVC64 GCC64 CLang64

EXESUF_LINUX=
EXESUF_WINDOWS=.exe

TARGETS=$(foreach cc,${CCOMP},test-exe.${cc}${EXESUF_${OS}})

EXEOPT_GCC=-o
EXEOPT_CLang=-o
EXEOPT_GCC64=-o
EXEOPT_CLang64=-o
EXEOPT_BCC=-e
EXEOPT_MSVC86=/Fe
EXEOPT_MSVC64=/Fe
EXEOPT_Watcom=/Fe

EXE_GCC=g++ -Wall -g
EXE_CLang=clang++ -Wall -g
EXE_GCC64=g++ -Wall -g
EXE_CLang64=clang++ -Wall -g
EXE_BCC=bcc32 -w
EXE_MSVC86=cl /EHcs /W3 /wd4996
EXE_MSVC64=cl /EHcs /W3 /wd4996
EXE_Watcom=cl -nologo -W3 -passwopts:-wcd=13

all: ${TARGETS}

test-exe.%${EXESUF_${OS}}: test.cpp
	${EXE_$*} ${EXEOPT_${$*}}$@ $<

