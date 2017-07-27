/*2008-12-16T19:18:13Z (Wendy Ma)
add dob_field
*/
export MAC_format_DOB(infile, dob_field,outfile) := macro
somethingialwasythingkabout := 0;

#uniquename(dobFix)
typeof(infile) %dobFix%(infile l) := transform
	self.dob_field := map(l.dob_field < 10000000 and l.dob_field > 100000 =>l.dob_field * 100,
					 l.dob_field < 100000 and l.dob_field > 1000 =>l.dob_field * 10000,
					 l.dob_field); 	
	self := l
end;

outfile := project(infile, %dobFix%(left));

endmacro;