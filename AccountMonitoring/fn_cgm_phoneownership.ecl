IMPORT AccountMonitoring, PhonesInfo;

EXPORT fn_cgm_phoneownership (
			DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
			DATASET(AccountMonitoring.layouts.documents.phoneownership.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.phoneownership.base),
			AccountMonitoring.i_Job_Config job_config
		) := 
	FUNCTION
	
	//Key Files
	metadata_key := AccountMonitoring.product_files.PhoneOwnership.key_pphone_dist;
	
	// Temporary Join Layout
	temp_layout := record
		in_portfolio.pid;
		in_portfolio.rid;
		UNSIGNED6 hid;
		metadata_key.phone;
		typeof(in_portfolio.did) save_did;
		typeof(in_portfolio.bdid) save_bdid;
		// Data we are getting and hashing from the same key
		metadata_key.deact_start_dt;	
		metadata_key.account_owner;
		metadata_key.spid;
		metadata_key.serv;
		metadata_key.line;
		metadata_key.dt_last_reported; 
		metadata_key.port_start_dt; 
		metadata_key.swap_start_dt;
		metadata_key.phone_swap;
		metadata_key.deact_code;
		metadata_key.is_deact;
		metadata_key.source;
	end;
	
	//Pivot on Phone
	temp_phone_dist := distribute(in_portfolio(phone != ''),hash64(phone));

	temp_join_phone := JOIN(temp_phone_dist, metadata_key,
		// KEYED(LEFT.phone = RIGHT.phone),
		LEFT.phone = RIGHT.phone,
		TRANSFORM(temp_layout,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= 0,
			SELF.save_did		:= LEFT.did,
			SELF.save_bdid	:= LEFT.bdid,
			SELF.phone			:= RIGHT.phone,
			SELF						:= RIGHT),
		LOCAL);
																									
	// Combine the possibilities from the various pivots (in this case just one)
	temp_all_joins :=
		temp_join_phone;
		
	// Distribute and dedup joined candidates 
  // Added all monitored fields to sort/dedup since all unique records for a phone will now be used for the hash calc. 
	temp_joins_deduped := 
	dedup(
		sort(
			distribute(
				temp_all_joins,
				hash64(pid,rid, hid)
			),
			pid,rid,hid,phone,deact_start_dt,account_owner,spid,serv,line,dt_last_reported,port_start_dt,swap_start_dt,phone_swap,deact_code,is_deact,source,local
		),
		pid,rid,hid,phone,deact_start_dt,account_owner,spid,serv,line,dt_last_reported,port_start_dt,swap_start_dt,phone_swap,deact_code,is_deact,source,local
	);

	// Now, create a hash value from only those fields we're interested in 
	// (these are the non *id fields in the temp_layout).
	temp_unrolled_hashes := 
		project(temp_joins_deduped,
			transform(AccountMonitoring.layouts.history,
				self.pid 	:= left.pid,
				self.rid 	:= left.rid,
				self.hid 	:= 0,
				self.did 	:= left.save_did,
				self.bdid := left.save_bdid,
				self.timestamp := '',
				self.product_mask := AccountMonitoring.Constants.PM_PHONEOWNERSHIP,
				self.hash_value := 
					hash64(
						left.phone,							
						left.deact_start_dt,  		
						left.account_owner,
						left.spid,
						left.serv,
						left.line,
						left.dt_last_reported,
						left.port_start_dt,
						left.swap_start_dt,
						left.phone_swap,
						left.deact_code,
						left.is_deact,
						left.source
					)
				));

	// Then roll up the hashes for all records for a particular pid/rid.
	temp_rolled_hashes := 
		rollup(
			sort(
				distribute(temp_unrolled_hashes,hash64(pid,rid, hid)),
				pid,rid,hid,record,local
			),
			transform(AccountMonitoring.layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left
			),
			pid,rid,local
		);
	
RETURN temp_rolled_hashes;
END;