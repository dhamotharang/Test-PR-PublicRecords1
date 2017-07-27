export MAC_Filter_Sources(infile, outfile, src_field='src', data_restriction_mask='') := MACRO

import Doxie;

// This macro will be used to conditionally remove records for certain source(s) from an
// input file based upon the contents of a specific field within the input file and 
// based upon the passed-in Data Restriction Mask (DRM).

#uniquename(outfile01)
%outfile01% := infile(NOT doxie.DataRestriction.isHeaderSourceRestricted(src_field, data_restriction_mask));
								 
//output(src_field);
//output(Filter_ECH);

outfile := %outfile01%;

ENDMACRO;
