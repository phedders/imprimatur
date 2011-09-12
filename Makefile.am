# This file is part of Imprimatur.
# Copyright (C) 2011 Sergey Poznyakoff
#
# Imprimatur is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# Imprimatur is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Imprimatur.  If not, see <http://www.gnu.org/licenses/>.

EXTRA_DIST=\
 check-docs.sh\
 emptynodes.awk\
 imprimatur.m4\
 imprimatur.mk\
 mastermenu.el\
 rendition.texi\
 untabify.el

info_TEXINFOS=
TEXI2DVI=texi2dvi -t '@set $(RENDITION)' -E

if IMPRIMATUR_COND_MAKEDOC
EXTRA_DIST+=imprimatur.texi
# FIXME: How about gendocs_template?

info_TEXINFOS+=imprimatur.texi
imprimatur_TEXINFOS=rendition.texi fdl.texi

clean-local:
	@rm -rf manual

AM_MAKEINFOFLAGS = @IMPRIMATUR_MAKEINFOFLAGS@
imprimatur_INPUT=$(info_TEXINFOS) $(imprimatur_TEXINFOS)
include imprimatur.mk
CHECK_DOCS=$(top_srcdir)/@IMPRIMATUR_MODULE_DIR@/check-docs.sh

check-rules:
	@$(CHECK_DOCS) "Makefile rules" \
	'/^imprimatur-.*:/s/:.*//p' \
	's/@deffn {Makefile Rule}  *//p' \
	imprimatur.mk -- \
	$(MAKEINFO) $(AM_MAKEINFOFLAGS) $(MAKEINFOFLAGS) -I $(srcdir) -E - \
		$(info_TEXINFOS) 

check-macros:
	@$(CHECK_DOCS) "Texinfo macros" \
	'/@macro/s/@macro  *\([-a-zA-Z][-a-zA-Z0-9]*\).*/\1/p' \
	'/@defmac/s/@defmac  *\([-a-zA-Z][-a-zA-Z0-9]*\).*/\1/p' \
	rendition.texi -- \
	$(MAKEINFO) $(AM_MAKEINFOFLAGS) $(MAKEINFOFLAGS) -I $(srcdir) -E - \
		$(info_TEXINFOS) 

check-docs: imprimatur-basic-checks check-rules check-macros

GENDOCS=gendocs.sh 

.PHONY: manual
manual:
	TEXINPUTS=$(srcdir):$(top_srcdir)/build-aux:$(TEXINPUTS) \
	 MAKEINFO="$(MAKEINFO) $(MAKEINFOFLAGS) $(AM_MAKEINFOFLAGS)" \
	 TEXI2DVI="$(TEXI2DVI)" \
         TEXI2HTML="texi2html $(AM_MAKEINFOFLAGS)" \
	 $(GENDOCS) --texi2html imprimatur 'Imprimatur manual'

manual.tar.bz2: manual
	tar cfj manual.tar.bz2 manual

man-tar: manual.tar.bz2
endif