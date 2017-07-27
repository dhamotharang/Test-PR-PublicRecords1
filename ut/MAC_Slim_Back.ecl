export MAC_Slim_Back(infile, outrec, outfile) := macro

#uniquename(slim)
outrec %slim%(infile l) := transform
	self := l;
end;

outfile := project(infile, %slim%(left));

endmacro;