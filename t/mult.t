use strict;
use warnings;

use lib './venv/lib/perl5';


use Test::More tests => 20;

use GRNOC::TSDS::Aggregate::Histogram;
use Data::Dumper;

my $twohundredgbps = 200 * (1000 ** 3);
my $resolution = 0.1;

# create a histogram. the data_max is not a perfect power of 10, it has an effective multiplier
# of 2 so we want to make sure that the bin size chosen incorporates that
my $hist = GRNOC::TSDS::Aggregate::Histogram->new( hist_min => undef,
                                                   hist_max => undef,
                                                   data_min => 0,
                                                   data_max => $twohundredgbps,
                                                   min_width => 0.001,
                                                   resolution => $resolution );


# verify initial values of histogram
is( $hist->data_min(), 0, 'data_min' );
is( $hist->data_max(), $twohundredgbps, 'data_max' );
is( $hist->resolution(), 0.1, 'resolution' );
is( $hist->num_bins(), 1000, 'num_bins' );
is( $hist->bin_size(), $twohundredgbps / (100 / $resolution), 'bin_size' ); # bin size should be 200000000, ie best power of 10 * the multipler of 2
is( $hist->total(), 0, 'total' );


# let's add some values into our histogram, this is designed to simulate combining histograms that are
# base 10 ordered but may have different "multipliers" out in front. We might be combining histograms
# for a 10Gbps, 100Gbps, and 200Gbps interface 
$hist->add_values( [150 * (1000 ** 2),
		    1 * (1000 ** 3),
		    5 * (1000 ** 3),
		    5 * (1000 ** 3) + 1234,  # "random" number, should get floored into a bucket correctly
		    10 * (1000 ** 3),    
		    105 * (1000 ** 3),
		    175 * (1000 ** 3),
		    185 * (1000 ** 3),
		    200 * (1000 ** 3),		    
		    ]
    );


my $bins = $hist->bins();


is( $bins->{0}, 1, "1 items in bin 0" );
is( $bins->{5}, 1, "1 items in bin 5" );
is( $bins->{25}, 2, "2 items in bin 25" );
is( $bins->{50}, 1, "1 items in bin 50" );
is( $bins->{525}, 1, "1 items in bin 525" );
is( $bins->{875}, 1, "1 items in bin 875" );
is( $bins->{925}, 1, "1 items in bin 925" );
is( $bins->{999}, 1, "1 items in bin 999" );






# create a histogram with an odd natural resolution, ensure that 
$hist = GRNOC::TSDS::Aggregate::Histogram->new( hist_min => undef,
						hist_max => undef,
						data_min => 0,
						data_max => $twohundredgbps + $twohundredgbps*2.5, # 7 hundred gbps
						min_width => 0.001,
						resolution => $resolution );


# verify initial values of histogram
is( $hist->data_min(), 0, 'data_min' );
is( $hist->data_max(), $twohundredgbps + $twohundredgbps*2.5, 'data_max' );
is( $hist->resolution(), 0.1, 'resolution' );
is( $hist->num_bins(), 3500, 'num_bins' );
is( $hist->bin_size(), $twohundredgbps / (100 / $resolution), 'bin_size' ); # bin size should be 200000000, ie best power of 10 * the multipler of nearest cleanly divisible power of 2
is( $hist->total(), 0, 'total' );
