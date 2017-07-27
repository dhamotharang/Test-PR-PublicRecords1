IMPORT Business_Header, ut,address;

export fIDEXEC_as_Business_Header(dataset(InfoUSA.Layout_Cleaned_IDEXEC_file) pIDEXEC)
 :=
  function

	//*************************************************************************
	// Translate IDEXEC file to Common Business Header Format
	//*************************************************************************

	idexec_base := pIDEXEC;

	Layout_IDEXEC_Local := RECORD
	UNSIGNED6 record_id := 0;
	InfoUSA.Layout_Cleaned_IDEXEC_file;
	END;

	//--------------------------------------------
	// Add unique record id to idexec file
	//--------------------------------------------
	Layout_idexec_Local AddRecordID(idexec_base L) := TRANSFORM
	SELF := L;
	END;

	idexec_Init := PROJECT(idexec_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(idexec_Init, record_id, idexec_Seq);

	bh_layout := business_header.Layout_Business_Header;

	bh_layout Translate_idexec_To_BHF(idexec_Init L,integer CTR) := transform
	  SELF.group1_id := L.record_id;
	  SELF.vendor_id := L.idexec_key;
	  SELF.phone := (UNSIGNED6)((UNSIGNED8)address.CleanPhone(L.Loc_Telephone));
	  SELF.phone_score := IF((UNSIGNED8)L.Loc_Telephone = 0, 0, 1);
	  SELF.source := 'II';
	  SELF.source_group := '';
	  SELF.company_name 				:=stringlib.StringToUpperCase(choose(CTR,L.firm_Name,L.Former_Name1,L.Former_Name2))		;
	  SELF.dt_first_seen				:= 0				;
		//(UNSIGNED4)L.processdate						;	
	  SELF.dt_last_seen 				:= 0				;
		//(UNSIGNED4)L.processdate						;
	  SELF.dt_vendor_first_reported 	:= 0	;
		//(UNSIGNED4)L.processdate						;
	  SELF.dt_vendor_last_reported 		:= 0	;
		//(UNSIGNED4)L.processdate						;
	  SELF.fein 						:= 0												;
	  SELF.current 						:= TRUE												;
	  SELF.prim_range 					:= L.Firm_Address_Clean_prim_range					;
	  SELF.predir 						:= L.Firm_Address_Clean_predir						;
	  SELF.prim_name					:= L.Firm_Address_Clean_prim_name					;
	  SELF.addr_suffix 					:= L.Firm_Address_Clean_addr_suffix					;
	  SELF.postdir 						:= L.Firm_Address_Clean_postdir						;
	  SELF.unit_desig 					:= L.Firm_Address_Clean_unit_desig					;
	  SELF.sec_range 					:= L.Firm_Address_Clean_sec_range					;
	  SELF.city 						:= L.Firm_Address_Clean_p_city_name					;
	  SELF.state 						:= L.Firm_Address_Clean_st							;
	  SELF.zip 							:= (UNSIGNED3)L.Firm_Address_Clean_zip				;
	  SELF.zip4 						:= (UNSIGNED2)L.Firm_Address_Clean_zip4				;
	  SELF.county 						:= L.Firm_Address_Clean_fipscounty					;
	  SELF.msa 							:= L.Firm_Address_Clean_msa							;
	  SELF.geo_lat 						:= L.Firm_Address_Clean_geo_lat						;
	  SELF.geo_long						:= L.Firm_Address_Clean_geo_long					;
	END;

	//--------------------------------------------
	// Normalize names
	//--------------------------------------------

	//from_idexec_proj := Project(idexec_Init,Translate_idexec_To_BHF(LEFT));
	from_idexec_norm := NORMALIZE(idexec_Seq, 3, Translate_idexec_To_BHF(LEFT, COUNTER));

	//--------------------------------------------
	// Rollup on name and address
	//--------------------------------------------

	from_idexec_norm_dist := DISTRIBUTE(from_idexec_norm(company_name <> ''), HASH(group1_id, ut.CleanCompany(company_name)));
	from_idexec_norm_sort := SORT(from_idexec_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	bh_layout RollupidexecProj(bh_layout L, bh_layout R) := TRANSFORM
	SELF := L;
	END;

	from_idexec_norm_rollup := ROLLUP(from_idexec_norm_sort,
								  LEFT.group1_id = RIGHT.group1_id AND
								  ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
								  ((LEFT.zip = RIGHT.zip AND
								   LEFT.prim_name = RIGHT.prim_name AND
								   LEFT.prim_range = RIGHT.prim_range AND
								   LEFT.city = RIGHT.city AND
								   LEFT.state = RIGHT.state)
								  OR
								   (RIGHT.zip = 0 AND
									RIGHT.prim_name = '' AND
									RIGHT.prim_range = '' AND
									RIGHT.city = '' AND
									RIGHT.state = '' AND
									RIGHT.city = '')
								  ),
								  RollupidexecProj(LEFT, RIGHT),
								  LOCAL);


	// Final Rollup
	bh_layout Rollupidexec(bh_layout L, bh_layout R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.source_group = '', R.source_group, L.source_group);
	SELF.phone := IF(L.phone = 0, R.phone, L.phone);
	SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
	SELF.fein := IF(L.fein = 0, R.fein, L.fein);
	SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
	SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
	SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
	SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
	SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
	SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
	SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
	SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
	SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
	SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
	SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
	SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
	SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	idexec_clean_dist := DISTRIBUTE(from_idexec_norm_rollup,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	idexec_clean_sort := SORT(idexec_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	idexec_clean_rollup := ROLLUP(idexec_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						Rollupidexec(LEFT, RIGHT),
						LOCAL);
	
	return idexec_clean_rollup;
  end
 ;
