export mac_avoid_transitives(ifile,did1,did2,conf,dover,rule_num,ofile) := macro
	// First reduce everything to a move to the 'best' close match
	// One of the best for DID 1
	#uniquename(add_reverse)
	%add_reverse% := ifile + project(ifile,transform(recordof(ifile),
		self.did1 := left.did2,
		self.did2 := left.did1,
		self := left));
		
	//output(%add_reverse%);
	
	#uniquename(only_top_conf)
	%only_top_conf% := rollup(sort(distribute(%add_reverse%,hash(did1)),did1,-conf,did2,rule_num,local),left.did1=right.did1 and (left.conf>right.conf OR left.did2=right.did2),transform(left),local);
	
	//output(%only_top_conf%);
	
	#uniquename(only_mutual)
	%only_mutual% := join(distribute(%only_top_conf%,hash(did2)),distribute(%only_top_conf%,hash(did1)),left.did2=right.did1 and left.did1=right.did2,transform(right),local);
	
	//output(%only_mutual%);
	
	#uniquename(only_top_side)
	%only_top_side% := dedup(sort(%only_mutual%(did1 > did2),did1,did2,rule_num,local),did1,did2,local);
	
	//output(%only_top_side%);
	#uniquename(j0)
	%j0% := dedup(sort(join( %only_top_side%, %only_top_side%, left.did2 = right.did1, transform(left), left only,hash ),did1,-did2),did1);
	
	//output(%j0%);
		
	// Remove all of the 'sources' if they are targetted by someone superior or equal
	#uniquename(j1)
	%j1% := join( %j0%, %j0%, left.did1 = right.did2 and left.conf <= right.conf, transform(left), left only, hash );
	
	// Remove all 'targets' if the target is about to shift
	// because of above we know that the target shift is a good thing
	
	// ofile := join( %j1%, %j1%, left.did2 = right.did1, transform(left), left only,hash );
	ofile := %j1%;
  
  endmacro;
