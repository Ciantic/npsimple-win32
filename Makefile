# npsimple - simple NPAPI plugin test case

include config.mk

SRC = npsimple.c
OBJ = ${SRC:.c=.o}

all: options npsimple.so ${shell uname}

options:
	@echo npsimple build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

npsimple.so: ${OBJ}
	@echo LD $@
	@${CC} -v -shared -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f npsimple.so ${OBJ} Localized.rsrc
	@rm -rf npsimple.plugin

Linux:
	@chmod 755 npsimple.so
	@echo Setup: sudo ln -s ${shell pwd}/npsimple.so /usr/lib/mozilla/plugins/npsimple.so
	@echo Test: /usr/lib/webkit-1.0/libexec/GtkLauncher file://`pwd`/test.html # apt-get install libwebkit-1.0-1

Darwin:
	/Developer/Tools/Rez -o Localized.rsrc -useDF Localized.r
	mkdir -p npsimple.plugin/Contents/MacOS
	mkdir -p npsimple.plugin/Contents/Resources/English.lproj
	cp -r Localized.rsrc npsimple.plugin/Contents/Resources/English.lproj
	cp -f Info.plist npsimple.plugin/Contents
	cp -f npsimple.so npsimple.plugin/Contents/MacOS/npsimple
	@echo Setup: sudo ln -s `pwd`/npsimple.so /Library/Internet\\ Plug-Ins/npsimple.plugin
	@echo Test: /Applications/Safari.app/Contents/MacOS/Safari test.html
	@echo Test: /Applications/Firefox.app/Contents/MacOS/firefox test.html
	@echo Test: /Applications/Opera.app/Contents/MacOS/Opera file://`pwd`/test.html

.PHONY: all options clean Darwin Linux
