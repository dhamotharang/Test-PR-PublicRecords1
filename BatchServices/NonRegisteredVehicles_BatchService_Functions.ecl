IMPORT AddrBest, doxie, Header, ut;

EXPORT NonRegisteredVehicles_BatchService_Functions := MODULE

	// This function gets the previous address (the one immediately preceeding the current
	// address) if one exists, for each input acctno & did.
	// If only 1 address exists for a did, then no previous address info is returned.
  //
	// NOTE: This was designed to be used by batch services, so unique acctno(s) are needed 
	// in the input along with the did(s).  
	// Each acctno could have 1 or more dids associated to it.
	
	export GetPrevAddr_for_DID(dataset(doxie.layout_references_acctno) ds_in_dids_wacctno) 
	       := function 

    layout_key_header_wacctno := record
      ds_in_dids_wacctno.acctno;
		  recordof(doxie.Key_Header);
		end;
		
		// Get all the header recs for the dids
		ds_hdr_recs_for_dids := join(ds_in_dids_wacctno,doxie.Key_Header,
		                               keyed(left.did = right.s_did),
																 transform(layout_key_header_wacctno,
																   // acctno from left (input)
																   self.acctno := left.acctno;
																   // rest of fields from right
															     self := right; 
																 ),
																 inner, // only keep recs from left that match to right
																 keep(BatchServices.NonRegisteredVehicles_BatchService_Constants.KEEP_LIMIT_HDR),
																 limit(BatchServices.NonRegisteredVehicles_BatchService_Constants.JOIN_LIMIT_UNLMTD));

  // Check/clean the header records that were acquired.
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
  glb_ok :=  mod_access.isValidGLB ();
  dppa_ok := mod_access.isValidDPPA ();
	Header.MAC_GlbClean_Header(ds_hdr_recs_for_dids,ds_hdr_recs_outglbclean, , , mod_access);

  layout_hdr_recs_clnd := recordof(ds_hdr_recs_outglbclean);

  // Sort the remaining recs in order needed for rollup.
	ds_hdr_recs_sorted := sort(ds_hdr_recs_outglbclean,
	                           acctno,did,zip,prim_name,prim_range,sec_range, record); 

  // Rollup all the recs for a specific address for an acctno/did to determine 
	// the earliest dt_first_seen and latest dt_last_seen for the address.
 	layout_hdr_recs_clnd rollup_xform(layout_hdr_recs_clnd l, layout_hdr_recs_clnd r) := transform
	  // accumulate the date range info
		self.dt_last_seen  := MAX(r.dt_last_seen,l.dt_last_seen);
		self.dt_first_seen := ut.min2(r.dt_first_seen,l.dt_first_seen); 
   	self               := l;
		self               := []; 
 	end;

  ds_hdr_recs_rolled := rollup(ds_hdr_recs_sorted,
	                               // TBD, rollup conditions may need revised to handle recs 
																 // for the same address, where certain addr parts are 
																 // missing.
															   left.acctno     = right.acctno     and
	                               left.did        = right.did        and
                                 left.zip        = right.zip        and
                                 left.prim_name  = right.prim_name  and
	                               left.prim_range = right.prim_range and
		                             //left.sec_range  = right.sec_range  //ver1
																 // check sec_ranges equal or 1 is blank
																 ut.nneq(left.sec_range, right.sec_range)
																 , 
															 rollup_xform(left, right));

	 // Sort to put all the rolled recs for an acctno/did into reverse chron order. 
	 // Then dedup to keep up to 2 recs, the most recent 1 (current) and 
	 // the 1 before that (previous).
   ds_hdr_recs_rolld_srtd_dedupd := dedup(sort(ds_hdr_recs_rolled,
	                                             acctno,did,-dt_last_seen,-dt_first_seen,record),
																	        acctno,did,keep(2));

   // Use "HAVING" function to only include groups(acctnos/dids) with more than 1 record.
   ds_hdr_recs_rsd_2addrecs := having(group(ds_hdr_recs_rolld_srtd_dedupd,acctno,did),
														          count(rows(left)) > 1);

	 // Only keep the previous address (the 2nd rec) for each acctno/did in the ds above. 
	 // Re-sort to put the oldest record for the acctno/did (the previous address) first. 
	 // Then dedup to only keep that one.
   ds_prev_addrs_for_dids := dedup(sort(ds_hdr_recs_rsd_2addrecs,
	                                      acctno,did,dt_last_seen,dt_first_seen,record),
																	 acctno,did);		


   // Uncomment lines below as needed for debugging.   
	 //OUTPUT(ds_in_dids_wacctno,            NAMED('ds_in_dids_wacctno'));
	 //OUTPUT(ds_hdr_recs_for_dids,          NAMED('ds_hdr_recs_for_dids'));
   //OUTPUT(ds_hdr_recs_outglbclean,       NAMED('ds_hdr_recs_outglbclean'));
   //OUTPUT(ds_hdr_recs_sorted,            NAMED('ds_hdr_recs_sorted'));
   //OUTPUT(ds_hdr_recs_rolled,            NAMED('ds_hdr_recs_rolled'));
   //OUTPUT(ds_hdr_recs_rolld_srtd_dedupd, NAMED('ds_hdr_recs_rolld_srtd_dedupd'));
	 //OUTPUT(ds_hdr_recs_rsd_2addrecs,      NAMED('ds_hdr_recs_rsd_2addrecs'));	
	 
	 return ds_prev_addrs_for_dids;
		
	end; // end of GetPrevAddr_for_DID function
	
	
	export GetRankedAddrBest(dataset(doxie.layout_best) in_recs) := function 

		AddrBest.Layout_BestAddr.Batch_in makeAddrBestBatch(doxie.layout_best L, unsigned c) := transform
			self.acctno := (string)c;
			self.name_first := L.fname;
			self.name_middle := L.mname;
			self.name_last := L.lname;
			self.p_city_name := L.city_name;
			self.z5 := L.zip;
			self.dob := (string)L.dob;
			self := L;
			self := [];
		end;
		addrBest_batch := project(in_recs, makeAddrBestBatch(left, counter));
						
		addrBest_mod := module(AddrBest.Iparams.SearchParams) 
			export IncludeBlankDateLastSeen := TRUE;
			export IncludeRanking 					:= TRUE; //automatically applied to GOV applications to always get best ranked addr
		end;
		addrBest := AddrBest.Records(addrBest_batch, addrBest_mod).best_records;
		
		best_join := join(in_recs, addrBest,
									left.did = right.did,
									transform(recordof(in_recs),
									self.did  				:= left.did;
									self.prim_range   := right.prim_range,
									self.predir		    := right.predir,
									self.prim_name    := right.prim_name,
									self.suffix		    := right.suffix,
									self.postdir	    := right.postdir,
									self.unit_desig   := right.unit_desig,
									self.sec_range    := right.sec_range,
									self.city_name    := right.p_city_name,
									self.st				    := right.st,
									self.zip			    := right.z5,
									self.addr_dt_last_seen  := (unsigned)right.addr_dt_last_seen,
									self := left), left outer, limit(0),keep(1));
	
		return dedup(sort(best_join,did,record),did,record);
	end; // end of GetGOVBestAddr

END; // end of Functions module