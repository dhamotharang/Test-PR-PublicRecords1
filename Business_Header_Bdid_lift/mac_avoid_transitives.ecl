export mac_avoid_transitives(ifile,did1,did2,conf,dover,rule_num,ofile) := macro
	// First reduce everything to a move to the 'best' close match
	// One of the best for DID 1
	#uniquename(one_only_a)
	%one_only_a% := dedup( sort( ifile, did1, -conf, did2, rule_num, local ), left.did1=right.did1 and (left.conf > right.conf or left.did2=right.did2), local );
	
	// For a given target only allow one incoming match; only choosing between potential bests
	#uniquename(one_only_b)
	%one_only_b% := dedup( sort( distribute( %one_only_a%, hash(did2) ), did2, -conf, -dover, did1, rule_num, local ), did2, local );
	// Make sure no did1 has two bests (still)
	#uniquename(one_only)
	%one_only% := dedup( sort( distribute( %one_only_b%, hash(did1) ), did1, -conf, -dover, did2, rule_num, local ), did1, local );

	// Remove all of the 'sources' if they are targetted by someone superior or equal
	#uniquename(j1)
	%j1% := join( %one_only%, %one_only%, left.did1 = right.did2 and left.conf <= right.conf, transform(left), left only, hash );
	
	// Remove all 'targets' if the target is about to shift
	// because of above we know that the target shift is a good thing
	
	ofile := join( %j1%, %j1%, left.did2 = right.did1, transform(left), left only,hash );
	
  
  endmacro;