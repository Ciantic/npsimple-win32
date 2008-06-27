# npsimple version
VERSION = 0.2

# Customize below to fit your system

# paths
PLUGINDIR = /usr/lib/iceweasel/plugins
BROWSER = iceweasel -a blah2

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
