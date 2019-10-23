/*
This macro takes infile in the {STRING child1|chiled2|...childn',INTEGER2 weight100} format,
blanks out one child based on the child_index, and assigns min weights to unique patterns
*/
EXPORT MAC_Select_Min_Weights(infile,infield,infield_weight,wc,child_index) := FUNCTIONMACRO
	TYPEOF(infile) blank_child(infile le) := TRANSFORM
	  SELF.infield := SALT311.BlankNthWord(le.infield, child_index, wc, '|');
		SELF.infield_weight := le.infield_weight;
	END;
	infile0 := PROJECT(infile,blank_child(LEFT));
  R := RECORD
		infile0.infield; 
		infield_weight := MIN(GROUP, infile0.infield_weight);
  END;
	RETURN TABLE(infile0, R, infield, MERGE);
ENDMACRO;
