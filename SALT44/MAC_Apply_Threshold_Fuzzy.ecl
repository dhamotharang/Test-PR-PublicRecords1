// This is a fairly naughty macro in that it relies upon significant 'in-leak' of the file infile. Specifically
// 1) Infile must be grouped by the basis
// 2) Infile must contain a field row-cnt which the threshold will be applied too
// 3) Infile must contain a field orig_row_cnt which will also be used in the threshold computation
	export MAC_Apply_Threshold_Fuzzy(infile,thresh,outfile) := MACRO
#uniquename(r)
%r% := RECORD
  infile;
	BOOLEAN exceed_threshold := true;
  END;
	
#uniquename(s)
%s% := DEDUP(TABLE(infile,%r%),TRUE,KEEP(2));
#uniquename(t)
%r% %t%(%s% le,%s% ri) := TRANSFORM
  SELF.exceed_threshold := le.Row_Cnt - ri.Row_Cnt >= thresh OR le.row_cnt = ri.row_cnt AND le.orig_row_cnt - ri.orig_row_cnt >= thresh ;
  SELF := le;
  END;
	
#uniquename(i)
%i% := ROLLUP( %s%, TRUE, %t%(LEFT,RIGHT) );	
  outfile := GROUP( PROJECT( %i%(exceed_threshold),{infile} ) );	
  ENDMACRO;
