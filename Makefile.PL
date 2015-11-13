use strict;
use warnings;

use ExtUtils::MakeMaker;

sub MY::postamble { <<'END'; }
rpm:	dist
	rpmbuild -ta GRNOC-TSDS-Aggregate-Histogram-$(VERSION).tar.gz
END

sub MY::test
	{
    q(
TEST_VERBOSE=1

test :	pure_all
	$(FULLPERL) t/TEST $(TEST_VERBOSE)

test_jenkins : pure_all
	$(FULLPERL) t/TEST $(TEST_VERBOSE) --formatter=TAP::Formatter::Console

    );
}

WriteMakefile( NAME => 'GRNOC::TSDS::Aggregate::Histogram',
	       AUTHOR => 'GRNOC Software Engineering <globalnoc@iu.edu>',
	       VERSION_FROM => 'lib/GRNOC/TSDS/Aggregate/Histogram.pm',
	       OBJECT => '$(O_FILES)',
	       PREREQ_PM => {'Math::Round' => 0,
			     'Data::Dumper' => 0,
			     'XSLoader' => 0},
	       BUILD_REQUIRES => {'Test::More' => 0},
	       dist => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
	       clean => { FILES => 'GRNOC-TSDS-Aggregate-Histogram-*' } );
