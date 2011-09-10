# imprimatur.m4 serial 1
dnl This file is part of Imprimatur.
dnl Copyright (C) 2011 Sergey Poznyakoff
dnl
dnl Imprimatur is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 3, or (at your option)
dnl any later version.
dnl
dnl Imprimatur is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with Imprimatur.  If not, see <http://www.gnu.org/licenses/>.

# IMPRIMATUR_INIT([DIR],[RENDITION])
# DIR       - Directory in the source tree where imprimatur has been cloned.
#             Default is "imptimatur".
# RENDITION - Documentation rendition.  Default is DISTRIB for stable releases
#             and PROOF for alpha releases.  The release type is determined by
#             the version number, assuming GNU versioning.
AC_DEFUN([IMPRIMATUR_INIT],[
 m4_pushdef([imprimaturdir],[m4_if([$1],,[imprimatur],[$1])])
 AC_SUBST([IMPRIMATUR_MODULE_DIR],imprimaturdir)
 AC_CONFIG_FILES(imprimaturdir[/Makefile])
 AC_SUBST(RENDITION)
 m4_if([$2],,[
  # Doc hints.
  # Select a rendition level:
  #  DISTRIB for stable releases (at most one dot in the version number)
  #  and maintenance releases (two dots, patchlevel < 50)
  #  PROOF for alpha releases.
  #  PUBLISH can only be required manually when running make in doc/
  case `echo $VERSION|sed  's/[[^.]]//g'` in
  ""|".")  RENDITION=DISTRIB;;
  "..")  if test `echo $VERSION | sed  's/.*\.//'` -lt 50; then
	   RENDITION=DISTRIB
         else
           RENDITION=PROOF
         fi;;
  *)     RENDITION=PROOF;;
  esac
 ],[
  RENDITION=$2
 ])
 AC_SUBST([IMPRIMATUR_MAKEINFOFLAGS],
          ['-I $(top_srcdir)/imprimaturdir -D $(RENDITION)'])
 m4_popdef([imprimaturdir])
])
