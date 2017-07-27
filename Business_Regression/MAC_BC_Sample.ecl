export MAC_BC_Sample(infile, outfile) := macro

#uniquename(bdids)
%bdids% := business_regression.interesting_bdids;

#uniquename(sampleit)
typeof(infile) %sampleit%(infile l) := transform
	self := l;
end;

outfile := join(infile, %bdids%,
								  left.bdid = right.bdid,
									%sampleit%(left), lookup);

endmacro;