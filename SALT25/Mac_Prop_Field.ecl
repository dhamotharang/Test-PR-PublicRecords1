export MAC_Prop_Field(infile,infield,pivot,outfile) := macro
#uniquename(r)
%r% := record
  infile.pivot; 
  unsigned4 cnt := count(group);
	infile.infield;
  end;
	
#uniquename(d)
%d% := table( infile, %r%, pivot, infield, local ); // Shame there isn't a grouped table operation
	
shared outfile := table(dedup ( sort ( %d% , pivot, -cnt, local ), pivot, local ),{pivot,infield});
  endmacro;
