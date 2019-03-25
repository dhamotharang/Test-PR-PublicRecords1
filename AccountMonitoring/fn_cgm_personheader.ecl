IMPORT AccountMonitoring;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_personheader(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.personheader.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.watercraft.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		// Linkid Key, VehicleV2.Key_Vehicle_linkids.key
		Key_DID := 
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.doxie_key_header_slim, 
				HASH64(did)
			);
	
		// Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			Key_DID.SSN;
			Key_DID.DOB;
			
		END;
		
		// Pivot on did
		temp_port_dist_did  := DISTRIBUTE(in_portfolio(did != 0),HASH64(did));
		
/* 		// Tranform to data layout since only DID key is needed for monitoring
   		temp_join_linkid_rcid := JOIN(Key_DID,temp_port_dist_did,
   																BIPV2.IDmacros.mac_JoinTop3Linkids(),
   																TRANSFORM(temp_layout,
   																	SELF.pid  					:= RIGHT.pid,
   																	SELF.rid  					:= RIGHT.rid,
   																	SELF.hid  					:= RIGHT.hid,
   																	SELF.SSN          := LEFT.SSN;
   																	SELF.DOB 	       := LEFT.DOB;
   																	SELF      			:= RIGHT),
   																LOCAL);		
   		
*/
		temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_port_dist_did,HASH64(pid,rid)),pid,rid,ssn,dob,local),pid,rid,ssn,dob,local);
	 
	 	// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(temp_joins_dedup,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_personheader,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.ssn,
											LEFT.dob),
								SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);
		
		RETURN temp_rolled_hashes;
		
END;