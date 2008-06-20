# npsimple version
VERSION = 0.1

# Customize below to fit your system

# paths
PREFIX    = /usr
PLUGINDIR = ${PREFIX}/lib/firefox/plugins

# includes and libs
NPAPIINCS = -I/usr/include/xulrunner-1.9/stable
INCS = -I. -I/usr/include ${NPAPIINCS}
LIBS = -L/usr/lib -lc

# flags
CPPFLAGS = -DVERSION=\"${VERSION}\"
CFLAGS = -g -pedantic -Wall -O2 ${INCS} ${CPPFLAGS}
LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
