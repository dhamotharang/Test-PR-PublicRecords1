IMPORT doxie, Header;

EXPORT  fn_getAddressHistory(DATASET(Address_Rank.Layouts.Bestrec) hdr_recs, 
                             unsigned MaxRecordsToReturn = 1) := FUNCTION

	// Instead of using the header addr_rank key, use a new key via an interface/function, 
	// which will take in a dataset of dids only.
	ds_hdr_recs_did_dd := DEDUP(SORT(PROJECT(hdr_recs,doxie.layout_references),did),did);

	ds_append_addr_ind_recs := Header.Append_addr_ind(ds_hdr_recs_did_dd);
	
  Address_Rank.Layouts.Bestrec_ext getAddrs(hdr_recs l, ds_append_addr_ind_recs r) := TRANSFORM
		SELF.address_history_seq := (unsigned4) r.addr_ind; //store new key ind field in existing field
		SELF.best_addr_rank := r.best_addr_rank;
		SELF := l;
		SELF := [];
	END;

	jrecs   	:= JOIN(hdr_recs, ds_append_addr_ind_recs,
										  LEFT.did 	= RIGHT.did                 AND
									    LEFT.prim_range 	= RIGHT.prim_range 	AND
									    LEFT.predir 			= RIGHT.predir 			AND
									    LEFT.prim_name 		= RIGHT.prim_name 	AND
											LEFT.suffix 			= RIGHT.addr_suffix	AND
									    LEFT.postdir 			= RIGHT.postdir 		AND
									    LEFT.sec_range 		= RIGHT.sec_range 	AND
									    LEFT.z5 					= RIGHT.zip
											,
									  getAddrs(LEFT, RIGHT), 
									  LIMIT(0), KEEP(MaxRecordsToReturn),INNER) ;                                                                                                               

	grecs   	:= GROUP(DEDUP(SORT(jrecs, acctno, did,address_history_seq,best_addr_rank),
	                         acctno, did,address_history_seq),
										 acctno, did);	

	topAddrs_raw
	          := TOPN(grecs,MaxRecordsToReturn, acctno, did, address_history_seq);		//choose the best ranked addresses per acctno
  
	//Project back to return layout to strip off 2 addr_unique_key fields from the interim layout
	topAddrs	:= PROJECT(topAddrs_raw, Address_Rank.Layouts.bestrec);
	
  // Uncomment as needed for debugging
	// ", EXTEND" added due to compiler error, but displays confusing results	when running the query
	//OUTPUT(hdr_recs, named('ar_fgah_hdr_recs'), EXTEND);
	//OUTPUT(jrecs,    named('ar_fgah_jrecs'), EXTEND);
	//OUTPUT(grecs,    named('ar_fgah_grecs'), EXTEND);
	
	RETURN topAddrs;
END;