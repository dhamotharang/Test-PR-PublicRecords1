import Business_Header, ut, address,mdr;

export fSKA_As_Business_Header(

	 dataset(Layout_SKA_Verified_bdid	) pSka_Verified_Base	= File_SKA_Verified_Base
	,dataset(Layout_SKA_Nixie_bdid		) pSka_Nixie_base			= File_SKA_Nixie_Base		

) :=
function

	Layout_SKA_Verified_Local := record
	unsigned6 record_id := 0;
	Layout_SKA_Verified_Bdid;
	end;

	Layout_BHF_Local := record
	Business_Header.Layout_Business_Header_New;
	unsigned6 orig_id;
	unsigned6 split_id := 0;
	end;

	// Add unique record id to SKA Verified file
	Layout_SKA_Verified_Local AddRecordID(Layout_SKA_Verified_bdid l) := transform
	self := l;
	end;

	SKA_Verified_Init := project(pSka_Verified_Base, AddRecordID(left));

	ut.MAC_Sequence_Records(SKA_Verified_Init, record_id, SKA_Verified_Seq)

	Layout_BHF_Local  Translate_SKA_Verified_to_BHF(Layout_SKA_Verified_Local l, integer CTR) := transform
	self.orig_id := l.record_id;
	self.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
	self.vl_id := 'SKAV' + l.id;
	self.vendor_id := 'SKAV' + l.id;
	self.source := MDR.sourceTools.src_SKA;
	self.source_group := '';
	self.phone := (unsigned6)address.CleanPhone(l.phone);
	self.phone_score := if((integer)l.phone = 0, 0, 1);
	self.prim_range := choose(CTR, l.mail_prim_range, l.alt_prim_range);
	self.predir := choose(CTR, l.mail_predir, l.alt_predir);
	self.prim_name := choose(CTR, l.mail_prim_name, l.alt_prim_name);
	self.addr_suffix := choose(CTR, l.mail_addr_suffix, l.alt_addr_suffix);
	self.postdir := choose(CTR, l.mail_postdir, l.alt_postdir);
	self.unit_desig := choose(CTR, l.mail_unit_desig, l.alt_unit_desig);
	self.sec_range := choose(CTR, l.mail_sec_range, l.alt_sec_range);
	self.city := choose(CTR, l.mail_v_city_name, l.alt_v_city_name);
	self.state := choose(CTR, l.mail_st, l.alt_st);
	self.zip := choose(CTR, (unsigned3)l.mail_zip, (unsigned3)l.alt_zip);
	self.zip4 := choose(CTR, (unsigned2)l.mail_zip4, (unsigned2)l.alt_zip4);
	self.county := choose(CTR, l.mail_county, l.alt_county);
	self.msa := choose(CTR, l.mail_msa, l.alt_msa);
	self.geo_lat := choose(CTR, l.mail_geo_lat, l.alt_geo_lat);
	self.geo_long := choose(CTR, l.mail_geo_long, l.alt_geo_long);
	self.dt_first_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_last_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_vendor_first_reported := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_vendor_last_reported := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.current := true;
	self := l;
	end;

	from_ska_verified_norm := normalize(SKA_Verified_Seq, 2, Translate_SKA_Verified_To_BHF(left, counter));
	from_ska_verified_norm_dist := distribute(from_ska_verified_norm, hash(orig_id, company_name));
	from_ska_verified_norm_sort := sort(from_ska_verified_norm_dist, orig_id, company_name,  -zip, -state, -city, local);

	Layout_BHF_Local RollupSKAVerifiedNorm(Layout_BHF_Local l, Layout_BHF_Local r) := transform
	self := l;
	end;

	from_ska_verified_norm_rollup := ROLLUP(from_ska_verified_norm_sort,
										 left.orig_id = right.orig_id and
								  left.company_name = right.company_name and
								  ((left.zip = right.zip and
								   left.prim_name = right.prim_name and
								   left.prim_range = right.prim_range and
								   left.city = right.city and
								   left.state = right.state)
								  or
								   (right.zip = 0 and
									right.prim_name = '' and
									right.prim_range = '' and
									right.city = '' and
									right.state = '' and
									right.city = '')
								  ),
								  RollupSKAVerifiedNorm(left, right),
								  local);
								  
	ut.MAC_Sequence_Records(from_ska_verified_norm_rollup, split_id, from_ska_verified_seq)

	// Group by original id
	from_ska_verified_dist := distribute(from_ska_verified_seq, hash(orig_id));
	from_ska_verified_sort := sort(from_ska_verified_dist, orig_id, local);
	from_ska_verified_grpd := group(from_ska_verified_sort, orig_id, local);
	from_ska_verified_grpd_sort := sort(from_ska_verified_grpd, split_id);

	Layout_BHF_Local SetGroupId(Layout_BHF_Local l, Layout_BHF_Local r) := transform
	self.group1_id := if(l.group1_id <> 0, l.group1_id, r.split_id);
	self := r;
	end;

	// Set group id
	from_ska_verified_iter := group(iterate(from_ska_verified_grpd_sort, SetGroupId(left, right)));

	// Calculate stat to determine count by group_id
	Layout_Group_List := record
	from_ska_verified_iter.group1_id;
	end;

	ska_verified_group_list := table(from_ska_verified_iter, Layout_Group_List);

	Layout_Group_Stat := record
	ska_verified_group_list.group1_id;
	cnt := count(group);
	end;

	ska_verified_group_stat := table(ska_verified_group_list, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header_New FormatToBHF(Layout_BHF_Local l, Layout_Group_Stat r) := transform
	self.group1_id := r.group1_id;
	self := l;
	end;

	ska_verified_group_clean := join(from_ska_verified_iter,
							 ska_verified_group_stat(cnt > 1),
							 left.group1_id = right.group1_id,
							 FormatToBHF(left, right),
							 left outer,
							 lookup);

	Business_Header.Layout_Business_Header_New  Translate_SKA_Nixie_to_BHF(Layout_SKA_Nixie_BDID l) := transform
	self.group1_id := 0;
	self.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
	self.vl_id := 'SKAN' + l.id;
	self.vendor_id := 'SKAN' + l.id;
	self.source := MDR.sourceTools.src_SKA;
	self.source_group := '';
	self.phone := (unsigned6)address.CleanPhone(if(l.area_code <> '', l.area_code, '000') + l.NUMBER);
	self.phone_score := if((integer)l.NUMBER = 0, 0, 1);
	self.prim_range := l.mail_prim_range;
	self.predir := l.mail_predir;
	self.prim_name := l.mail_prim_name;
	self.addr_suffix := l.mail_addr_suffix;
	self.postdir := l.mail_postdir;
	self.unit_desig := l.mail_unit_desig;
	self.sec_range := l.mail_sec_range;
	self.city := l.mail_v_city_name;
	self.state := l.mail_st;
	self.zip := (unsigned3)l.mail_zip;
	self.zip4 := (unsigned2)l.mail_zip4;
	self.county := l.mail_county;
	self.msa := l.mail_msa;
	self.geo_lat := l.mail_geo_Lat;
	self.geo_long := l.mail_geo_Long;
	self.dt_first_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_last_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_vendor_first_reported  := if((integer)l.NIXIE_DATE <> 0, (unsigned4)l.NIXIE_DATE,
									   (unsigned4)Stringlib.GetDateYYYYMMDD());
	self.dt_vendor_last_reported := if((integer)l.NIXIE_DATE <> 0, (unsigned4)l.NIXIE_DATE,
									   (unsigned4)Stringlib.GetDateYYYYMMDD());
	self.current := true;
	self := l;
	end;

	// Business Registration Owner Information
	ska_nixie_init := project(pSka_Nixie_base, Translate_SKA_Nixie_to_BHF(left));

	// Rollup
	Business_Header.Layout_Business_Header_New RollupBR(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := TRANSFORM
	self.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
				ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	self.dt_last_seen := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	self.dt_vendor_last_reported := ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.company_name := IF(l.company_name = '', r.company_name, l.company_name);
	self.group1_id := IF(l.group1_id = 0, r.group1_id, l.group1_id);
	self.vl_id := IF(l.vl_id = '', r.vl_id, l.vl_id);
	self.vendor_id := IF((l.group1_id = 0 and r.group1_id <> 0) OR
						 l.vendor_id = '', r.vendor_id, l.vendor_id);
	self.source_group := IF((l.group1_id = 0 and r.group1_id <> 0) OR
						 l.source_group = '', r.source_group, l.source_group);
	self.phone := IF(l.phone = 0, r.phone, l.phone);
	self.phone_score := IF(l.phone = 0, r.phone_score, l.phone_score);
	self.fein := IF(l.fein = 0, r.fein, l.fein);
	self.prim_range := IF(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
	self.predir := IF(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
	self.prim_name := IF(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
	self.addr_suffix := IF(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	self.postdir := IF(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
	self.unit_desig := IF(l.unit_desig = ''and l.zip4 = 0, r.unit_desig, l.unit_desig);
	self.sec_range := IF(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
	self.city := IF(l.city = '' and l.zip4 = 0, r.city, l.city);
	self.state := IF(l.state = '' and l.zip4 = 0, r.state, l.state);
	self.zip := IF(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
	self.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	self.county := IF(l.county = '' and l.zip4 = 0, r.county, l.county);
	self.msa := IF(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
	self.geo_lat := IF(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
	self.geo_long := IF(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
	self := L;
	END;

	ska_clean_dist := distribute(ska_verified_group_clean + ska_nixie_init,
						hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
	ska_clean_sort := sort(ska_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						if(sec_range <> '', 0, 1), sec_range,
						if(phone <> 0, 0, 1), phone,
						if(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
	ska_clean_rollup := rollup(ska_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.source_group = right.source_group and
						  left.company_name = right.company_name and
						  (right.sec_range = '' or left.sec_range = right.sec_range) and
						  (right.phone = 0 or left.phone = right.phone) and
						  (right.fein = 0 or left.fein = right.fein),
						RollupBR(left, right),
						local);

	return ska_clean_rollup;

end;