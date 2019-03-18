IMPORT AccountMonitoring;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_personheader(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.personheader.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.watercraft.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		// Linkid Key, VehicleV2.Key_Vehicle_linkids.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.watercraft.waterLinkid_key, 
				HASH64(seleid)
			);
	
		// Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Linkids.watercraft_key;
			Key_Linkids.sequence_key;
			Key_Linkids.state_origin;
		END;
		
		// Pivot on Linkids
		temp_port_dist_sele  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
		
		// Tranform to data layout since only linkid key is needed for monitoring
		temp_join_linkid_rcid := JOIN(Key_Linkids,temp_port_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  					:= RIGHT.pid,
																	SELF.rid  					:= RIGHT.rid,
																	SELF.hid  					:= 0,
																	SELF.bdid 					:= 0, 
																	SELF.did						:= 0, 
																	SELF.watercraft_key := LEFT.watercraft_key;
																	SELF.sequence_key 	:= LEFT.sequence_key;
																	SELF.state_origin 	:= LEFT.state_origin;
																	SELF      			:= RIGHT),
																LOCAL);		
		
		temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_linkid_rcid,HASH64(pid,rid)),pid,rid,watercraft_key,sequence_key,state_origin,local),pid,rid,watercraft_key,sequence_key,state_origin,local);
	 
	 	// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(temp_joins_dedup,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_watercraft,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.watercraft_key,
											LEFT.sequence_key,
											LEFT.state_origin),
								SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);
		
		RETURN temp_rolled_hashes;
		
END;