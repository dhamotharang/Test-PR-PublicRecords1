EXPORT mac_convert_util_type(infile, outfile) := macro

//replace util_type from ‘3’ to ‘Z’ b/c we keep the original value in util type in base file.

outfile := project(infile, transform(recordof(infile), 
self.util_type := stringlib.stringfindreplace(left.util_Type, '3', 'Z'), self := left));

endmacro;

