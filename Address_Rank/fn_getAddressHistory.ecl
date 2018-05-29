IMPORT doxie, Header;

EXPORT  fn_getAddressHistory(DATASET(Address_Rank.Layouts.Bestrec) hdr_recs, 
                             unsigned MaxRecordsToReturn = 1) := FUNCTION

	// 2018-06-05 RR-12274/RQ-13834 enhancement to use the Header addr_unique_expanded key via 
	// a new interface(functionmacro), which will take in a dataset of addresses only, 
	// instead of dids.
  //  
  // Project the input ds layout onto a layout with the fields as expected by the interface.
  ds_hdr_recs_temp := PROJECT(hdr_recs,
                              TRANSFORM(Address_Rank.Layouts.bestrec_into_interface,
                                self.dt_first_seen := (unsigned3) left.addr_dt_first_seen;
                                self.dt_last_seen  := (unsigned3) left.addr_dt_last_seen;
                                self               := left;));

  ds_append_addr_ind_recs := Header.Mac_Append_addr_ind(ds_hdr_recs_temp
                                                        // the interface requires that certain
                                                        // params/field names be passed in.  
                                                        , addr_ind
                                                        , //src //not present on input and not needed, has a default in the interface
                                                        , did
                                                        , prim_range
                                                        , prim_name
                                                        , sec_range
                                                        , p_city_name // note input ds field name diff than the interface
                                                        , st 
                                                        , z5 // note input ds field name diff than the interface
                                                        , predir
                                                        , postdir
                                                        , suffix  // note input ds field name diff than the interface
                                                        , dt_first_seen
                                                        , dt_last_seen
                                                        , //dt_vendor_first_reported //not present on input and not needed, has a default in the interface
                                                        , //dt_vendor_last_reported  //not present on input and not needed, has a default in the interface
                                                        , //isTrusted? //not needed, uses the default in the interface
                                                        , //isFCRA?    //not needed, uses the default in the interface
                                                        , //hitQH?     //not needed, uses the default in the interface
                                                        , //debug?     //not needed, uses the default in the interface
                                                       );

  grecs     := GROUP(DEDUP(SORT(ds_append_addr_ind_recs, acctno, did, (unsigned4)addr_ind, 
	                                                                    (unsigned4)best_addr_rank),
	                         acctno, did, (unsigned4)addr_ind),
										 acctno, did);

  topAddrs_raw
            := TOPN(grecs,MaxRecordsToReturn, acctno, did, (unsigned4)addr_ind); //choose the best ranked addresses per acctno/did

  // Project back to return layout to strip off unneeded interface added fields.
	topAddrs	:= PROJECT(topAddrs_raw,
                       TRANSFORM(Address_Rank.Layouts.bestrec,
                         self.address_history_seq := (unsigned4) left.addr_ind; //store interface out addr_ind field in existing field name
                         self := left;));
	
  // Uncomment as needed for debugging, BUT NOTE:
	// ", EXTEND" is needed due to this attribute being called twice via all of the 
	// coding/call paths for certain queries that use it.  i.e. Address_Rank.BatchService, etc.
	// So the output displays may result in some confusing results.
	//OUTPUT(hdr_recs,         named('ar_fgah_hdr_recs'), EXTEND);
	//OUTPUT(ds_hdr_recs_temp, named('ar_fgah_ds_hrtmp'), EXTEND);
	//OUTPUT(ds_append_addr_ind_recs, named('ar_fgah_ds_appai_recs'), EXTEND);
	//OUTPUT(grecs,        named('ar_fgah_grecs'), EXTEND);
	//OUTPUT(topAddrs_raw, named('ar_fgah_topAddrs_raw'), EXTEND);
	//OUTPUT(topAddrs,     named('ar_fgah_topAddrs'), EXTEND);
	
	RETURN topAddrs;
END;