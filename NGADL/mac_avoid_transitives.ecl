export mac_avoid_transitives(ifile,did1,did2,conf,rule_num,ofile) := macro
	// First reduce everything to a move to the 'best' close match
	
	#uniquename(one_only_a)
	%one_only_a% := dedup( sort( distribute( ifile, hash(did1) ), did1, -conf, did2, rule_num, local ), did1, local );
	
	// For a given target only allow one incoming match
	#uniquename(one_only)
	%one_only% := dedup( sort( distribute( %one_only_a%, hash(did2) ), did2, -conf, did1, rule_num, local ), did2, local );

	// Remove all of the 'sources' if they are targetted by someone superior or equal
	#uniquename(j1)
	%j1% := join( %one_only%, %one_only%, left.did1 = right.did2 and left.conf <= right.conf, transform(left), left only, hash );
	
	// Remove all 'targets' if the target is about to shift
	// because of above we know that the target shift is a good thing
	
	ofile := join( %j1%, %j1%, left.did2 = right.did1, transform(left), left only,hash );
	
  
  endmacro;