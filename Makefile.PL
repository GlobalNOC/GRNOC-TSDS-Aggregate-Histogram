use ExtUtils::MakeMaker;

WriteMakefile( NAME => 'GRNOC::TSDS::Aggregate::Histogram',
	       VERSION_FROM => 'lib/GRNOC/TSDS/Aggregate/Histogram.pm',
	       OBJECT => '$(O_FILES)' );

