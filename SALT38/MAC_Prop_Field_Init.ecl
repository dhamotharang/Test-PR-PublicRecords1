export MAC_Prop_Field_Init(infile,infield,pivot,outfile) := macro
#uniquename(r)
%r% := record
  infile.pivot; 
  unsigned4 cnt := count(group);
	infile.infield;
  end;
	
#uniquename(d)
%d% := table( infile, %r%, pivot, infield, local );
	
#uniquename(d1)
%d1% := dedup( sort( %d%, pivot,-infield,local ), left.pivot=right.pivot and left.infield[1..length(trim(right.infield))]=right.infield, local ); // Remove following if leading substring of former
shared outfile := table(dedup ( sort ( %d1% , pivot, infield[1] ,-cnt, local ), pivot, infield[1], local ),{pivot,infield});
  endmacro;    
  
