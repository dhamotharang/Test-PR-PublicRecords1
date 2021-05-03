
IMPORT ut;
 
EXPORT DATASET(layouts.history) fn_cgm_phonefeedback(
		 DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		 DATASET(AccountMonitoring.layouts.documents.phonefeedback.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.phonefeedback.base),
		 AccountMonitoring.i_Job_Config job_config
		) := 
	FUNCTION
	
		// Timestamp (from WUID)		
		timestamp := thorlib.WUID()[2..9];
		
		// Monitor Files    		
        phonefeedback_key_monitor   := product_files.phonefeedback.PhonesFeedback_key_monitor;
		
		// Temporary Join Layout
		temp_layout := RECORD
			in_portfolio.pid;
			in_portfolio.rid;
			in_portfolio.did;
			in_portfolio.bdid;
         STRING10 phone_number       := '';
			STRING   phone_contact_type := '';
			STRING   feedback_source    := '';
			STRING   date_time_added    := '';
			STRING   customerid         := '';
		END;
		
		// Pivot on did
		temp_port_dist_1 := DISTRIBUTE(in_portfolio(did != 0),HASH64(did));
		temp_join_1 := JOIN(
			DISTRIBUTED(phonefeedback_key_monitor, HASH64(did)),
			temp_port_dist_1,
			LEFT.did = RIGHT.did AND
			(RIGHT.phone = LEFT.phone_number OR RIGHT.phone = ''),
			TRANSFORM(temp_layout,
				SELF.pid  := RIGHT.pid,
				SELF.rid  := RIGHT.rid,
				SELF.did  := RIGHT.did;
				SELF.bdid := 0; // set to zero since this is for people data
				SELF := LEFT),  // take phone feedback fields from the base file
			LOCAL);
					
 		// Combine the possibilities from the various pivots
		temp_all_joins := temp_join_1;

		// Dedup by pid/rid & key field (did, tmsid, etc.) so not to double-count
		temp_all_deduped := 
			DEDUP(
				SORT(
					DISTRIBUTE(temp_all_joins,HASH64(pid,rid)),
		      pid,rid,did,phone_number,RECORD,LOCAL
				),
				pid,rid,did,phone_number,RECORD,LOCAL
			);
															
		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		temp_unrolled_hashes := PROJECT(temp_all_deduped,
			TRANSFORM(layouts.history,
				SELF.hid          := 0,
				SELF.product_mask := AccountMonitoring.Constants.pm_phonefeedback,
				SELF.timestamp    := '',
				SELF.hash_value   := 
					HASH64(     
						LEFT.phone_number,
						LEFT.phone_contact_type,
						LEFT.feedback_source,
						LEFT.date_time_added,
						LEFT.customerid
					),
				SELF := LEFT
				)); 
				
		//Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := ROLLUP(temp_unrolled_hashes,
			TRANSFORM(layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);
		
		RETURN temp_rolled_hashes;
	END;