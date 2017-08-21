IMPORT AccountMonitoring, BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_mvr(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.mvr.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.mvr.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
		
		// *****************************
		//        FILE REFERENCES
		// *****************************

		// Linkid Key, VehicleV2.Key_Vehicle_linkids.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.mvr.mvrLinkid_key, 
				HASH64(seleid)
			);
		
		// Main key VehicleV2.Key_Vehicle_Main_Key
		Key_Main := 
			DISTRIBUTED(
				AccountMonitoring.product_files.mvr.main_key, 
				HASH64(vehicle_key)
			);
		
		// Temporary Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.vehicle_key;
			Key_Main.iteration_key;
		END;
		
		
		// Pivot on Linkids
		temp_port_dist_sele  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
		
		temp_join_linkid_rcid := JOIN(Key_Linkids,temp_port_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  					:= RIGHT.pid,
																	SELF.rid  					:= RIGHT.rid,
																	SELF.hid  					:= 0,
																	SELF.bdid 					:= 0, 
																	SELF.did						:= 0, 
																	SELF.vehicle_key 		:= LEFT.vehicle_key;
																	SELF.iteration_key 	:= LEFT.iteration_key;
																	SELF      			:= RIGHT),
																LOCAL);		
																
		// Go get the data to check out	
	
		// Data layout
		temp_data_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.vehicle_key;
		END;
		
	  temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_linkid_rcid,HASH64(pid,rid)),pid,rid,vehicle_key,local),pid,rid,vehicle_key,local);
	  temp_joins_dist := DISTRIBUTE(temp_joins_dedup,HASH64(vehicle_key));
	 
		mvr_data := JOIN(Key_Main,temp_joins_dist,
										LEFT.vehicle_key = RIGHT.vehicle_key,
										TRANSFORM(temp_data_layout,
											SELF.pid          		 	:= RIGHT.pid,
											SELF.rid           			:= RIGHT.rid,
											SELF.vehicle_key      	:= LEFT.vehicle_key,
											SELF               			:= []),
										LOCAL);
		
		// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(mvr_data,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_mvr,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.vehicle_key
											),
								SELF := LEFT)); 
		
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);

		RETURN temp_rolled_hashes;
		
END;