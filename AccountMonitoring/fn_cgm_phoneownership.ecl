﻿IMPORT AccountMonitoring, PhonesInfo, MDR;

EXPORT fn_cgm_phoneownership (
			DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
			DATASET(AccountMonitoring.layouts.documents.phoneownership.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.phoneownership.base),
			AccountMonitoring.i_Job_Config job_config
		) := 
	FUNCTION
	
	//Key Files

	phone_transactions_key := DISTRIBUTED(AccountMonitoring.product_files.PhoneOwnership.key_phones_transaction_dist, HASH64(phone));
	phone_WDNC_key := DISTRIBUTED(AccountMonitoring.product_files.PhoneOwnership.key_phones_WDNC_dist, HASH64(phone));
	phone_type_key := DISTRIBUTED(AccountMonitoring.product_files.Phone.key_phones_type_dist, HASH64(phone));
	phone_lerg6_key := DISTRIBUTED(AccountMonitoring.product_files.Phone.key_Phones_Lerg6_dist, HASH64(npa,nxx,block_id));
	phone_carrier_reference_key := DISTRIBUTED(AccountMonitoring.product_files.Phone.key_carrier_reference_dist, HASH64(ocn));

  temp_layout := RECORD
		in_portfolio.pid;
		in_portfolio.rid;
		UNSIGNED6 hid;
		phone_transactions_key.phone;
		UNSIGNED8 event_start_date;
		UNSIGNED8 event_end_date;
		typeof(in_portfolio.did) save_did;
		typeof(in_portfolio.bdid) save_bdid;
	END;

	temp_layout_metadata := RECORD
	  temp_layout;
		// Data we are getting and hashing from the same key
		phone_transactions_key.transaction_code;
		phone_transactions_key.phone_swap;
		phone_carrier_reference_key.serv;
		phone_carrier_reference_key.line;
	end;


	//Pivot on Phone
	temp_phone_dist := distribute(in_portfolio(phone != ''),hash64(phone));

	set_phone_sources := [MDR.sourceTools.src_PhonesPorted2_iConectiv, 
                          MDR.sourceTools.src_PhonesPorted_iConectiv,
                          MDR.sourceTools.src_Phones_Gong_History_Disconnect, 
                          MDR.sourceTools.src_Phones_Disconnect];

  temp_join_phone_transaction := JOIN(temp_phone_dist, phone_transactions_key,
		LEFT.phone = RIGHT.phone AND RIGHT.source IN set_phone_sources,
		TRANSFORM(temp_layout_metadata,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= 0,
			SELF.save_did		:= LEFT.did,
			SELF.save_bdid	:= LEFT.bdid,
			SELF.phone			:= LEFT.phone,
			SELF.event_start_date	:= RIGHT.transaction_start_dt,
			SELF.event_end_date	:= RIGHT.transaction_end_dt,
			SELF.phone_swap			:= RIGHT.phone_swap,
			SELF := []), LOCAL);


  temp_join_phone_type := JOIN(temp_phone_dist, phone_type_key,
		LEFT.phone = RIGHT.phone,
		TRANSFORM(temp_layout_metadata,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= 0,
			SELF.save_did		:= LEFT.did,
			SELF.save_bdid	:= LEFT.bdid,
			SELF.phone			:= LEFT.phone,
			SELF.event_start_date	:= RIGHT.vendor_first_reported_dt,
		    SELF.event_end_date	:= 0,
			SELF.serv := RIGHT.serv,
			SELF.line := RIGHT.line,
			SELF := []),
		LEFT OUTER, LOCAL);

		temp_layout_lerg6 := record
    temp_layout;
		// Data we are getting and hashing from the same key
		phone_lerg6_key.ocn;
	end;

	temp_phone_lerg_dist := distribute(temp_join_phone_type(event_start_date = 0),hash64(phone[1..3], phone[4..6], phone[7]));
  temp_join_phone_lerg6 := JOIN(temp_phone_lerg_dist, phone_lerg6_key,
		LEFT.phone[1..3] = RIGHT.npa AND LEFT.phone[4..6] = RIGHT.nxx AND LEFT.phone[7] = RIGHT.block_id AND RIGHT.is_current = TRUE,
		TRANSFORM(temp_layout_lerg6,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= LEFT.hid,
			SELF.save_did		:= LEFT.save_did,
			SELF.save_bdid	:= LEFT.save_bdid,
			SELF.phone			:= LEFT.phone,
			SELF.event_start_date	:= 0,
		    SELF.event_end_date	:= 0,
			SELF.ocn						:= RIGHT.ocn), LOCAL);

  temp_phone_lerg6_redist := distribute(temp_join_phone_lerg6,hash64(ocn));

 
  temp_join_phone_carrier_reference := JOIN(temp_phone_lerg6_redist, phone_carrier_reference_key,
		LEFT.ocn = RIGHT.ocn,
		TRANSFORM(temp_layout_metadata,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= LEFT.hid,
			SELF.save_did		:= LEFT.save_did,
			SELF.save_bdid	:= LEFT.save_bdid,
			SELF.phone			:= LEFT.phone,
			SELF.serv						:= RIGHT.serv,
			SELF.line						:= RIGHT.line,
			SELF := []), LOCAL);

	  temp_join_phone_WDNC := JOIN(temp_phone_dist, phone_WDNC_key,
		LEFT.phone = RIGHT.phone AND RIGHT.is_current = TRUE,
		TRANSFORM(temp_layout_metadata,
			SELF.pid 				:= LEFT.pid,
			SELF.rid				:= LEFT.rid,
			SELF.hid				:= 0,
			SELF.save_did		:= LEFT.did,
			SELF.save_bdid	:= LEFT.bdid,
			SELF.phone			:= LEFT.phone,
			SELF.event_start_date	:= RIGHT.dt_first_seen,
			SELF.event_end_date	:= 0,
			SELF.serv						:= RIGHT.phone_type,
			SELF.line						:= RIGHT.phone_type,
			SELF := []), LOCAL);		
		
//Lerg6 is a block file we hit only for phones we do not have a record in the phones type/transaction keys.Which is why we pull records for phones who do not have anything in type/transaction key. The latest records are in these keys.

	metadata_ds := temp_join_phone_transaction(event_start_date != 0) & temp_join_phone_type(event_start_date != 0) & temp_join_phone_carrier_reference & temp_join_phone_WDNC;
																		
	// Combine the possibilities from the various pivots (in this case just one)
	temp_all_joins :=
		metadata_ds;

	// Distribute and dedup joined candidates 
  // Added all monitored fields to sort/dedup since all unique records for a phone will now be used for the hash calc. 
	temp_joins_deduped := 
	dedup(
		sort(
			distribute(
				temp_all_joins,
				hash64(pid,rid, hid)
			),
			pid, rid, hid, phone, event_start_date, -event_end_date, transaction_code, phone_swap,serv, line, local
		),
		pid, rid, hid, phone, event_start_date, event_end_date, transaction_code, phone_swap, serv, line, local
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
						left.event_start_date,					
						left.event_end_date,
						left.transaction_code,
						left.phone_swap,
						left.serv,
						left.line
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