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
	@rm -f npsimple.so ${OBJ} npsimple-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p npsimple-${VERSION}
	@cp -R Makefile config.mk test.html ${SRC} npsimple-${VERSION}
	@tar -cf npsimple-${VERSION}.tar npsimple-${VERSION}
	@gzip npsimple-${VERSION}.tar
	@rm -rf npsimple-${VERSION}

install: all
	@echo installing plugin file to ${DESTDIR}${PREFIX}/lib/firefox/plugins
	@mkdir -p ${DESTDIR}${PREFIX}/lib/firefox/plugins
	@cp -f npsimple.so ${DESTDIR}${PREFIX}/lib/firefox/plugins
	@chmod 755 ${DESTDIR}${PREFIX}/lib/firefox/plugins/npsimple.so

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/lib/firefox/plugins/npsimple.so
	@rm -f ${DESTDIR}${PREFIX}/lib/firefox/npsimple.so

.PHONY: all options clean dist install uninstall
