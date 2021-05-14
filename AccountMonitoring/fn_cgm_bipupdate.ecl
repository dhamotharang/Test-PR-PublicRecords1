IMPORT AccountMonitoring, BIPV2, BIPV2_Best;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_bipupdate(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
		DATASET(AccountMonitoring.layouts.documents.bipbestupdate.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.bipbestupdate.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		// For those Portfolio entities having a valid bipids, we'll join those records using a
		// linkid pivot only 
		portfolio_dist_sele := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid)) : INDEPENDENT;
		
		// BIPV2_Best.Key_LinkIds.key (pre-filtered in product_files to only return best rec proxid=0)
		Key_BIPBest := 
			DISTRIBUTED(
				AccountMonitoring.product_files.header_files.r_bipbest_header_key, 
				HASH64(seleid)
			);
			
		// Temporary Join Layout
		temp_layout := RECORD
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			TYPEOF(in_portfolio.did) did;
			in_documents.ultid;
			in_documents.orgid;
			in_documents.seleid;
			in_documents.proxid;
			in_documents.powid;
			in_documents.empid;
			in_documents.dotid;
			Key_BIPBest.company_bdid;
			Key_BIPBest.company_name.company_name; 
			Key_BIPBest.company_address.company_prim_range;
			Key_BIPBest.company_address.company_prim_name;
			Key_BIPBest.company_address.company_unit_desig;
			Key_BIPBest.company_address.company_p_city_name;
			Key_BIPBest.company_address.company_st;
			Key_BIPBest.company_address.company_zip5;
			Key_BIPBest.company_phone.company_phone; 
			Key_BIPBest.sic_code.company_sic_code1; 
			Key_BIPBest.naics_code.company_naics_code1; 
			DATASET(BIPV2_Best.Layouts.sic_code_case_layout) sic_code; 
			DATASET(BIPV2_Best.Layouts.naics_code_case_layout) naics_code; 
		END;
		
		
		// Pivot on bip ids (ult/org/sele) for the bdid update key. 
		
		// Join portfolio linkids on ult/org/sele to past bip header best linkids and return current bip candidates
		temp_join_best_rcid := JOIN(Key_BIPBest,portfolio_dist_sele,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  := RIGHT.pid,
																	SELF.rid  := RIGHT.rid,
																	SELF.hid  := 0,
																	SELF.company_bdid := LEFT.company_bdid, 
																	SELF.did	:= 0, // set to zero since bip header doesn't have did
																	SELF.company_name := LEFT.company_name[1].company_name;
																	SELF.company_prim_range := LEFT.company_address[1].company_prim_range;
																	SELF.company_prim_name := LEFT.company_address[1].company_prim_name;
																	SELF.company_unit_desig := LEFT.company_address[1].company_unit_desig;
																	SELF.company_p_city_name := LEFT.company_address[1].company_p_city_name;
																	SELF.company_st := LEFT.company_address[1].company_st;
																	SELF.company_zip5 := LEFT.company_address[1].company_zip5;
																	SELF.company_phone := LEFT.company_phone[1].company_phone;
																	SELF.company_sic_code1 := LEFT.sic_code[1].company_sic_code1;
																	SELF.company_naics_code1 := LEFT.naics_code[1].company_naics_code1;
																	SELF.sic_code := PROJECT(LEFT.sic_code,TRANSFORM(BIPV2_Best.Layouts.sic_code_case_layout,SELF:=LEFT));
																	SELF.naics_code := PROJECT(LEFT.naics_code,TRANSFORM(BIPV2_Best.Layouts.naics_code_case_layout,SELF:=LEFT));
																	SELF      := RIGHT),
																LOCAL);		

		
		// Now create a hash value from only the fields we're interested in 
		// (these are the non *id fields in the temp_layout).
		temp_unrolled_hashes := 
			PROJECT(temp_join_best_rcid,
							TRANSFORM(AccountMonitoring.layouts.history,
								SELF.pid          := LEFT.pid,
								SELF.rid          := LEFT.rid,
								SELF.hid          := LEFT.hid,
								SELF.bdid					:= LEFT.company_bdid,
								SELF.product_mask := AccountMonitoring.Constants.pm_bipbestupdate,
								SELF.timestamp    := '',
								SELF.hash_value   := HASH64(
											LEFT.ultid,
											LEFT.orgid,
											LEFT.seleid,
											LEFT.company_name,
											LEFT.company_sic_code1,
											LEFT.company_naics_code1,
											LEFT.company_phone,
											LEFT.company_prim_range,
											LEFT.company_prim_name,
											LEFT.company_unit_desig,
											LEFT.company_p_city_name,
											LEFT.company_st,
											LEFT.company_zip5)
											+ SUM(LEFT.sic_code,HASH64(company_sic_code1)) 
											+ SUM(LEFT.naics_code,HASH64(company_naics_code1))
											,
							SELF := LEFT)); 
						
		// Roll up the hashes for all records for a particular pid/rid; and return.
		temp_rolled_hashes := ROLLUP(SORT(DISTRIBUTE(temp_unrolled_hashes,HASH64(pid,rid,hid)),pid,rid,hid,RECORD,LOCAL),
			TRANSFORM(AccountMonitoring.layouts.history,
				SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
				SELF := LEFT),
			pid,rid,LOCAL);

		RETURN temp_rolled_hashes;
END;		