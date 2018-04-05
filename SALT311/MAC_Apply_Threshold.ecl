// This is a fairly naughty macro in that it relies upon significant 'in-leak' of the file infile. Specifically
// 1) Infile must be grouped by the basis
// 2) Infile must contain a field row-count which the threshold will be applied too
export MAC_Apply_Threshold(infile,thresh,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile;
	boolean exceed_threshold := false;
  END;
	
#uniquename(s)
%s% := SORT(TABLE(infile,%r%),Row_Cnt);
#uniquename(t)
%r% %t%(%s% le,%s% ri) := TRANSFORM
  SELF.exceed_threshold := ri.Row_Cnt - le.Row_Cnt >= thresh;
  SELF := ri;
  END;
	
#uniquename(i)
%i% := SORT( ITERATE( %s%, %t%(LEFT,RIGHT) ),-Row_Cnt );	
outfile := GROUP( PROJECT( DEDUP( %i%(exceed_threshold), TRUE ), TRANSFORM({infile},SELF := left) ) );	
  ENDMACRO;
