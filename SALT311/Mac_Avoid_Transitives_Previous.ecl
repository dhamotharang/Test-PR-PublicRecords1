export mac_avoid_transitives(ifile,did1,did2,conf,dover,rule_num,ofile) := macro
	// First remove the simplest dups
	#uniquename(fc)
	%fc% := DEDUP( SORT( ifile, did1, did2, -conf, rule_num, LOCAL ), did1, did2, LOCAL );
	#uniquename(fc1)
	%fc1% := DEDUP( SORT( DISTRIBUTE( %fc%, HASH(did1) ), did1, did2, -conf, rule_num, LOCAL), did1, did2, LOCAL );
	// First reduce everything to a move to the 'best' close match
	// One of the best for DID 1
	#uniquename(add_reverse)
	%add_reverse% := %fc1% + DISTRIBUTE( project(%fc1%,transform(recordof(ifile),
		self.did1 := left.did2,
		self.did2 := left.did1,
		self := left)), HASH(did1) ); // Output of add_reverse is now distributed by HASH(did1)
		
	//output(%add_reverse%,named('add_reverse'),all);
	
	#uniquename(only_top_conf)
	%only_top_conf% := rollup(sort(%add_reverse%,did1,-conf,did2,rule_num,local),left.did1=right.did1 and (left.conf>right.conf OR left.did2=right.did2),transform(left),local);
	
	//output(sort(%only_top_conf%,did2,did1),named('only_top_conf'),all);
	
	#uniquename(only_mutual)
	%only_mutual% := join(distribute(%only_top_conf%,hash(did2)),distribute(%only_top_conf%,hash(did1)),left.did2=right.did1 and left.did1=right.did2,transform(right),local);
	
	//output(sort(%only_mutual%,did2,did1),named('only_mutual'),all);
	
	#uniquename(only_top_side)
	%only_top_side% := dedup(sort(%only_mutual%(did1 > did2),did1,did2,rule_num,local),did1,did2,local);
	
	//output(sort(%only_top_side%,did2,did1),named('only_top_side'),all);
	
	#uniquename(j0)
	%j0% := dedup(sort(join( %only_top_side%, %only_top_side%, left.did2 = right.did1, transform(left), left only,hash ),did1,-did2),did1);
	
	//output(sort(%j0%,did2,did1),named('j0'),all);
		
	// Remove all of the 'sources' if they are targetted by someone superior or equal
	#uniquename(j1)
	%j1% := join( %j0%, %j0%, left.did1 = right.did2 and left.conf <= right.conf, transform(left), left only, hash );
  //output(sort(%j1%,did2,did1),named('j1'),all);
	
	// Remove all 'targets' if the target is about to shift
	// because of above we know that the target shift is a good thing
	
	//ofile := join( %j1%, %j1%, left.did2 = right.did1, transform(left), left only,hash );
	
	// Test proposed groups to insure all records match to each other
  #uniquename(matchrec)	
	%matchrec% := RECORD
	SALT311.UIDType id1;
	SALT311.UIDType id2;
	SALT311.UIDType targetid; // target did
	//%j1%.conf;
	end;
	
	#uniquename(j2)
	//%j2% := join(%j1%, %j1%, left.did2 = right.did2 and left.did1 <> right.did1, transform(%matchrec%, self.id1 := left.did1, self.id2 := right.did1, self.targetid := left.did2, self.conf := left.conf), hash);
	%j2% := join(%j1%, %j1%, left.did2 = right.did2 and left.did1 <> right.did1, transform(%matchrec%, self.id1 := left.did1, self.id2 := right.did1, self.targetid := left.did2), hash);
	//output(sort(%j2%,targetid),named('j2'),all);
	
	// Join list of group matches to input with reverse to insure matches exist
	// Dedup to get list of ids to exclude from group
	#uniquename(j3)
	//%j3% := dedup(sort(join(%j2%, %add_reverse%, left.id1 = right.did1 and left.id2 = right.did2 and left.conf = right.conf, transform(left), left only, hash),id1),id1);
	%j3% := dedup(sort(join(DISTRIBUTE(%j2%,HASH(id1)), %add_reverse%, left.id1 = right.did1 and left.id2 = right.did2, transform(left), left only, LOCAL),id1,LOCAL),id1,LOCAL);
	//output(sort(%j3%,targetid),named('j3'),all);
	
	// Exclude ids which do not match all records in a group
	#uniquename(j4) 
	%j4% := join(%j1%, %j3%, left.did1 = right.id1 and left.did2 = right.targetid, transform(left), left only, hash);
	//output(sort(%j4%,did2,did1),named('j4'),all);
	
	// Determine if any groups were completely filtered out
	#uniquename(tidrec)
	%tidrec% := RECORD
	SALT311.UIDType target_id; // target did
	end;
	
	// Get the target id matches
	#uniquename(tidlist)
//	%tidlist% := dedup(project(%j1%, transform(%tidrec%, self.target_id := left.did2)),all);
%tidlist% := dedup(sort(project(%j1%, transform(%tidrec%, self.target_id := left.did2)),target_id),target_id);
	//output(sort(%tidlist%,target_id),named('tidlist'),all);
	
	// Make sure all target ids are included
	#uniquename(tidmiss)
	%tidmiss% := join(%tidlist%, %j4%, left.target_id = right.did2, transform(left), left only, hash);
	//output(sort(%tidmiss%,target_id),named('tidmiss'),all);
	
	// Select missing match from target matches
	#uniquename(tidadd)
	%tidadd% := dedup(sort(join(%j1%, %tidmiss%, left.did2 = right.target_id, transform(left), hash), did2, did1), did2);
	//output(sort(%tidadd%,did2,did1),named('tidadd'),all);
	
	ofile := %j4% + %tidadd%;
  
  endmacro;
