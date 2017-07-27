IMPORT AccountMonitoring,BankruptcyV2,BatchServices,ut,NID,BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_liens(
		 DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		 DATASET(AccountMonitoring.layouts.documents.liens.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.liens.base),
		 AccountMonitoring.i_Job_Config job_config ) := 
	
	FUNCTION
		
		// LiensV2 Files
		party_file := AccountMonitoring.product_files.liens.party_file;										 
		main_file  := AccountMonitoring.product_files.liens.main_file;
		// FWIW: The strategy will be to use the party_file as the search file, to locate the
		// TMSIDs. Then, use the TMSIDs to find the monitorable fields in the main_file.
		
		// Temporary Join Layout and Transform
		temp_layout := record
			in_portfolio.pid;
			in_portfolio.rid;
			typeof(in_portfolio.did) save_did;
			typeof(in_portfolio.bdid) save_bdid;
			party_file.tmsid;
		end;
		
		temp_layout xfm_preserve_lookup_data(AccountMonitoring.product_files.liens.liens_party_layout l,AccountMonitoring.layouts.portfolio.base r) := 
			transform
				self.pid       := r.pid;
				self.rid       := r.rid;
				self.save_did  := r.did;
				self.save_bdid := r.bdid;
				self.tmsid     := l.tmsid;
			end;
		
		// Pivot on appended SSN (ssn field is worthless...)
		temp_port_dist_1  := distribute(in_portfolio(ssn != ''),hash64(ssn));
		temp_base_dist_1  := distribute(party_file(app_ssn != ''),hash64(app_ssn));
		
		temp_join_1 := join(temp_base_dist_1,temp_port_dist_1,
			left.app_ssn = right.ssn,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on Last Name and Preferred First
		temp_port_dist_2 := distribute(in_portfolio(name_last != ''),hash64(name_last,NID.PreferredFirstNew(name_first)));
		temp_base_dist_2 := distribute(party_file(lname != ''),hash64(lname,NID.PreferredFirstNew(fname)));
		
		// Plus app_SSN
		temp_join_2a := join(temp_base_dist_2(app_ssn != ''),temp_port_dist_2(ssn != ''),
			left.lname = right.name_last and
			NID.PreferredFirstNew(left.fname) = NID.PreferredFirstNew(right.name_first) and
			left.app_ssn != '' and ut.WithinEditN(left.app_ssn,right.ssn,1),
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Plus PRIM-NAME, PRIM-RANGE and SUFFIX
		temp_join_2b := join(temp_base_dist_2(prim_name != ''),temp_port_dist_2(prim_name != ''),
			left.lname = right.name_last and
			NID.PreferredFirstNew(left.fname) = NID.PreferredFirstNew(right.name_first) and
			left.prim_name = right.prim_name and
			left.prim_range = right.prim_range and
			left.addr_suffix = right.addr_suffix,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on Zip9 "PLUS"
		temp_port_dist_3 := distribute(in_portfolio(z5 != '' and zip4 != ''),hash64(z5,zip4));
		temp_base_dist_3 := distribute(party_file(zip != '' and zip4 != ''),hash64(zip,zip4));
		
		temp_join_3 := join(temp_base_dist_3,temp_port_dist_3,
			left.zip = right.z5 and
			left.zip4 = right.zip4 and (
				(
					left.tax_id != '' and right.fein != '' and
					ut.WithinEditN(left.tax_id,right.fein,1)
				) or (
					left.tax_id != '' and right.ssn != '' and
					ut.WithinEditN(left.tax_id,right.ssn,1)
				) or (
					left.app_ssn != '' and right.ssn != '' and
					ut.WithinEditN(left.app_ssn,right.ssn,1)
				) or (
					right.name_last != '' and
					metaphonelib.DMetaPhone1(left.lname)[1..4] = metaphonelib.DMetaPhone1(right.name_last)[1..4] and
					NID.PreferredFirstNew(left.fname) = NID.PreferredFirstNew(right.name_first)) or
				(
					right.comp_name != '' and
					left.cname[1..20] = right.comp_name[1..20])
				),
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on DID
		temp_port_dist_4 := distribute(in_portfolio((unsigned)did != 0),hash64((unsigned)did));
		temp_base_dist_4 := distribute(party_file((unsigned)did != 0),hash64((unsigned)did));
		
		temp_join_4 := join(temp_base_dist_4,temp_port_dist_4,
			(unsigned)left.did = (unsigned)right.did,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on FEIN (TAX_ID)
		temp_port_dist_5a := distribute(in_portfolio(fein != ''),hash64(fein));
		temp_base_dist_5a := distribute(party_file(tax_id != ''),hash64(tax_id));
		
		temp_join_5a := join(temp_base_dist_5a,temp_port_dist_5a,
			left.tax_id = right.fein,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on TAX ID, but use portfolio SSN to try and match.
		temp_port_dist_5b := temp_port_dist_1;
		temp_base_dist_5b := temp_base_dist_5a;
		
		temp_join_5b := join(temp_base_dist_5b,temp_port_dist_5b,
			left.tax_id = right.ssn,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on Company Name
		temp_port_dist_6 := distribute(in_portfolio(comp_name != ''),hash64(comp_name[1..20]));
		temp_base_dist_6 := distribute(party_file(cname != ''),hash64(cname[1..20]));
		
		temp_join_6 := join(temp_base_dist_6,temp_port_dist_6,
			left.cname[1..20] = right.comp_name[1..20] and (
				(
					left.tax_id != '' and right.fein != '' and
					ut.WithinEditN(left.tax_id,right.fein,1)
				) or (
					left.tax_id != '' and right.ssn != '' and
					ut.WithinEditN(left.tax_id,right.ssn,1)
				) or (
					left.p_city_name = right.p_city_name and
					left.st = right.st
				) or (
					left.prim_name = right.prim_name and
					left.prim_range = right.prim_range and
					left.addr_suffix = right.addr_suffix
				) or
				left.zip = right.z5),
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on BDID
		temp_port_dist_7 := distribute(in_portfolio((unsigned)bdid != 0),hash64((unsigned)bdid));
		temp_base_dist_7 := distribute(party_file((unsigned)bdid != 0),hash64((unsigned)bdid));
		
		temp_join_7 := join(temp_base_dist_7,temp_port_dist_7,
			(unsigned)left.bdid = (unsigned)right.bdid,
			xfm_preserve_lookup_data(left,right),
			local);
		
		// Pivot on Linkids
		temp_port_dist_8 := distribute(in_portfolio(seleid != 0),hash64(seleid));
		temp_base_dist_8 := distribute(party_file(seleid != 0),hash64(seleid));
		
		temp_join_8 := join(temp_base_dist_8,temp_port_dist_8,
												BIPV2.IDmacros.mac_JoinTop3Linkids(),
												xfm_preserve_lookup_data(left,right),
												local);
			
		// Combine the possibilities from the various pivots
		temp_all_joins :=
			temp_join_1 +
			temp_join_2a +
			temp_join_2b +
			temp_join_3 +
			temp_join_4 +
			temp_join_5a +
			temp_join_5b +
			temp_join_6 +
			temp_join_7 +
			temp_join_8;
		
		// Dedup by TMSID so not to double-count
		temp_joins_deduped := dedup(sort(distribute(temp_all_joins,hash64(pid,rid)),pid,rid,tmsid,local),pid,rid,tmsid,local);
		temp_joins_dist := distribute(temp_joins_deduped,hash64(tmsid));
		
		// Data layout
		temp_data_layout := record
			temp_joins_dist.pid;
			temp_joins_dist.rid;
			temp_joins_dist.save_did;
			temp_joins_dist.save_bdid;
			temp_joins_dist.tmsid;
			main_file.filing_number;
			main_file.filing_type_desc;
			dataset filing_status {maxcount(100)} := main_file.filing_status;
		end;
		// Go get the data to check out
		temp_get_main := join(temp_joins_dist,distribute(main_file,hash64(tmsid)),
			left.tmsid = right.tmsid,
			transform(temp_data_layout,
				self.pid              := left.pid,
				self.rid              := left.rid,
				self.save_did         := left.save_did,
				self.save_bdid        := left.save_bdid,
				self.tmsid            := left.tmsid,
				self.filing_number    := right.filing_number,
				self.filing_type_desc := right.filing_type_desc,
				self.filing_status    := right.filing_status),
			left outer,
			local);
		
		// Now, create a hash value from only those fields we're interested in (these are the ones in the temporary layout).
		temp_unrolled_hashes := project(temp_get_main,
			transform(layouts.history,
				self.pid          := left.pid,
				self.rid          := left.rid,
				self.hid          := 0,
				self.did          := left.save_did,
				self.bdid         := left.save_bdid,
				self.product_mask := AccountMonitoring.Constants.PM_LIENS,
				self.timestamp    := '',
				self.hash_value   := hash64(
					left.filing_number,
					left.filing_type_desc,
					SUM(left.filing_status,HASH64(filing_status,filing_status_desc))
					)
				)
			);
		
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := rollup(sort(distribute(temp_unrolled_hashes,hash64(pid,rid)),pid,rid,record,local),
			transform(AccountMonitoring.layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self            := left),
			pid,rid,local);

		return temp_rolled_hashes;
					
	END;