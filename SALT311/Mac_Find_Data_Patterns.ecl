export mac_find_data_patterns(infile,infield,cntfld,outfile) := macro
  #uniquename(r)
	%r% := record
	  infield  {maxlength(200000)} := SALT311.fn_data_pattern((SALT311.StrType)infile.infield);
		unsigned cnt := infile.cntfld;
	  end;
	#uniquename(t)
	%t% := table(infile,%r%);
  #uniquename(r1)
	%r1% := record
	  %t%.infield;
		unsigned cnt := sum(group,%t%.cnt);
	  end;
	outfile := table(%t%,%r1%,infield,few);
	
  endmacro;
