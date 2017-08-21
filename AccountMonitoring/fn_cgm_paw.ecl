import paw;
 
EXPORT DATASET(layouts.history) fn_cgm_paw(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.paw.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.paw.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
	
		base_file_b := product_files.people_at_work.base_file_b;
		temp_layout := record
			base_file_b.did;
			base_file_b.company_name;
			base_file_b.score;
			base_file_b.dt_last_seen;
		end;
		base_file := project(base_file_b, temp_layout);
		temp_join_layout := record
				in_portfolio.pid;
				in_portfolio.rid;
				unsigned6 did  := 0;
				unsigned6 bdid := 0;
				STRING120 company_name;
		end;
		
		// Pivot on did
		temp_port_dist_1 := distribute(in_portfolio(did <> 0), hash32(did));
		temp_base_dist_1 := dedup(
													sort(distribute(base_file, hash32(did)),
			did, -dt_last_seen, -score,
														local),
													did, local);
													
		temp_join_1 := join(temp_port_dist_1, temp_base_dist_1,
			left.did = right.did,
			transform(temp_join_layout,
					SELF.pid          := left.pid;
					SELF.rid          := left.rid;
					SELF.did          := left.did;
					SELF.bdid         := left.bdid;
					SELF.company_name := right.company_name),
			local);
		// Pivot on company name 
		temp_port_dist_2 := distribute(in_portfolio(comp_name != ''), hash32(comp_name[1..20]));
		temp_base_dist_2 := dedup(
													sort(distribute(base_file, hash32(company_name[1..20])),
														company_name, -dt_last_seen, -score,
														local),
													company_name, local);
													
		temp_join_2 := join(temp_port_dist_2, temp_base_dist_2,
			left.comp_name != '' and 
			left.comp_name[1..20] = right.company_name[1..20],
			transform(temp_join_layout,
					SELF.pid          := left.pid;
					SELF.rid          := left.rid;
					SELF.did          := left.did;
					SELF.bdid         := left.bdid;
					SELF.company_name := right.company_name),
			local);
		
		// Combine the possibilities from the various pivots (joins)
		temp_all_joins := temp_join_1 
										+ temp_join_2
										;
		temp_all_deduped := dedup(sort(distribute(temp_all_joins,hash64(pid,rid)),
																	 pid,rid,did,company_name,local),
															pid,rid,did,company_name,local);
		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		temp_unrolled_hashes := project(temp_all_deduped,
			transform(layouts.history,
				self.hid          := 0,
				self.timestamp    := '',
				self.product_mask := AccountMonitoring.Constants.pm_paw,
				self.hash_value   := hash64(left.company_name),
				self := left
				)); 
					
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := rollup(temp_unrolled_hashes,
			transform(layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left),
			pid,rid,local);
				
		return temp_rolled_hashes;
		
	end;