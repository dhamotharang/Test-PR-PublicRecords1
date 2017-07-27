export MAC_Prop_Field_Init(infile,infield,pivot,outfile) := macro
// very similar to MAC_Prop_Field - possibly I should find some schmanzy way to common them up - some day
#uniquename(r)
%r% := record
  typeof(infile.pivot) pivot := max(group,infile.pivot);
  unsigned4 cnt := count(group);
	typeof(infile.infield) infield := max(group,infile.infield);
  end;
	
#uniquename(d)
%d% := dedup( sort( infile, -infield ), left.infield[1..length(trim(right.infield))]=right.infield ); // Remove following if leading substring of former
	
outfile := table ( %d% , %r% )(cnt=1); // Implicitely grouped by pivot

  endmacro;