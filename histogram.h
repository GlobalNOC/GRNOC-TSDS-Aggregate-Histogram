#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

extern int __get_index( double, double, int, double );
extern int __add_values( double, double, int, SV*, SV* );
