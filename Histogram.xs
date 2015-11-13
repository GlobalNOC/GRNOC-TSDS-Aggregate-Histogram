#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include "histogram.h"

MODULE = GRNOC::TSDS::Aggregate::Histogram            PACKAGE = GRNOC::TSDS::Aggregate::Histogram

int
_get_index( bin_size, min, num_bins, value )

  double bin_size;
  double min;
  int num_bins;
  double value;

  CODE:

  int index = __get_index( bin_size, min, num_bins, value );
  
  RETVAL = index;

  OUTPUT:

  RETVAL

int
_add_values( bin_size, min, num_bins, bins_ref, values_ref )

  double bin_size;
  double min;
  int num_bins;
  SV* bins_ref;
  SV* values_ref;

  CODE:

  int total = __add_values( bin_size, min, num_bins, bins_ref, values_ref );

  RETVAL = total;

  OUTPUT:

  RETVAL
