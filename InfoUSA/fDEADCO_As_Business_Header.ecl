import business_header, infousa, ut, address;

export fDEADCO_As_Business_Header(dataset(infousa.Layout_DEADCO_Clean_In) pDEADCO)
 :=
  function

	DEADCO_IN := pDEADCO;

	Layout_DEADCO_temp := RECORD
	UNSIGNED6 record_id := 0;
	infousa.Layout_DEADCO_Clean_In;
	END;

	//--------------------------------------------
	// Add unique record id to deadco file
	//--------------------------------------------
	Layout_DEADCO_temp AddRecordID(infousa.Layout_DEADCO_CLEAN_In L) := TRANSFORM
	SELF := L;
	END;

	deadco_temp := PROJECT(DEADCO_IN, AddRecordID(LEFT));

	//not necessary here because only one relative address

	//ut.MAC_Sequence_Records(deadco_temp , record_id, deadco_out);


	business_header.Layout_Business_Header tDEADCOtoHEADER(Layout_DEADCO_temp L) := transform

	  
	 self.group1_id        := L.record_id;
	 self.vendor_id        := L.ABI_NUMBER + L.production_date;
	 self.phone            := (UNSIGNED6)((UNSIGNED8)L.phone);
	 self.phone_score      := IF((UNSIGNED8)L.phone = 0, 0, 1);
	 self.source           := 'ID';//waiting for reply from the vendor
	 self.source_group     := L.ABI_NUMBER;
	 self.company_name     := stringlib.stringtouppercase(L.company_name);
	 self.dt_first_seen    := if((unsigned)L.dt_first_seen < 300000, (unsigned)L.dt_first_seen * 100, (unsigned)L.dt_first_seen);
	 self.dt_last_seen     := if((unsigned)L.dt_last_seen < 300000, (unsigned)L.dt_last_seen * 100, (unsigned)L.dt_last_seen);
	 self.dt_vendor_first_reported := if((unsigned)L.dt_vendor_first_reported < 300000, (unsigned)L.dt_vendor_first_reported * 100, (unsigned)L.dt_vendor_first_reported);
	 self.dt_vendor_last_reported  := if((unsigned)L.dt_vendor_last_reported < 300000, (unsigned)L.dt_vendor_last_reported * 100, (unsigned)L.dt_vendor_last_reported);
	 self.fein := 0;
	 self.current := TRUE;
	 self.prim_range		:= L.prim_range ;
	 self.predir			:= L.predir;
	 self.prim_name			:= L.prim_name;
	 self.addr_suffix		:= L.addr_suffix;
	 self.postdir			:= L.postdir;
	 self.unit_desig		:= L.unit_desig;
	 self.sec_range			:= L.sec_range;
	 self.city				:= L.p_city_name;
	 self.state				:= L.st;
	 self.zip 				:= (unsigned3)L.zip5;
	 self.zip4				:= (unsigned2)L.zip4;
	 self.county			:= L.ace_fips_county;
	 self.msa				:= L.msa;
	 self.geo_lat			:= L.geo_lat;
	 self.geo_long			:= L.geo_long;

	end;


	deadco_header := project(deadco_temp,tDEADCOtoHEADER(LEFT));

	//--------------------------------------------
	// Rollup on name and address
	//--------------------------------------------

	deadco_header_dist := DISTRIBUTE(deadco_header, HASH(group1_id, ut.CleanCompany(company_name)));

	deadco_header_sort := SORT(deadco_header_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	business_header.Layout_Business_Header Rollupdeadcoheader(business_header.Layout_Business_Header L, business_header.Layout_Business_Header R) 

	:= TRANSFORM
	SELF := L;
	END;

	deadco_header_rollup := ROLLUP(deadco_header_sort,
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
								  Rollupdeadcoheader(LEFT, RIGHT),
								  LOCAL);


	// Final Rollup
	business_header.Layout_Business_Header Rollupdeadco(business_header.Layout_Business_Header L, business_header.Layout_Business_Header R) := TRANSFORM
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

	deadco_clean_dist := DISTRIBUTE(deadco_header_rollup,
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	deadco_clean_sort := SORT(deadco_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	deadco_clean_rollup := ROLLUP(deadco_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						Rollupdeadco(LEFT, RIGHT),
						LOCAL);

	return deadco_clean_rollup;
	
  end
 ;