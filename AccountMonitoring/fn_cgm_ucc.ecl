IMPORT AccountMonitoring, BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_ucc(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.ucc.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.ucc.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION


		// *****************************
		//        FILE REFERENCES
		// *****************************

		// Linkid key, UCCV2.Key_LinkIds.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.ucc.uccLinkid_key, 
				HASH64(seleid)
			);
		
		// Main key UCCV2.Key_Rmsid_Main
		Key_Main := 
			DISTRIBUTED(
				AccountMonitoring.product_files.ucc.uccMain_key, 
				HASH64(tmsid)
			);

		// Temporary Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.tmsid;
		END;
		
		
	// Pivot on Linkids
		temp_port_dist_sele  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
	
		temp_join_linkid_rcid := JOIN(Key_Linkids,temp_port_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  	:= RIGHT.pid,
																	SELF.rid  	:= RIGHT.rid,
																	SELF.hid  	:= 0,
																	SELF.bdid 	:= 0, 
																	SELF.did		:= 0, 
																	SELF.tmsid 	:= LEFT.tmsid;
																	SELF      	:= RIGHT),
																LOCAL);		
																
	// Go get the data to check out	
	
	// Data layout
		temp_data_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.tmsid;
		end;
		
	 temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_linkid_rcid,HASH64(pid,rid)),pid,rid,tmsid,local),pid,rid,tmsid,local);
	 temp_joins_dist := DISTRIBUTE(temp_joins_dedup,HASH64(tmsid));
	 
	 ucc_data := JOIN(Key_Main,temp_joins_dist,
										LEFT.tmsid = RIGHT.tmsid,
										TRANSFORM(temp_data_layout,
											SELF.pid           := RIGHT.pid,
											SELF.rid           := RIGHT.rid,
											SELF.tmsid         := LEFT.tmsid,
											SELF               := []),
										LOCAL);
		
		// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(ucc_data,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_ucc,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.tmsid),
								SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);

		RETURN temp_rolled_hashes;
END;	
