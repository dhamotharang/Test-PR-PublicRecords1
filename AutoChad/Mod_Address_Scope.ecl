import header,doxie,ut;
export Mod_Address_Scope(dataset(header.Layout_MatchCandidates) le) := module

  r := record
	  le.prim_range;
	  le.prim_name;
	  le.zip;
		le.city_name;
		le.st;
		le.lname;
		le.fname;
	  end;
		
	t := dedup( table(le(prim_name<>'',zip<>''),r), whole record, all );
  export values := t;
	addr_didrecs := join(values,doxie.Key_Address,keyed(left.prim_range=right.prim_range) and 
	keyed(left.prim_name=right.prim_name) and 
	keyed(right.city_code in doxie.Make_CityCodes(left.city_name).rox ) and
	keyed(left.st=right.st) and
	left.zip=right.zip,transform(right),
	limit(ut.limits.default, skip));
  addr_recs := join(dedup(addr_didrecs,did,all),doxie.Key_Header,left.did=right.s_did,transform(right), limit(ut.limits.HEADER_PER_DID, skip));


	addr_recs_only := join(addr_recs,values,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.zip=right.zip
	                                        and left.fname=right.fname and left.lname=right.lname,transform(left));
	export records := dedup(addr_recs_only,whole record, all);
  end;