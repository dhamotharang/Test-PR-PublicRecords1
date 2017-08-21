export mac_find_data_patterns(infile,infield,outfile) := macro
  #uniquename(r)
	%r% := record,maxlength(2048)
	  infield := salt.fn_data_pattern((string)infile.infield);
	  end;
	#uniquename(t)
	%t% := table(infile,%r%);

  #uniquename(r1)
	%r1% := record,maxlength(2048)
	  %t%.infield;
		unsigned cnt := count(group);
	  end;
	outfile := table(%t%,%r1%,infield,few);
	
  endmacro;