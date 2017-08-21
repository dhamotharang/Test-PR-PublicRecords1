IMPORT AccountMonitoring, BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_aircraft(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.aircraft.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.aircraft.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		// Linkid key, SAM.Key_LinkIds.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.aircraft.airLinkid_key, 
				HASH64(seleid)
			);
	
		// Data layout
		temp_data_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Linkids.n_number;
		end;
		
		// Pivot on Linkids
		temp_port_dist_sele  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
		
		// Tranform to data layout since only linkid key for sam data exists
		temp_join_linkid_rcid := JOIN(Key_Linkids,temp_port_dist_sele,
															BIPV2.IDmacros.mac_JoinTop3Linkids(),
															TRANSFORM(temp_data_layout,
																	SELF.pid  			:= RIGHT.pid,
																	SELF.rid  			:= RIGHT.rid,
																	SELF.bdid 			:= 0, 
																	SELF.did				:= 0, 
																	SELF.n_number 	:= LEFT.n_number),
																LOCAL);
	
		temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_linkid_rcid,HASH64(pid,rid)),pid,rid,n_number,local),pid,rid,n_number,local);
	 

		// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(temp_joins_dedup,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_aircraft,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.n_number),
								SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);

		RETURN temp_rolled_hashes;
		
END;