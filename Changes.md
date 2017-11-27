## GRNOC::TSDS::Aggregate::Histogram 1.0.1 -- Thu Nov 16 2017

 * ISSUE=2697 Adding the ability to scale the power of 10 by x2 to help with maintaining desired 
accuracy. For example, a 500Mbps may result in a 2M bucket instead of a 1M bucket now. Since things are 
still powers of 10 and 2 the histograms still accurately combine.


## GRNOC::TSDS::Aggregate::Histogram 1.0.0 -- Fri Nov 13 2015


### First Release:

 * ISSUE=12459 use XS instead of Inline::C and package as a standalone library
