import AccountMonitoring;

EXPORT DATASET(layouts.history) fn_cgm_didupdate(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.didupdate.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.didupdate.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		// For those Portfolio entities having a valid did, we'll join those records using a
		// did pivot only, since the corresponding batch service joins only on a did as well. 
		portfolio_dist_did := distribute(in_portfolio(did != 0),hash64(did)) : INDEPENDENT;
		
		// doxie.Key_Did_Rid (pre-filtered in product_files to only return rid <> did recs)
		Key_Did_Rid := 
			DISTRIBUTED(
			  AccountMonitoring.product_files.header_files.r_doxie_key_rid_did, 
				HASH64(rid)
			);
			
		// doxie.Key_Did_Rid_Split (pre-filtered in product_files to only return rid <> did recs)
		Key_Did_Rid_Split :=
			DISTRIBUTED(
			  AccountMonitoring.product_files.header_files.r_doxie_key_rid_did_split, 
				HASH64(rid)
			);
		
		// Temporary Join Layout
		temp_layout := record
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			in_documents.did;
			typeof(in_portfolio.did) save_did;
			typeof(in_portfolio.bdid) save_bdid;
		end;
		
		// Pivot on DID for each of the did update keys. The ADL Update Batch Service finds
		// matching records strictly by DID, so that is the only pivot we'll use in this CGM.
		
		// join portfolio did to past header did and return current did candidates
		// NOTE: since the rid_did key is already pre-filtered on rid <> did, this will return all
		//         possible candidate changes over time for the input did when compared to the 
		//         filtered transactional rid_did key
		temp_join_did_rid := join(Key_Did_Rid,portfolio_dist_did, 
			left.rid = right.did ,
			transform(temp_layout,
				self.pid  := right.pid,
				self.rid  := right.rid,
				self.hid  := 0,
				self.save_did := right.did,
				self.save_bdid := right.bdid,
				self      := left),
			local);		
		
		// join portfolio did to header did and return current split did candidates
		// NOTE: since the rid_did_split key is already pre-filtered on rid <> did, this will return all
		//         possible candidate changes over time for the input did when compared to the 
		//         filtered transactional rid_did_split key
		temp_join_did_rid_split := join(Key_Did_Rid_Split,portfolio_dist_did, 
			left.rid = right.did ,
			transform(temp_layout,
				self.pid  := right.pid,
				self.rid  := right.rid,
				self.hid  := 0,
				self.save_did := right.did,
				self.save_bdid := right.bdid,
				self      := left),
			local);			
		
		// project current documented did candidates
		temp_project_did_rid_documents := project(in_documents,
																				transform(temp_layout,
																									self.save_did := 0,
																									self.save_bdid := 0,
																									self := left));
			
		// Combine the possibilities from the various pivots.
		temp_all_joins := temp_join_did_rid + 
											temp_join_did_rid_split + 
											temp_project_did_rid_documents;
		
		// Ditribute and Dedup joined candidates
		temp_all_joins_deduped := dedup(sort(distribute(temp_all_joins,
																										hash64(pid,rid,hid)),
																				 pid,rid,hid,did,local),
																		pid,rid,hid,did,local);
			
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
								self.product_mask := AccountMonitoring.Constants.pm_didupdate,
								self.timestamp    := '',
								self.hash_value   := hash64(left.did),
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