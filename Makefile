# npsimple - simple NPAPI plugin test case

include config.mk

SRC = npsimple.c
OBJ = ${SRC:.c=.o}

all: options npsimple.so

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
	@rm -f npsimple.so ${OBJ} npsimple-${VERSION}.tar.gz Localized.rsrc
	@rm -rf npsimple.plugin

dist: clean
	@echo creating dist tarball
	@mkdir -p npsimple-${VERSION}
	@cp -R Makefile README config.mk test.html ${SRC} npsimple-${VERSION}
	@tar -cf npsimple-${VERSION}.tar npsimple-${VERSION}
	@gzip npsimple-${VERSION}.tar
	@rm -rf npsimple-${VERSION}

install: all
	@echo installing plugin file to ${PLUGINDIR}
	@mkdir -p ${PLUGINDIR}
	@cp -f npsimple.so ${PLUGINDIR}
	@chmod 755 ${PLUGINDIR}/npsimple.so

Localized.rsrc:
	/Developer/Tools/Rez -o Localized.rsrc -useDF Localized.r

macinstall: all Localized.rsrc
	mkdir -p npsimple.plugin/Contents/MacOS
	mkdir -p npsimple.plugin/Contents/Resources/English.lproj
	cp -r Localized.rsrc npsimple.plugin/Contents/Resources/English.lproj
	cp -f Info.plist npsimple.plugin/Contents
	cp -f npsimple.so npsimple.plugin/Contents/MacOS/npsimple

test:
	${BROWSER} test.html
	${BROWSER} testloader.html

uninstall:
	@echo removing executable file from ${PLUGINDIR}/npsimple.so
	@rm -f ${PLUGINDIR}/npsimple.so

.PHONY: all options clean dist install uninstall test
