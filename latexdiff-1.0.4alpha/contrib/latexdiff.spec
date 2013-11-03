Summary: Diff for LaTeX files
Name: latexdiff
Version: 0.5
Release: 1
License: GPL
Group: Productivity/Publishing/TeX/Utilities
URL: http://www.tug.org/tex-archive/help/Catalogue/entries/latexdiff.html
Source0: %{name}.zip
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
# only required for 'make install-ext'
# Requires: perl-Algorithm-Diff


%description
latexdiff is a Perl script, which compares two latex files and marks
up significant differences between them (i.e. a diff for latex files).
  Various options are available for visual markup using standard latex
packages such as "color.sty". Changes not directly affecting visible
text, for example in formatting commands, are still marked in
the latex source.

(C) 2004 Frederik Tilmann <tilmann@esc.cam.ac.uk>


%prep
%setup -n %{name}


%build
# quick had to adapt the Makefile
%{__mv} Makefile Makefile.old
%{__sed} \
  -e "s;INSTALLPATH = /usr/local;INSTALLPATH = \${DESTDIR}%{_prefix};" \
  -e "s;INSTALLMANPATH = \$(INSTALLPATH)/man;INSTALLMANPATH = \${DESTDIR}%{_mandir};" \
  Makefile.old > Makefile


%install
%{__mkdir_p} $RPM_BUILD_ROOT%{_bindir}
%{__mkdir_p} $RPM_BUILD_ROOT%{_mandir}/man1

%makeinstall


%clean
[ "${RPM_BUILD_ROOT}" != "/" ] && [ -d "${RPM_BUILD_ROOT}" ] && %{__rm} -rf "${RPM_BUILD_ROOT}"


%files
%defattr(-,root,root)
%doc example CHANGES LICENSE README
%{_bindir}/*
%{_mandir}/man*/*

%changelog
* Thu Jan  4 2007 Till Dörges <till@doerges.net> - 0.5-1
- Initial build.
