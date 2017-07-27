IMPORT Business_Header, ut;

export fABIUS_Company_As_Business_Header(dataset(Layout_abius_company_data_In) pABIUS_Company)
 :=
  function

	//*************************************************************************
	// Translate ABIUS Company file to Common Business Header Format
	//*************************************************************************
	string8 validatedate(string8 mydate) :=
	map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()) or (integer)mydate < 16000101 => '',
		mydate);

	abius_company_base := pABIUS_Company;

	Layout_abius_company_Local := RECORD
	UNSIGNED6 record_id := 0;
	Layout_abius_company_data_In;
	END;

	//--------------------------------------------
	// Add unique record id to abius_company file
	//--------------------------------------------
	Layout_abius_company_Local AddRecordID(Layout_abius_company_data_In L) := TRANSFORM
	SELF := L;
	END;

	abius_company_Init := PROJECT(abius_company_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(abius_company_Init, record_id, abius_company_Seq);

	bh_layout := business_header.Layout_Business_Header;

	bh_layout Translate_abius_company_To_BHF(Layout_abius_company_Local L, integer CTR) := transform
	  SELF.source 				  := 'IA'; 
	  SELF.source_group 		  := L.ABI_NUMBER;
	  SELF.group1_id 			  := L.record_id;
	  SELF.vendor_id 			  := L.ABI_NUMBER + L.COMPANY_NAME;
	  SELF.dt_first_seen 		  := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);  
	  SELF.dt_last_seen 		  := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, 0);
	  SELF.dt_vendor_first_reported := if(L.DATE_ADDED <> '', ((UNSIGNED4)L.DATE_ADDED) * 100, (UNSIGNED4)validatedate(L.PRODUCTION_DATE));
	  SELF.dt_vendor_last_reported  := (UNSIGNED4)validatedate(L.PRODUCTION_DATE);
	  SELF.company_name 		  := L.COMPANY_NAME;
	  SELF.prim_range 			  := CHOOSE(CTR, L.prim_range,	L.prim_range2);
	  SELF.predir 				  := CHOOSE(CTR, L.predir,		L.predir2);
	  SELF.prim_name 			  := CHOOSE(CTR, L.prim_name,		L.prim_name2);
	  SELF.addr_suffix 			  := CHOOSE(CTR, L.addr_suffix,	L.addr_suffix2);
	  SELF.postdir 			  := CHOOSE(CTR, L.postdir,		L.postdir2);
	  SELF.unit_desig 			  := CHOOSE(CTR, L.unit_desig,	L.unit_desig2);
	  SELF.sec_range 			  := CHOOSE(CTR, L.sec_range,		L.sec_range2);
	  SELF.city 				  := CHOOSE(CTR, L.p_city_name,	L.p_city_name2);
	  SELF.state 				  := CHOOSE(CTR, L.st, 			L.st2);
	  SELF.zip 				  := CHOOSE(CTR, (UNSIGNED3)L.z5, 	(UNSIGNED3)L.z52);
	  SELF.zip4 				  := CHOOSE(CTR, (UNSIGNED2)L.zip4,(UNSIGNED2)L.zip42);
	  SELF.county 				  := CHOOSE(CTR, L.county[3..5], 	L.county2[3..5]);
	  SELF.msa 				  := CHOOSE(CTR, L.msa, 			L.msa2);
	  SELF.geo_lat 			  := CHOOSE(CTR, L.geo_lat, 		L.geo_lat2);
	  SELF.geo_long 			  := CHOOSE(CTR, L.geo_long, 		L.geo_long2);
	  SELF.phone 				  := (UNSIGNED6)((UNSIGNED8)L.PHONE);
	  SELF.phone_score 			  := IF((UNSIGNED8)L.PHONE = 0, 0, 1);
	  SELF.fein 				  := 0;
	  SELF.current 			  := TRUE;
	END;

	//--------------------------------------------
	// Normalize names
	//--------------------------------------------
	from_abius_company_norm := NORMALIZE(abius_company_Seq, 2, Translate_abius_company_To_BHF(LEFT, COUNTER));

	//--------------------------------------------
	// Rollup on name and address
	//--------------------------------------------

	from_abius_company_norm_dist := DISTRIBUTE(from_abius_company_norm, HASH(group1_id, ut.CleanCompany(company_name)));
	from_abius_company_norm_sort := SORT(from_abius_company_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	bh_layout Rollupabius_companyNorm(bh_layout L, bh_layout R) := TRANSFORM
	SELF := L;
	END;

	from_abius_company_norm_rollup := ROLLUP(from_abius_company_norm_sort,
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
								  Rollupabius_companyNorm(LEFT, RIGHT),
								  LOCAL);


	// Final Rollup
	bh_layout Rollupabius_company(bh_layout L, bh_layout R) := TRANSFORM
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

	abius_company_clean_dist := DISTRIBUTE(from_abius_company_norm_rollup,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	abius_company_clean_sort := SORT(abius_company_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	abius_company_clean_rollup := ROLLUP(abius_company_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						Rollupabius_company(LEFT, RIGHT),
						LOCAL);

	return abius_company_clean_rollup;
	
  end
 ;
