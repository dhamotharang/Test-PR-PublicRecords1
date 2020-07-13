import AccountMonitoring;

EXPORT DATASET(layouts.history) fn_cgm_bdidupdate(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.bdidupdate.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.bdidupdate.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		// For those Portfolio entities having a valid bdid, we'll join those records using a
		// bdid pivot only, since the corresponding batch service joins only on a bdid as well. 
		portfolio_dist_bdid := distribute(in_portfolio(bdid != 0),hash64(bdid)) : INDEPENDENT;
		
		// Business_Header.Key_Business_Header_RCID (pre-filtered in product_files to only return rcid <> bdid recs)
		Key_RCID := 
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.r_business_header_key_rcid, 
				HASH64(rcid)
			);
			
		// Temporary Join Layout
		temp_layout := record
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			in_documents.bdid;
			typeof(in_portfolio.did) save_did;
			typeof(in_portfolio.bdid) save_bdid;
		end;
		
		// Pivot on BDID for the bdid update key. The Business ADL Update Batch Service finds
		// matching records strictly by BDID, so that is the only pivot we'll use in this CGM.
		
		// join portfolio bdid to past business header bdid and return current bdid candidates
		// NOTE: since the rcid key is already pre-filtered on rcid <> bdid, this will return all
		//         possible candidate changes over time for the input bdid when compared to the 
		//         filtered transactional rcid key
		temp_join_bdid_rcid := join(Key_RCID,portfolio_dist_bdid, 
			left.rcid = right.bdid ,
			transform(temp_layout,
				self.pid  := right.pid,
				self.rid  := right.rid,
				self.hid  := 0,
				self.save_did := right.did,
				self.save_bdid := right.bdid,
				self      := left),
			local);		
		
		// project current documented bdid candidates
		temp_project_bdid_documents := project(in_documents,
																				transform(temp_layout,
																									self.save_did := 0,
																									self.save_bdid := 0,
																									self := left));
			
		// Combine the possibilities from the various pivots.
		temp_all_joins := temp_join_bdid_rcid + 
											temp_project_bdid_documents;
		
		// Ditribute and Dedup joined candidates
		temp_all_joins_deduped := dedup(sort(distribute(temp_all_joins,
																										hash64(pid,rid,hid)),
																				 pid,rid,hid,bdid,local),
																		pid,rid,hid,bdid,local);
			
		// Now create a hash value from only the fields we're interested in 
		// (these are the non *id fields in the temp_layout).
		temp_unrolled_hashes := 
			project(temp_all_joins_deduped,
							transform(layouts.history,
								self.pid          := left.pid,
								self.rid          := left.rid,
								self.hid          := left.hid,
								self.did          := left.save_did,
								self.bdid          := left.save_bdid,
								self.product_mask := AccountMonitoring.Constants.pm_bdidupdate,
								self.timestamp    := '',
								self.hash_value   := hash64(left.bdid),
								self := left
								)); 

		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := rollup(sort(distribute(temp_unrolled_hashes,hash64(pid,rid,hid)),pid,rid,hid,record,local),
			transform(AccountMonitoring.layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left),
			pid,rid,local);

		return temp_rolled_hashes;
END;		