# npsimple version
VERSION = 0.3

# Customize below to fit your system

ifeq (${shell uname}, Darwin)
CPPFLAGS = -DVERSION=\"${VERSION}\" -DWEBKIT_DARWIN_SDK
LDFLAGS = -dynamiclib #-framework Carbon -framework CoreFoundation -framework WebKit
else
INCS = -IC:\Projects\NPAPI\test\xulrunner-sdk\include # apt-get install xulrunner-dev
CPPFLAGS = -DVERSION=\"${VERSION}\" -DXULRUNNER_SDK
#LDFLAGS = -L/usr/lib -lc
endif
CFLAGS = -g -pedantic -Wall -O2 ${INCS} ${CPPFLAGS}

# compiler and linker
CC = cc
