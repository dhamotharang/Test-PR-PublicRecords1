IMPORT $, LN_PropertyV2, ut, NID, BIPV2;

EXPORT DATASET(layouts.history) fn_cgm_property(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.property.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.property.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		search_file := AccountMonitoring.product_files.property.Property_search_key_sorted;
		deeds_file  := AccountMonitoring.product_files.property.Property_deed_key_dist;
		linkid_file := DISTRIBUTED(AccountMonitoring.product_files.property.Property_SearchLinkid_superkey_dist,HASH64(seleid));

		// Temporary Join Layout
		temp_layout := RECORD
			in_portfolio.pid;
			in_portfolio.rid;
			unsigned6 did  := 0;
			unsigned6 bdid := 0;
			search_file.app_ssn;
			search_file.lname;
			search_file.mname;
			search_file.fname;
			search_file.name_suffix;
			search_file.cname;
			search_file.predir;
      search_file.prim_range;
      search_file.prim_name;
			search_file.postdir;
      search_file.sec_range;
			search_file.suffix;
      search_file.p_city_name;
			search_file.st;
      search_file.zip;
			search_file.ln_fares_id;
			deeds_file.fares_refi_flag;
		END;	
		
		temp_layout xfm_collect_monitoring_data($.layouts.portfolio.base l, RECORDOF(LN_PropertyV2.key_search_fid()) r) :=
			TRANSFORM
				SELF.pid  := l.pid;
				SELF.rid  := l.rid;
				SELF.did  := l.did;
				SELF.bdid := l.bdid;
				SELF      := r;
				SELF      := [];
			END;
		
		// Pivot on did.
		temp_port_dist_1 := DISTRIBUTE(in_portfolio(did != 0), HASH32(did));
		temp_srch_dist_1 := DISTRIBUTE(search_file(did != 0), HASH32(did));
		temp_join_1 := 
			JOIN(temp_port_dist_1, temp_srch_dist_1, 
				LEFT.did = RIGHT.did,
				xfm_collect_monitoring_data(LEFT,RIGHT), 
				INNER, LOCAL);

		// Pivot on ssn
		temp_port_dist_2 := DISTRIBUTE(in_portfolio(ssn != ''), HASH32(ssn));	
		temp_srch_dist_2 := DISTRIBUTE(search_file(app_ssn != ''), HASH32(app_ssn)); 
		temp_join_2 := 
			JOIN(temp_port_dist_2, temp_srch_dist_2, 
				LEFT.ssn = RIGHT.app_ssn,
				xfm_collect_monitoring_data(LEFT,RIGHT), 
				INNER, LOCAL);

		// Pivot on last name and preferred first...
		
		// ...plus prim_range, prim_name, addr_suffix:
		temp_port_dist_3 := DISTRIBUTE(in_portfolio(name_last != ''),HASH32(name_last,NID.PreferredFirstNew(name_first),prim_range,prim_name,addr_suffix));
		temp_srch_dist_3 := DISTRIBUTE(search_file(lname != ''),HASH32(lname,NID.PreferredFirstNew(fname),prim_range,prim_name,suffix));
		
		temp_join_3 := 
			JOIN(temp_port_dist_3, temp_srch_dist_3, 
				LEFT.name_last != '' AND 
				LEFT.name_last = RIGHT.lname AND
				NID.PreferredFirstNew(LEFT.name_first) = NID.PreferredFirstNew(RIGHT.fname) AND 
				( LEFT.prim_name = RIGHT.prim_name AND
					LEFT.prim_range = RIGHT.prim_range AND
					LEFT.addr_suffix = RIGHT.suffix ),
				xfm_collect_monitoring_data(LEFT,RIGHT),
				INNER, LOCAL );

		// ...plus p_city_name, st:
		temp_port_dist_4 := DISTRIBUTE(in_portfolio(name_last != ''),HASH32(name_last,NID.PreferredFirstNew(name_first),p_city_name,st));
		temp_srch_dist_4 := DISTRIBUTE(search_file(lname != ''),HASH32(lname,NID.PreferredFirstNew(fname),p_city_name,st));
		
		temp_join_4 := 
			JOIN(temp_port_dist_4, temp_srch_dist_4, 
				LEFT.name_last != '' AND 
				LEFT.name_last = RIGHT.lname AND
				NID.PreferredFirstNew(LEFT.name_first) = NID.PreferredFirstNew(RIGHT.fname) AND
				( LEFT.p_city_name = RIGHT.p_city_name AND
					LEFT.st = RIGHT.st ),
				xfm_collect_monitoring_data(LEFT,RIGHT), 
				INNER, LOCAL );

		// ...plus zip:
		temp_port_dist_5 := DISTRIBUTE(in_portfolio(name_last != ''),HASH32(name_last,NID.PreferredFirstNew(name_first),z5));
		temp_srch_dist_5 := DISTRIBUTE(search_file(lname != ''),HASH32(lname,NID.PreferredFirstNew(fname),zip));
		
		temp_join_5 := 
			JOIN(temp_port_dist_5, temp_srch_dist_5, 
				LEFT.name_last != '' AND 
				LEFT.name_last = RIGHT.lname AND
				NID.PreferredFirstNew(LEFT.name_first) = NID.PreferredFirstNew(RIGHT.fname) AND
				LEFT.z5 = RIGHT.zip,
				xfm_collect_monitoring_data(LEFT,RIGHT), 
				INNER, LOCAL );
		
		// pivot on linkids
		temp_port_dist_6 := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
			
		temp_join_6 := 
			JOIN(linkid_file, temp_port_dist_6, 
				BIPV2.IDmacros.mac_JoinTop3Linkids(),
				TRANSFORM(temp_layout,
								SELF.pid  						:= RIGHT.pid,
								SELF.rid  						:= RIGHT.rid,
								SELF.bdid 						:= 0, 
								SELF.did							:= 0, 
								SELF.ln_fares_id 			:= LEFT.ln_fares_id;
								SELF.fares_refi_flag 	:= '';
								SELF      						:= LEFT),
				LOCAL);
				
		// Combine the possibilities from the various pivots.
		temp_all_joins :=
			temp_join_1 +
			temp_join_2 +
			temp_join_3 +
			temp_join_4 +
			temp_join_5 +
			temp_join_6
			;
				
		temp_all_deduped := DEDUP(SORT(DISTRIBUTE(temp_all_joins,HASH64(pid,rid)),
																	 pid,rid,ln_fares_id,LOCAL),
															pid,rid,ln_fares_id,LOCAL);

		// Since the deeds file has only the ln_fares_id as its unique identifier (i.e. no
		// did or personal information) we need to get the refi flag in a secondary join:
		temp_all_redist := DISTRIBUTE(temp_all_deduped, HASH64(ln_fares_id));
		
		temp_add_refi_flag :=
			JOIN(
				temp_all_redist, 
				deeds_file,
				LEFT.ln_fares_id = RIGHT.ln_fares_id,
				TRANSFORM(
					temp_layout,
					SELF.fares_refi_flag := RIGHT.fares_refi_flag,
					SELF                 := LEFT
				),
				LEFT OUTER, LOCAL
			);

		// Now create a hash value from only the fields we're interested in (these are the
		// non *id fields in the temp_layout).
		temp_redist_again := SORT(DISTRIBUTE(temp_add_refi_flag,HASH64(pid,rid)),pid,rid, ln_fares_id,LOCAL);
															
		temp_unrolled_hashes := PROJECT(temp_redist_again,
			transform(layouts.history,
				SELF.hid          := 0,
				SELF.timestamp    := '',
				SELF.product_mask := AccountMonitoring.Constants.pm_property,
				SELF.hash_value   := 
					HASH64(
						LEFT.fname, 
						LEFT.mname, 
						LEFT.lname, 
						LEFT.name_suffix, 
						LEFT.cname,
						LEFT.prim_range, 
						LEFT.predir, 
						LEFT.prim_name, 
						LEFT.suffix, 
						LEFT.postdir, 
						LEFT.sec_range,
						LEFT.p_city_name, 
						LEFT.st, 
						LEFT.zip,
						LEFT.ln_fares_id, 
						LEFT.fares_refi_flag
					),
				SELF := LEFT
			)); 
					
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := ROLLUP(temp_unrolled_hashes,
			TRANSFORM(layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);
			
		RETURN temp_rolled_hashes;

	END;
