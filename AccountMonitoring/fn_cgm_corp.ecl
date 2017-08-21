IMPORT AccountMonitoring, BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_corp(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.corp.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.corp.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		// *****************************
		//        FILE REFERENCES
		// *****************************

		// Linkid key, Corp2.Key_LinkIDs.corp.key
		Key_Linkids := 
			DISTRIBUTED(
				AccountMonitoring.product_files.corp.corpLinkid_key, 
				HASH64(seleid)
			);
		
		// Main key Corp2.Key_Corp_Corpkey
		Key_Main := 
			DISTRIBUTED(
				AccountMonitoring.product_files.corp.corpKey_key, 
				HASH64(corp_key)
			);
		
		// Temporary Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.corp_key;
		END;
		
		
		// Pivot on Linkids
		temp_port_dist_sele  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
		
		temp_join_linkid_rcid := JOIN(Key_Linkids,temp_port_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  			:= RIGHT.pid,
																	SELF.rid  			:= RIGHT.rid,
																	SELF.hid  			:= 0,
																	SELF.bdid 			:= 0, 
																	SELF.did				:= 0, 
																	SELF.corp_key 	:= LEFT.corp_key;
																	SELF      			:= RIGHT),
																LOCAL);		
																
		// Go get the data to check out	
	
		// Data layout
		temp_data_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			TYPEOF(in_portfolio.did) did;
			TYPEOF(in_portfolio.bdid) bdid;
			Key_Main.corp_key;
			Key_Main.corp_status_desc;
			Key_Main.corp_status_cd;
		end;
		
	  temp_joins_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_linkid_rcid,HASH64(pid,rid)),pid,rid,corp_key,local),pid,rid,corp_key,local);
	  temp_joins_dist := DISTRIBUTE(temp_joins_dedup,HASH64(corp_key));
	 
		corp_data := JOIN(Key_Main,temp_joins_dist,
										LEFT.corp_key = RIGHT.corp_key,
										TRANSFORM(temp_data_layout,
											SELF.pid          		 	:= RIGHT.pid,
											SELF.rid           			:= RIGHT.rid,
											SELF.corp_key      			:= LEFT.corp_key,
											SELF.corp_status_desc 	:= LEFT.corp_status_desc,
											SELF.corp_status_cd			:= LEFT.corp_status_cd,
											SELF               			:= []),
										LOCAL);
		
		// Create hash value on monitored fields. 
		temp_unrolled_hashes := 
			PROJECT(corp_data,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								self.hid          := 0,
								SELF.product_mask := AccountMonitoring.Constants.pm_corp,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.corp_key,
											LEFT.corp_status_desc,
											LEFT.corp_status_cd
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