Name: perl-GRNOC-TSDS-Aggregate-Histogram
Version: 1.0.0
Release: 1%{?dist}
Summary: GRNOC TSDS Aggregate Histogram Library
License: Apache License, Version 2.0
Group: Development/Libraries
URL: http://globalnoc.iu.edu
Source0: GRNOC-TSDS-Aggregate-Histogram-%{version}.tar.gz
BuildRoot: %{_tmppath}/GRNOC-TSDS-Aggregate-Histogram-%{version}-%{release}-root-%(%{__id_u} -n)
Requires: perl >= 5.8.8
Requires: perl(Math::Round)
Requires: perl(XSLoader)
BuildRequires: perl(Test::Simple)
BuildRequires: gcc

%description
This Perl library is used to create histograms used in data aggregation for TSDS.

%prep
%setup -q -n GRNOC-TSDS-Aggregate-Histogram-%{version}

%build
CFLAGS="%{optflags}" %{__perl} Makefile.PL INSTALLDIRS="vendor" PREFIX="%{buildroot}%{_prefix}"
%{__make} %{?_smp_mflags} OPTIMIZE="%{optflags}"

%install
rm -rf $RPM_BUILD_ROOT
make pure_install

# clean up buildroot
find %{buildroot} -name .packlist -exec %{__rm} {} \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644 ,root, root, -)
%{perl_vendorarch}/GRNOC/TSDS/Aggregate/Histogram.pm
%{perl_vendorarch}/auto/GRNOC/TSDS/Aggregate/Histogram/Histogram.so
