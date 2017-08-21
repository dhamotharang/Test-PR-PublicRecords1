IMPORT Business_Header, ut, address,mdr;

export fDCA_as_Business_Header(dataset(Layout_Pub_In) pDCA_Base):=
function


	//*************************************************************************
	// Translate DCA file to Common Business Header Format
	//*************************************************************************

	dca_base := pDCA_Base;

	Layout_DCA_Local := RECORD
	UNSIGNED6 record_id := 0;
	dca.Layout_Pub_In;
	END;

	//--------------------------------------------
	// Add unique record id to dca file
	//--------------------------------------------
	Layout_DCA_Local AddRecordID(Layout_Pub_In L) := TRANSFORM
	SELF := L;
	END;

	dca_Init := PROJECT(dca_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(dca_Init, record_id, dca_Seq);

	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_dca_To_BHF(Layout_dca_Local L, integer CTR) := transform
	  SELF.vl_id     := L.root + '-' + L.sub;
		SELF.group1_id := L.record_id;
	  SELF.vendor_id := L.root + '-' + L.sub;
	  // DCA has international companies so blank phone number if non-US
	  SELF.phone := (UNSIGNED6)((UNSIGNED8)if(L.state <> '' or L.country = '', Address.CleanPhone(L.Phone), ''));
	  SELF.phone_score := IF((UNSIGNED8)Address.CleanPhone(L.Phone) = 0, 0, 1);
	  SELF.source := MDR.sourceTools.src_DCA;
	  SELF.source_group := L.root + '-' + L.sub;
	  SELF.company_name := L.Name;
	  SELF.dt_first_seen := (unsigned4)business_header.validatedate(L.Update_Date);
	  SELF.dt_last_seen := self.dt_first_seen;
	  SELF.dt_vendor_first_reported := (UNSIGNED4)L.process_date;
	  SELF.dt_vendor_last_reported := (UNSIGNED4)L.process_date;
	  SELF.fein := 0;
	  SELF.current := TRUE;
	  SELF.prim_range := CHOOSE(CTR, L.prim_range, L.prim_rangeA);
	  SELF.predir := CHOOSE(CTR, L.predir, L.predirA);
	  SELF.prim_name := CHOOSE(CTR, L.prim_name, L.prim_nameA);
	  SELF.addr_suffix := CHOOSE(CTR, L.addr_suffix, L.addr_suffixA);
	  SELF.postdir := CHOOSE(CTR, L.postdir, L.postdirA);
	  SELF.unit_desig := CHOOSE(CTR, L.unit_desig, L.unit_desigA);
	  SELF.sec_range := CHOOSE(CTR, L.sec_range, L.sec_rangeA);
	  SELF.city := CHOOSE(CTR, L.v_city_name, L.v_city_nameA);
	  SELF.state := CHOOSE(CTR, L.st, L.stA);
	  SELF.zip := CHOOSE(CTR, (UNSIGNED3)L.z5, (UNSIGNED3)L.zipA);
	  SELF.zip4 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.zip4A);
	  SELF.county := CHOOSE(CTR, L.county[3..5], L.countyA[3..5]);
	  SELF.msa := CHOOSE(CTR, L.msa, L.msaA);
	  SELF.geo_lat := CHOOSE(CTR, L.geo_lat, L.geo_latA);
	  SELF.geo_long := CHOOSE(CTR, L.geo_long, L.geo_longA);
	END;

	//--------------------------------------------
	// Normalize names
	//--------------------------------------------
	from_dca_norm := NORMALIZE(dca_Seq, 2, Translate_dca_To_BHF(LEFT, COUNTER));

	//--------------------------------------------
	// Rollup on name and address
	//--------------------------------------------

	from_dca_norm_dist := DISTRIBUTE(from_dca_norm, HASH(group1_id, ut.CleanCompany(company_name)));
	from_dca_norm_sort := SORT(from_dca_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	bh_layout RollupdcaNorm(bh_layout L, bh_layout R) := TRANSFORM
	SELF := L;
	END;

	from_dca_norm_rollup := ROLLUP(from_dca_norm_sort,
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
								  RollupdcaNorm(LEFT, RIGHT),
								  LOCAL);


	// Final Rollup
	bh_layout Rollupdca(bh_layout L, bh_layout R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.vl_id := IF(L.vl_id = '', R.vl_id, L.vl_id);
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

	dca_clean_dist := DISTRIBUTE(from_dca_norm_rollup,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	dca_clean_sort := SORT(dca_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	dca_clean_rollup := ROLLUP(dca_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						Rollupdca(LEFT, RIGHT),
						LOCAL);

	return dca_clean_rollup;

end;