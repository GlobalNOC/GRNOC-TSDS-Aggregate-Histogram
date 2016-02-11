#include <stdlib.h>
#include "./histogram.h"

int __get_index( double bin_size, double min, int num_bins, double value ) {

  // scale the value to be zero-based from the minimum value
  value -= min;
  
  // determine next lowest multiple
  double nlowmult = bin_size * floor( value / bin_size );
  
  int index = nlowmult / bin_size;

  // prevent negative zero
  if ( index == 0 || index < 0 ) {
    
    index = 0;
  }
  
  else if ( index >= num_bins ) {
    
    index--;
  }

  return index;
}

int __add_values( double bin_size, double min, int num_bins, SV* bins_ref, SV* values_ref ) {

  // convert from hash ref to hash
  HV* bins = (HV *) SvRV( bins_ref );
  
  // convert from array ref to array
  AV* values = (AV *) SvRV( values_ref );
  
  // determine length of the array
  I32 len = av_len( values ) + 1;
  
  int total = 0;
  int i;
  
  for ( i = 0; i < len; i++ ) {
    
    // get next scalar item from array
    SV** item = av_fetch( values, i, 0 );

    // skip undef values, they don't fit in the histogram
    if (! SvOK( *item ) ){
      continue;
    }

    // convert scalar to double
    double value = SvNV( *item );   
  
    int index = __get_index( bin_size, min, num_bins, value );
    
    // convert index to string for hash key
    char str[128];
    sprintf( str, "%d", index );
    
    // we haven't seen this index before
    if ( !hv_exists( bins, str, strlen( str ) ) ) {
      
      // create its bin entry and initialize its count to one
      (void) hv_store( bins, str, strlen( str ), newSViv( 1 ), 0 );
    }
    
    // increment bin value count
    else {
      
      // grab the existing bin entry
      SV** old = hv_fetch( bins, str, strlen( str ), 0 );
      
      // increment it by one
      sv_inc( *old );
    }
    
    total++;
  }

  return total;
}
