
IMPORT BatchServices, Header;

EXPORT DATASET(layouts.history) fn_cgm_foreclosure(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.foreclosure.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.foreclosure.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION
		
		// Assign base file(s). See block comment far below for layout definition.																								
		base_file := product_files.foreclosure.base_file_slim;		
		
		// Temporary Join Layout
		temp_layout := record
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			string70 foreclosure_id;
			string10 prim_range;
			string2  predir;
			string28 prim_name;
			string4  addr_suffix;
			string2  postdir;
			string8  sec_range;
			string25 p_city_name;
			string2  st;
			string5  zip;
			string8  recording_date;
			string10 filing_date;
			string3  deed_category;
			string3  document_type;
			unsigned6 did;
			unsigned6 bdid;
		end;

		// Pivot on DID
		temp_port_dist_1 := distribute(in_portfolio(did != 0),hash64(did));
		temp_base_dist_1 := distribute(base_file(name1_did != ''),hash64(name1_did));
		temp_join_1 := join(temp_port_dist_1,temp_base_dist_1,
			left.did = (unsigned6)right.name1_did,
			transform(temp_layout,
				self.pid            := left.pid,
				self.rid            := left.rid,
				self.hid            := 0,
				self.foreclosure_id := RIGHT.foreclosure_id;
				self.prim_range     := RIGHT.situs1_prim_range;
				self.predir         := RIGHT.situs1_predir;
				self.prim_name      := RIGHT.situs1_prim_name;
				self.addr_suffix    := RIGHT.situs1_addr_suffix;
				self.postdir        := RIGHT.situs1_postdir;
				self.sec_range      := RIGHT.situs1_sec_range;
				self.p_city_name    := RIGHT.situs1_p_city_name;
				self.st             := RIGHT.situs1_st;
				self.zip            := RIGHT.situs1_zip;
				self.recording_date := RIGHT.recording_date;
				self.filing_date    := RIGHT.filing_date;
				self.deed_category  := RIGHT.deed_category;
				self.document_type  := RIGHT.document_type;
				self.did            := LEFT.did;
				self.bdid           := LEFT.bdid;
				self                := RIGHT),
			local);
																		
		// Pivot on Address
		temp_port_dist_2 := distribute(in_portfolio(prim_name != ''),HASH64(z5,prim_range,prim_name,addr_suffix,predir));
		temp_base_dist_2 := distributed(base_file(situs1_prim_name != ''),HASH64(situs1_zip,situs1_prim_range,situs1_prim_name,situs1_addr_suffix,situs1_predir));
		temp_join_2 := join(temp_port_dist_2,temp_base_dist_2,
			left.z5          = right.situs1_zip and
			left.prim_name   = right.situs1_prim_name and
			left.prim_range  = right.situs1_prim_range and
			left.addr_suffix = right.situs1_addr_suffix and
			left.predir      = right.situs1_predir,
			transform(temp_layout,
				self.pid            := left.pid,
				self.rid            := left.rid,
				self.hid            := 0,
				self.foreclosure_id := RIGHT.foreclosure_id,
				self.prim_range     := RIGHT.situs1_prim_range,
				self.predir         := RIGHT.situs1_predir,
				self.prim_name      := RIGHT.situs1_prim_name,
				self.addr_suffix    := RIGHT.situs1_addr_suffix,
				self.postdir        := RIGHT.situs1_postdir,
				self.sec_range      := RIGHT.situs1_sec_range,
				self.p_city_name    := RIGHT.situs1_p_city_name,
				self.st             := RIGHT.situs1_st,
				self.zip            := RIGHT.situs1_zip,
				self.recording_date := RIGHT.recording_date,
				self.filing_date    := RIGHT.filing_date,
				self.deed_category  := RIGHT.deed_category,
				self.document_type  := RIGHT.document_type,
				self.did            := LEFT.did,
				self.bdid           := LEFT.bdid;
				self                := RIGHT),
			local);
				
 		// Combine the possibilities from the various pivots (joins)
		temp_all_joins := temp_join_1 
										+ temp_join_2
											;

		// Dedup by pid/rid & key field (did, tmsid, etc.) so not to double-count
		temp_all_deduped := 
			DEDUP(
				SORT(
					DISTRIBUTE(temp_all_joins,HASH64(pid,rid)),
          pid,rid,foreclosure_id,-recording_date,local
				),
				pid,rid,foreclosure_id,local
			);
	
			
		// Now create a hash value from only the fields we're interested in 
		// (these are the non *id fields in the temp_layout).
		temp_unrolled_hashes := 
			project(temp_all_deduped,
				transform(layouts.history,
					self.pid          := left.pid,
					self.rid          := left.rid,
					self.hid          := left.hid,
					self.did          := left.did,
					self.bdid         := left.bdid,
					self.product_mask := AccountMonitoring.Constants.pm_foreclosure,
					self.timestamp    := '',
					self.hash_value   := HASH64(
						left.foreclosure_id,
						left.prim_range,
						left.predir,
						left.prim_name,
						left.addr_suffix,
						left.postdir,
						left.sec_range,
						left.p_city_name,
						left.st,
						left.zip,
						left.recording_date,
						left.filing_date,
						left.deed_category,
						left.document_type
					))); 
				
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := rollup(sort(distribute(temp_unrolled_hashes,hash64(pid,rid,hid)),pid,rid,hid,record,local),
			transform(layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left),
			pid,rid,local);

		return temp_rolled_hashes;
		
	END;
