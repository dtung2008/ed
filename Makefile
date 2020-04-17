# Makefile for GNU ed - The GNU line editor
# Copyright (C) 2006, 2007, 2008, 2009 Antonio Diaz Diaz.
# This file was generated automatically by configure. Do not edit.
#
# This Makefile is free software: you have unlimited permission
# to copy, distribute and modify it.

progname = ed
progversion = 1.4
VPATH = .
prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datadir = $(prefix)/share
infodir = $(datadir)/info
mandir = $(datadir)/man
sysconfdir = $(prefix)/etc
program_prefix = 
CC = gcc
CXX = g++
CPPFLAGS = 
CFLAGS = -Wall -W -O2
CXXFLAGS = -Wall -W -O2
LDFLAGS = 

DISTNAME = $(progname)-$(progversion)
INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -p -m 755
INSTALL_DATA = $(INSTALL) -p -m 644
INSTALL_DIR = $(INSTALL) -d -m 755
SHELL = /bin/sh

objs = buffer.o carg_parser.o global.o io.o \
       main.o main_loop.o regex.o signal.o


.PHONY : all install install-info install-man install-strip \
         uninstall uninstall-info uninstall-man \
         doc info man check dist clean distclean

all : $(progname)

$(progname) : $(objs)
	$(CC) $(LDFLAGS) -o $(progname) $(objs)

$(progname)_profiled : $(objs)
	$(CC) $(LDFLAGS) -pg -o $(progname)_profiled $(objs)

main.o : main.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -DPROGVERSION=\"$(progversion)\" -c -o $@ $<

%.o : %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(objs)       : Makefile ed.h
carg_parser.o : carg_parser.h
main.o        : carg_parser.h


doc : info

info : $(VPATH)/doc/$(progname).info

$(VPATH)/doc/$(progname).info : $(VPATH)/doc/$(progname).texinfo
	cd $(VPATH)/doc && makeinfo $(progname).texinfo

Makefile : $(VPATH)/configure $(VPATH)/Makefile.in
	./config.status

check : all $(VPATH)/testsuite/check.sh
	@$(VPATH)/testsuite/check.sh $(VPATH)/testsuite

install : all install-info install-man
	if test ! -d $(DESTDIR)$(bindir) ; then $(INSTALL_DIR) $(DESTDIR)$(bindir) ; fi
	$(INSTALL_PROGRAM) ./$(progname) $(DESTDIR)$(bindir)/$(program_prefix)$(progname)
	-rm -f $(DESTDIR)$(bindir)/$(program_prefix)r$(progname)
	cd $(DESTDIR)$(bindir) && ln -s $(program_prefix)$(progname) $(program_prefix)r$(progname)

install-info :
	if test ! -d $(DESTDIR)$(infodir) ; then $(INSTALL_DIR) $(DESTDIR)$(infodir) ; fi
	$(INSTALL_DATA) $(VPATH)/doc/$(progname).info $(DESTDIR)$(infodir)/$(program_prefix)$(progname).info
	-install-info --info-dir=$(DESTDIR)$(infodir) $(DESTDIR)$(infodir)/$(program_prefix)$(progname).info

install-man :
	if test ! -d $(DESTDIR)$(mandir)/man1 ; then $(INSTALL_DIR) $(DESTDIR)$(mandir)/man1 ; fi
	$(INSTALL_DATA) $(VPATH)/doc/$(progname).1 $(DESTDIR)$(mandir)/man1/$(program_prefix)$(progname).1
	-rm -f $(DESTDIR)$(mandir)/man1/$(program_prefix)r$(progname).1
	cd $(DESTDIR)$(mandir)/man1 && ln -s $(program_prefix)$(progname).1 $(program_prefix)r$(progname).1

install-strip : all
	$(MAKE) INSTALL_PROGRAM='$(INSTALL_PROGRAM) -s' install

uninstall : uninstall-info uninstall-man
	-rm -f $(DESTDIR)$(bindir)/$(program_prefix)$(progname)
	-rm -f $(DESTDIR)$(bindir)/$(program_prefix)r$(progname)

uninstall-info :
	-install-info --remove $(DESTDIR)$(infodir)/$(program_prefix)$(progname).info $(DESTDIR)$(infodir)/dir
	-rm -f $(DESTDIR)$(infodir)/$(program_prefix)$(progname).info

uninstall-man :
	-rm -f $(DESTDIR)$(mandir)/man1/$(program_prefix)$(progname).1
	-rm -f $(DESTDIR)$(mandir)/man1/$(program_prefix)r$(progname).1

dist :
	ln -sf $(VPATH) $(DISTNAME)
	tar -cvf $(DISTNAME).tar \
	  $(DISTNAME)/AUTHORS \
	  $(DISTNAME)/COPYING \
	  $(DISTNAME)/ChangeLog \
	  $(DISTNAME)/INSTALL \
	  $(DISTNAME)/Makefile.in \
	  $(DISTNAME)/NEWS \
	  $(DISTNAME)/README \
	  $(DISTNAME)/TODO \
	  $(DISTNAME)/configure \
	  $(DISTNAME)/doc/$(progname).1 \
	  $(DISTNAME)/doc/$(progname).info \
	  $(DISTNAME)/doc/$(progname).texinfo \
	  $(DISTNAME)/doc/fdl.texinfo \
	  $(DISTNAME)/testsuite/check.sh \
	  $(DISTNAME)/testsuite/*.t \
	  $(DISTNAME)/testsuite/*.d \
	  $(DISTNAME)/testsuite/*.r \
	  $(DISTNAME)/testsuite/*.pr \
	  $(DISTNAME)/testsuite/*.err \
	  $(DISTNAME)/testsuite/*.posix \
	  $(DISTNAME)/*.h \
	  $(DISTNAME)/*.c
	rm -f $(DISTNAME)
	lzip -v -9 $(DISTNAME).tar

clean :
	-rm -f $(progname) r$(progname) $(progname)_profiled $(objs)

distclean : clean
	-rm -f Makefile config.status *.tar *.tar.lz