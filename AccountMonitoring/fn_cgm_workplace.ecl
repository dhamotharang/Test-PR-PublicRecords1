import NID, POE, ut;

export DATASET(layouts.history) fn_cgm_workplace(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.workplace.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.workplace.base),
		AccountMonitoring.i_Job_Config job_config
	)
  :=  FUNCTION

		// Base File
	  base_file := product_files.workplace.base_file_slim;

		// Temporary Join Layout
		temp_join_layout := record
			in_portfolio.pid;
			in_portfolio.rid;
			in_portfolio.did;
			in_portfolio.bdid;
			unsigned6 poe_bdid            := 0;
      string120 company_name        := '';
	    string10  company_prim_range  := '';
	    string2   company_predir		  := '';
	    string28  company_prim_name	  := '';
	    string4   company_addr_suffix := '';
	    string2   company_postdir		  := '';
	    string8   company_sec_range	  := '';
	    string25  company_city_name	  := '';
	    string2   company_st				  := '';
	    string5   company_zip				  := '';
	    string4   company_zip4				:= '';
      unsigned5 company_phone       := 0;
		end;

		
		// Pivot on SSN
		temp_port_dist_1 := distribute(in_portfolio(ssn != ''),hash64(ssn));
		temp_base_dist_1 := distribute(base_file(ssn !=''),hash64(ssn));

		temp_join_1 := join(temp_port_dist_1,temp_base_dist_1,
			left.ssn = right.ssn,
			transform(temp_join_layout,
			  // id fields from left portfolio
				self.pid  := left.pid;
				self.rid  := left.rid;
				self.did  := left.did;
				self.bdid := left.bdid;
				// fields to be hashed from right base
				self      := right), 
			local);
		
		// Pivot on LAST NAME and PREFERRED FIRST "PLUS"
		temp_port_dist_2 := distribute(in_portfolio(name_last != ''),hash64(name_last,NID.PreferredFirstNew(name_first)));
		temp_base_dist_2 := distribute(base_file(lname != ''),hash64(lname,NID.PreferredFirstNew(fname)));
		// Plus SSN
		temp_join_2a := join(temp_port_dist_2(ssn != ''),temp_base_dist_2(ssn != ''),
			left.name_last = right.lname and
			NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname) and
			ut.WithinEditN(left.ssn,right.ssn,1),
			transform(temp_join_layout,
			  // id fields from left portfolio
				self.pid  := left.pid;
				self.rid  := left.rid;
				self.did  := left.did;
				self.bdid := left.bdid;
				// fields to be hashed from right base
				self      := right), 
			local);
		
		// Plus PRIM-NAME, PRIM-RANGE and SUFFIX
		temp_join_2b := join(temp_port_dist_2(prim_name != ''),temp_base_dist_2(prim_name != ''),
			left.name_last = right.lname and
			NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname) and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.addr_suffix = right.addr_suffix,
			transform(temp_join_layout,
			  // id fields from left portfolio
				self.pid  := left.pid;
				self.rid  := left.rid;
				self.did  := left.did;
				self.bdid := left.bdid;
				// fields to be hashed from right base
				self      := right), 
			local);
		
		// Pivot on Zip9 "PLUS" 
		temp_port_dist_3 := distribute(in_portfolio(z5 != '' and zip4 != ''),hash64(z5,zip4));
		temp_base_dist_3 := distribute(base_file(zip != '' and zip4 != ''),hash64(zip,zip4));
		temp_join_3 := join(temp_port_dist_3,temp_base_dist_3,
			left.z5 = right.zip and
			left.zip4 = right.zip4 and 
			(
				(left.ssn != '' and right.ssn != '' and
					ut.WithinEditN(left.ssn,right.ssn,1)) 
				or 
				(left.ssn != '' and right.ssn != '' and
					left.prim_name = right.prim_name and
					left.prim_range = right.prim_range and
					left.addr_suffix = right.addr_suffix) 
				or
				(left.name_last != '' and
					metaphonelib.DMetaPhone1(left.name_last)[1..4] = metaphonelib.DMetaPhone1(right.lname)[1..4] and
					NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname))
			),
			transform(temp_join_layout,
			  // id fields from left portfolio
				self.pid  := left.pid;
				self.rid  := left.rid;
				self.did  := left.did;
				self.bdid := left.bdid;
				// fields to be hashed from right base
				self      := right), 
			local);

		// Pivot on did
		temp_port_dist_4 := distribute(in_portfolio(did !=0), hash64(did));
		temp_base_dist_4 := distribute(base_file(did !=0), hash64(did));
													
		temp_join_4 := join(temp_port_dist_4, temp_base_dist_4,
		  left.did = right.did,
			transform(temp_join_layout,
			  // id fields from left portfolio
				self.pid  := left.pid;
				self.rid  := left.rid;
				self.did  := left.did;
				self.bdid := left.bdid;
				// fields to be hashed from right base
				self      := right), 
			local);

 		// Combine the possibilities from the various pivots.
		temp_all_joins :=
			    temp_join_1 
		    + temp_join_2a
				+ temp_join_2b
		    + temp_join_3				
		    + temp_join_4
				;
															
		// Sort/Dedup all joined data by pid/rid/did and all (since data has no unique 
		// product id field) of the fields to be hashed, so as not to double-count. 
    temp_all_sorted := sort(distribute(temp_all_joins,hash64(pid,rid)),
														pid, rid, did, poe_bdid, company_name, company_prim_range, 
														company_predir, company_prim_name, company_addr_suffix, 
														company_postdir, company_sec_range, company_city_name, 
														company_st, company_zip, company_zip4, company_phone, local);
	  temp_all_deduped := dedup(temp_all_sorted,
															pid, rid, did, poe_bdid, company_name, company_prim_range, 
															company_predir, company_prim_name, company_addr_suffix, 
															company_postdir, company_sec_range, company_city_name, 
															company_st, company_zip, company_zip4, company_phone, local); 


		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_join_layout).
		temp_unrolled_hashes := project(temp_all_deduped,
			transform(layouts.history,
				self.hid          := 0,
				self.timestamp    := '',
				self.product_mask := AccountMonitoring.Constants.pm_workplace,
				self.hash_value   := hash64(left.poe_bdid,
				                            left.company_name,        left.company_prim_range,
																		left.company_predir,      left.company_prim_name, 
																		left.company_addr_suffix, left.company_postdir,
																		left.company_sec_range,   left.company_city_name,
																		left.company_st,			    left.company_zip,
																		left.company_zip4,        left.company_phone),
				self := left
				)); 

		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := rollup(temp_unrolled_hashes,
			transform(layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left),
			pid,rid,local);

    // Uncomment lines below as needed for debugging
    //output(temp_join_1,        named('temp_join_1'));
    //output(temp_join_2a,       named('temp_join_2a'));
    //output(temp_join_2b,       named('temp_join_2b'));
    //output(temp_join_3,        named('temp_join_3'));
    //output(temp_join_4,        named('temp_join_4'));
    //output(temp_all_sorted,    named('temp_all_sorted'));
    //output(temp_all_deduped,   named('temp_all_deduped'));

		return temp_rolled_hashes;

end; // end of fn_cgm_workplace function
