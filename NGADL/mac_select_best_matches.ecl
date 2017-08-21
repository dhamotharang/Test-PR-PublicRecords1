export mac_select_best_matches(ifile,did1,did2,conf,rule_num,ofile) := macro
	// First reduce everything to a move to the 'best' close match
	
	#uniquename(one_only_a)
	%one_only_a% := dedup( sort( ifile, did1, -conf, did2, rule_num, local ), left.did1=right.did1 and (left.did2=right.did2 or left.conf > right.conf), local );
//	%one_only_a% := dedup( sort( distribute( ifile, hash(did1) ), did1, -conf, did2, rule_num, local ), left.did1=right.did1 and left.conf > right.conf, local );
	
	ofile := %one_only_a%;
  
  endmacro;