######
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
# Makefile: Makefile for xanton+xiri
# (c) 2001 Ask Solem Hoel <ask@unixmonks.net>
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License version 2,
#   *NOT* "earlier versions", as published by the Free Software Foundation.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
# -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#####

PREFIX=/opt/xiri
PERL=/usr/bin/perl
PERLFLAGS=

PIMPX=/usr/local/bin/pimpx
PFLAGS=#--debug

DEFAULT_PORT=8889
DEFAULT_WORD_DB=$(PREFIX)/var/db/xiri-word.db
DEFAULT_FILE_DB=$(PREFIX)/var/db/xiri-file.db
DEFAULT_LOGFILE=$(PREFIX)/var/log/xiri.log
DEFAULT_PIDFILE=$(PREFIX)/var/run/xiri.pid
DOCUMENT_ROOT=$(PREFIX)/html
HAVE_HTML_ENTITIES=yes
CACHE_DB=$(PREFIX)/var/db/xiri-cache.db
CACHE_TIMESTAMP_DB=$(PREFIX)/var/db/xiri-cache-timestamp.db
XIRI_FLAGS = -Dv
VERSION=0.63

all: sbin/XIRI sbin/XANTON bin/XIRICTL sbin/CLEANCACHE sbin/RMCACHE

sbin/XIRI:
	$(PERL) $(PIMPX) $(PFLAGS) xiri \
		-DPERL=\"$(PERL)\" \
		-DDEFAULT_LOGFILE=\"$(DEFAULT_LOGFILE)\" \
		-DDEFAULT_WORD_DB=\"$(DEFAULT_WORD_DB)\" \
		-DDEFAULT_FILE_DB=\"$(DEFAULT_FILE_DB)\" \
		-DDEFAULT_PIDFILE=\"$(DEFAULT_PIDFILE)\" \
		-DDEFAULT_PORT=\"$(DEFAULT_PORT)\" \
		-DCACHE_DB=\"$(CACHE_DB)\" \
		-DCACHE_TIMESTAMP_DB=\"$(CACHE_TIMESTAMP_DB)\" \
		-DDOCUMENT_ROOT=\"$(DOCUMENT_ROOT)\" \
		-DVERSION=\"$(VERSION)\" \
		-DLIB=\"$(PREFIX)/include\" \
		-Osbin/XIRI

sbin/CLEANCACHE:
	$(PERL) $(PIMPX) $(PFLAGS) cleancache \
		-DPERL=\"$(PERL)\" \
		-DCACHE_DB=\"$(CACHE_DB)\" \
		-DCACHE_TIMESTAMP_DB=\"$(CACHE_TIMESTAMP_DB)\" \
		-Osbin/CLEANCACHE 

sbin/RMCACHE:
	$(PERL) $(PIMPX) $(PFLAGS) rmcache \
		-DPERL=\"$(PERL)\" \
		-DCACHE_DB=\"$(CACHE_DB)\" \
		-DCACHE_TIMESTAMP_DB=\"$(CACHE_TIMESTAMP_DB)\" \
		-Osbin/RMCACHE

sbin/XANTON:
	$(PERL) $(PIMPX) $(PFLAGS) xanton \
		-DPERL=\"$(PERL)\" \
		-DVERSION=\"$(VERSION)\" \
		-DHAVE_HTML_ENTITES=\"$(HAVE_HTML_ENTITIES)\" \
		-DDEFAULT_WORD_DB=\"$(DEFAULT_WORD_DB)\" \
		-DDEFAULT_FILE_DB=\"$(DEFAULT_FILE_DB)\" \
		-DLIB=\"$(PREFIX)/include\" \
		-Obin/XANTON

bin/XIRICTL:
	$(PERL) $(PIMPX) $(PFLAGS) xirictl \
		-DVERSION=\"$(VERSION)\" \
		-DDEFAULT_PIDFILE=\"$(DEFAULT_PIDFILE)\" \
		-DPREFIX=\"$(PREFIX)\" \
		-DXIRI_FLAGS=\"$(XIRI_FLAGS)\" \
		-Obin/XIRICTL

install: all prepare bin_i sbin_i include_i html_i

prepare:
	test -d $(PREFIX) 		|| mkdir $(PREFIX)
	test -d $(PREFIX)/bin		|| mkdir $(PREFIX)/bin
	test -d $(PREFIX)/sbin		|| mkdir $(PREFIX)/sbin
	test -d $(PREFIX)/include	|| mkdir $(PREFIX)/include
	test -d $(PREFIX)/var/run 	|| mkdir -p $(PREFIX)/var/run
	test -d $(PREFIX)/var/log	|| mkdir -p $(PREFIX)/var/log
	test -d $(PREFIX)/var/db	|| mkdir -p $(PREFIX)/var/db
	test -d $(PREFIX)/html		|| mkdir -p $(PREFIX)/html

	chmod 755 $(PREFIX)/bin $(PREFIX)/sbin $(PREFIX) $(PREFIX)/var/run $(PREFIX)/var/db
	chmod 750 $(PREFIX)/var/log

sbin_i:
	cp sbin/XIRI $(PREFIX)/sbin/xiri
	cp sbin/CLEANCACHE $(PREFIX)/sbin/cleancache
	cp sbin/RMCACHE $(PREFIX)/sbin/rmcache
	chmod 755 $(PREFIX)/sbin/xiri
	chmod 755 $(PREFIX)/sbin/cleancache
	chmod 755 $(PREFIX)/sbin/rmcache

bin_i:
	cp bin/XANTON $(PREFIX)/bin/xanton
	cp bin/XIRICTL $(PREFIX)/bin/xirictl
	chmod 755 $(PREFIX)/bin/xanton $(PREFIX)/bin/xirictl

html_i:
	cp html/* $(PREFIX)/html
	chmod 644 $(PREFIX)/html/* 

include_i:
	cp include/asklib.ph $(PREFIX)/include/asklib.ph
	cp include/ProgressBar.pm $(PREFIX)/include/ProgressBar.pm
	chmod 644 $(PREFIX)/include/asklib.ph $(PREFIX)/include/ProgressBar.pm

clean:
	rm -f a.out core *.o sbin/XIRI bin/XANTON bin/XIRICTL sbin/CLEANCACHE sbin/RMCACHE

spaces:
	expand -s 4 xanton
	
