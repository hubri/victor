# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

CC  = gcc
SRC = victor.c
OBJ = $(SRC:.c=.o)

victorCFLAGS = -DVERSION=\"$(VERSION)\" -D_DEFAULT_SOURCE $(CFLAGS)

all: victor

options:
	@echo victor build options:
	@echo "CFLAGS   = $(victorCFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) $(victorCFLAGS) -c $<

victor: $(OBJ) $(LIBS)
	$(CC) $(LDFLAGS) -o $@ $(OBJ) $(LIBS)

$(OBJ): arg.h

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	mkdir -p $(DESTDIR)$(DOCPREFIX)/victor
	install -m 644 README.md FAQ LICENSE $(DESTDIR)$(DOCPREFIX)/victor
	install -m 775 victor $(DESTDIR)$(PREFIX)/bin
	sed "s/VERSION/$(VERSION)/g" < victor.1 > $(DESTDIR)$(MANPREFIX)/man1/victor.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/victor.1

uninstall: all
	rm -f $(DESTDIR)$(MANPREFIX)/man1/victor.1 $(DESTDIR)$(PREFIX)/bin/victor
	rm -rf $(DESTDIR)$(DOCPREFIX)/victor

dist: clean
	mkdir -p victor-$(VERSION)
	cp -R makefile README.md  LICENSE arg.h \
		config.mk victor.c victor.1 victor-$(VERSION)
	tar -cf victor-$(VERSION).tar victor-$(VERSION)
	gzip victor-$(VERSION).tar
	rm -rf victor-$(VERSION)

clean:
	rm -f victor *.o
