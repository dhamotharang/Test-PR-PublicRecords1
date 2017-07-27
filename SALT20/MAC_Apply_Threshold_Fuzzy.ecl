// This is a fairly naughty macro in that it relies upon significant 'in-leak' of the file infile. Specifically
// 1) Infile must be grouped by the basis
// 2) Infile must contain a field row-cnt which the threshold will be applied too
// 3) Infile must contain a field orig_row_cnt which will also be used in the threshold computation
	export MAC_Apply_Threshold_Fuzzy(infile,thresh,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile;
	boolean exceed_threshold := false;
  END;
	
#uniquename(s)
%s% := SORT(TABLE(infile,%r%),Row_Cnt,Orig_Row_Cnt);
#uniquename(t)
%r% %t%(%s% le,%s% ri) := TRANSFORM
  SELF.exceed_threshold := ri.Row_Cnt - le.Row_Cnt >= thresh OR ri.row_cnt = le.row_cnt AND ri.orig_row_cnt - le.orig_row_cnt >= thresh ;
  SELF := ri;
  END;
	
#uniquename(i)
%i% := SORT( ITERATE( %s%, %t%(LEFT,RIGHT) ),-Row_Cnt, - Orig_Row_cnt );	
outfile := GROUP( PROJECT( DEDUP( %i%(exceed_threshold), true ), TRANSFORM({infile},SELF := left) ) );	
  ENDMACRO;
