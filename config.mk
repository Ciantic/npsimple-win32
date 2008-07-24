# npsimple version
VERSION = 0.2

# Customize below to fit your system

# paths
PLUGINDIR = ~/Library/Internet\ Plug-Ins/
BROWSER = safari

# includes and libs
#NPAPIINCS = -I/usr/include/xulrunner-1.9/stable
#INCS = -I/usr/include ${NPAPIINCS}
#LIBS = -L/usr/lib #-framework Carbon -framework CoreFoundation -framework WebKit

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\" -DOS_Darwin
CFLAGS = -g -pedantic -Wall -O2 ${INCS} ${CPPFLAGS}
LDFLAGS = ${LIBS} -dynamiclib -framework Carbon -framework CoreFoundation -framework WebKit

# compiler and linker
CC = cc -v
