EXPORT MAC_Prop_Field(infile,infield,pivot,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile.pivot; 
  UNSIGNED4 cnt := COUNT(GROUP);
	infile.infield;
  end;
	
#uniquename(d)
%d% := TABLE( infile, %r%, pivot, infield, LOCAL ); // Shame there isn't a grouped table operation
	
SHARED outfile := TABLE(DEDUP ( SORT ( %d% , pivot, -cnt, LOCAL ), pivot, LOCAL ),{pivot,infield}) : ONWARNING(1048,IGNORE);
  ENDMACRO;
