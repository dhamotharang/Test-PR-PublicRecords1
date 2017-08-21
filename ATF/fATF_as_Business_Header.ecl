import Business_Header, ut, lib_stringlib,mdr,address;

export fATF_as_Business_Header(dataset(layout_firearms_explosives_out_bip) pInput, boolean IsPRCT = false) :=
function

	atf_in := pInput;

	Layout_atf_Local := record
	unsigned6 record_id := 0;
	ATF.layout_firearms_explosives_out_Bip;
	end;

	// Add unique record id to atf file
	Layout_atf_Local AddRecordID(ATF.layout_firearms_explosives_out_Bip L) := transform
	self := L;
	end;

	atf_Init := project(atf_in, AddRecordID(left));

	ut.MAC_Sequence_Records(atf_Init, record_id, atf_Seq)

	Business_Header.Layout_Business_Header_New  Translate_atf_to_BHF(Layout_atf_Local l, integer c) := transform
	SELF.bdid  			:= If(IsPRCT,(integer)l.BDID,0);
	self.vl_id := l.license_number;
	self.group1_id := L.record_id;
	self.vendor_id := l.license_number;
	self.phone := (unsigned6)stringlib.StringFilter(trim(l.Voice_Phone), '0123456789');
	self.phone_score := if(self.phone <> 0, 1, 0);
	self.source := if(l.record_type = 'F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives);
	self.source_group := l.license_number;
	self.company_name 	:= choose(c, l.license1_cname,       l.license1_cname,       l.license2_cname,      l.license2_cname, l.business_cname, l.business_cname);
	self.prim_range 	:= choose(c, l.premise_prim_range,   l.mail_prim_range,      l.premise_prim_range,  l.mail_prim_range, l.premise_prim_range, l.mail_prim_range);
	self.predir 		:= choose(c, l.premise_predir,       l.mail_predir,          l.premise_predir,      l.mail_predir, l.premise_predir, l.mail_predir);
	self.prim_name 	:= choose(c, l.premise_prim_name,    l.mail_prim_name,       l.premise_prim_name,   l.mail_prim_name, l.premise_prim_name, l.mail_prim_name);
	self.addr_suffix 	:= choose(c, l.premise_suffix,       l.mail_suffix,          l.premise_suffix,      l.mail_suffix, l.premise_suffix, l.mail_suffix);
	self.postdir 		:= choose(c, l.premise_postdir,      l.mail_postdir,         l.premise_postdir,     l.mail_postdir, l.premise_postdir, l.mail_postdir);
	self.unit_desig 	:= choose(c, l.premise_unit_desig,   l.mail_unit_desig,      l.premise_unit_desig,  l.mail_unit_desig, l.premise_unit_desig, l.mail_unit_desig);
	self.sec_range 	:= choose(c, l.premise_sec_range,    l.mail_sec_range,       l.premise_sec_range,   l.mail_sec_range, l.premise_sec_range, l.mail_sec_range);
	self.city 		:= choose(c, l.premise_v_city_name,  l.mail_v_city_name,     l.premise_v_city_name, l.mail_v_city_name, l.premise_v_city_name, l.mail_v_city_name);
	self.state 		:= choose(c, l.premise_st,           l.mail_st,              l.premise_st,          l.mail_st, l.premise_st, l.mail_st);
	self.zip 			:= choose(c, (UNSIGNED3)l.premise_zip,(UNSIGNED3)l.mail_zip, (UNSIGNED3)l.premise_zip,(UNSIGNED3)l.mail_zip, (UNSIGNED3)l.premise_zip, (UNSIGNED3)l.mail_zip);
	self.zip4 		:= choose(c, (UNSIGNED2)l.premise_zip4,(UNSIGNED2)l.mail_zip4,(UNSIGNED2)l.premise_zip4,(UNSIGNED2)l.mail_zip4, (UNSIGNED2)l.premise_zip4, (UNSIGNED2)l.mail_zip4);
	self.county 		:= choose(c, l.premise_fips_county,  l.mail_fips_county,      l.premise_fips_county, l.mail_fips_county, l.premise_fips_county, l.mail_fips_county);
	self.msa 			:= choose(c, l.premise_msa,          l.mail_msa,             l.premise_msa,         l.mail_msa, l.premise_msa, l.mail_msa);
	self.geo_lat 		:= choose(c, l.premise_geo_lat,      l.mail_geo_lat,         l.premise_geo_lat,     l.mail_geo_lat, l.premise_geo_lat, l.mail_geo_lat);
	self.geo_long 		:= choose(c, l.premise_geo_long,     l.mail_geo_long,        l.premise_geo_long,    l.mail_geo_long, l.premise_geo_long, l.mail_geo_long);
	//self.fein := '';
	self.current := true;
	self.dt_first_seen := (unsigned4)l.date_first_seen;
	self.dt_last_seen := (unsigned4)l.date_last_seen;
	//there are no other dates on the file, so must use date..seens for the vendor dates
	self.dt_vendor_first_reported := (unsigned4)l.date_first_seen;
	self.dt_vendor_last_reported := (unsigned4)l.date_last_seen;
	end;

	from_atf_norm := normalize(atf_Seq, 6, Translate_atf_to_BHF(left, counter));

	// -- figure out if it is a business, person, or both
	Address.Mac_Is_Business(from_atf_norm,company_name,atf_with_nametype,dodedup := false);

	Layout_atf_entity := recordof(atf_with_nametype);

	atf_Entity 		:= atf_with_nametype(company_name != '');
	atf_nonEntity := atf_with_nametype(company_name  = '');

	// ----------------------------------------
	// -- Back to bus header layout
	// ----------------------------------------
	Business_Header.Layout_Business_Header_New  Translate_Entity_to_BHF(Layout_atf_entity l) := transform
		self := L;
	end;
	atf_bus := project(atf_Entity(nameType  = 'B'), Translate_Entity_to_BHF(left));


	// -- rollup remaining records
	from_atf_norm_dist := distribute(atf_bus, hash(group1_id, ut.CleanCompany(company_name)));
	from_atf_norm_sort := sort(from_atf_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	Business_Header.Layout_Business_Header_New RollupatfNorm(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := transform
	self := l;
	end;

	from_atf_norm_rollup := rollup(from_atf_norm_sort,
								  left.group1_id = right.group1_id and
								  ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
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
									right.state = '')
								  ),
								  RollupatfNorm(left, right),
								  local);

	// Calculate stat to determine count by group_id
	Layout_Group_List := record
	from_atf_norm_rollup.group1_id;
	end;

	atf_group_list := table(from_atf_norm_rollup, Layout_Group_List);

	Layout_Group_Stat := record
	atf_group_list.group1_id;
	cnt := count(group);
	end;

	atf_group_stat := table(atf_group_list, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header_New FormatToBHF(Business_Header.Layout_Business_Header_New L, Layout_Group_Stat R) := TRANSForM
	self.group1_id := R.group1_id;
	SELF := L;
	END;

	atf_group_clean := join(from_atf_norm_rollup,
							 atf_group_stat(cnt > 1),
							 left.group1_id = right.group1_id,
							 FormatToBHF(left, right),
							 left outer,
							 lookup);

	// Rollup
	Business_Header.Layout_Business_Header_New Rollupatf(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSForM
	self.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	self.company_name := if(L.company_name = '', R.company_name, L.company_name);
	self.vl_id := if(L.vl_id = '', R.vl_id, L.vl_id);
	self.group1_id := if(L.group1_id = 0, R.group1_id, L.group1_id);
	self.vendor_id := if((L.group1_id = 0 and R.group1_id <> 0) or
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	self.source_group := if((L.group1_id = 0 and R.group1_id <> 0) or
						 L.source_group = '', R.source_group, L.source_group);
	self.phone := if(L.phone = 0, R.phone, L.phone);
	self.phone_score := if(L.phone = 0, R.phone_score, L.phone_score);
	self.fein := if(L.fein = 0, R.fein, L.fein);
	self.prim_range := if(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
	self.predir := if(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
	self.prim_name := if(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
	self.addr_suffix := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	self.postdir := if(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
	self.unit_desig := if(l.unit_desig = ''and l.zip4 = 0, r.unit_desig, l.unit_desig);
	self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
	self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
	self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
	self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
	self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
	self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
	self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
	self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
	self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	atf_clean_dist := distribute(atf_group_clean,
						hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
	atf_clean_sort := sort(atf_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						if(sec_range <> '', 0, 1), sec_range,
						if(phone <> 0, 0, 1), phone,
						if(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
	atf_clean_rollup := rollup(atf_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.source_group = right.source_group and
						  left.company_name = right.company_name and
						  (right.sec_range = '' or left.sec_range = right.sec_range) and
						  (right.phone = 0 or left.phone = right.phone) and
						  (right.fein = 0 or left.fein = right.fein),
						Rollupatf(left, right),
						local);

	return atf_clean_rollup;

end;