import Business_Header, ut,mdr,address;

export fWither_and_Die_as_Business_Header(dataset(wither_and_die.Layout_Wither_and_Die_In) pWither_And_Die)
 :=
  function

	wither_in := pWither_And_Die;

	Layout_wither_Local := record
	unsigned6 record_id := 0;
	wither_and_die.Layout_Wither_and_Die_In;
	end;

	// Add unique record id to wither file
	Layout_wither_Local AddRecordID(wither_and_die.Layout_Wither_and_Die_In L) := transform
	self := L;
	end;

	Wither_Init := project(wither_in, AddRecordID(left));

	ut.MAC_Sequence_Records(Wither_Init, record_id, Wither_Seq)

	Business_Header.Layout_Business_Header_New  Translate_Wither_to_BHF(Layout_wither_Local l, integer c) := transform
	self.group1_id := L.record_id;
	self.vl_id := '';
	self.vendor_id := if(l.VENDOR_ID != '', (trim(l.FILE_ID) + ',' + trim(l.VENDOR_ID))[1..34], 
				   if(l.VDI != '', (trim(l.FILE_ID) + ',' + trim(l.VDI))[1..34],
				   (trim(l.FILE_ID) + ',' + trim(l.cleaned_primary_name) + ',' + trim(l.cleaned_phone))[1..34]));
	self.phone := (unsigned6)l.cleaned_phone;
	self.phone_score := if(l.cleaned_phone <> '', 1, 0);
	self.source := MDR.sourceTools.src_Wither_and_Die;
	self.source_group := if(l.VENDOR_ID != '', (trim(l.FILE_ID) + trim(l.VENDOR_ID))[1..34], 
				   if(l.VDI != '', (trim(l.FILE_ID) + trim(l.VDI))[1..34],
				   (trim(l.FILE_ID) + trim(l.cleaned_primary_name) + trim(l.cleaned_phone))[1..34]));
	self.company_name 	:= choose(c, l.cleaned_primary_name, l.cleaned_primary_name, l.cleaned_dba_name,    l.cleaned_dba_name);
	self.prim_range 	:= choose(c, l.bus_prim_range,       l.mail_prim_range,      l.bus_prim_range,      l.mail_prim_range);
	self.predir 		:= choose(c, l.bus_predir,           l.mail_predir,          l.bus_predir,          l.mail_predir);
	self.prim_name 	:= choose(c, l.bus_prim_name,        l.mail_prim_name,       l.bus_prim_name,       l.mail_prim_name);
	self.addr_suffix 	:= choose(c, l.bus_addr_suffix,      l.mail_addr_suffix,     l.bus_addr_suffix,     l.mail_addr_suffix);
	self.postdir 		:= choose(c, l.bus_postdir,          l.mail_postdir,         l.bus_postdir,         l.mail_postdir);
	self.unit_desig 	:= choose(c, l.bus_unit_desig,       l.mail_unit_desig,      l.bus_unit_desig,      l.mail_unit_desig);
	self.sec_range 	:= choose(c, l.bus_sec_range,        l.mail_sec_range,       l.bus_sec_range,       l.mail_sec_range);
	self.city 		:= choose(c, l.bus_v_city_name,      l.mail_v_city_name,     l.bus_v_city_name,     l.mail_v_city_name);
	self.state 		:= choose(c, l.bus_st,               l.mail_st,              l.bus_st,              l.mail_st);
	self.zip 			:= choose(c, (UNSIGNED3)l.bus_zip,   (UNSIGNED3)l.mail_zip,  (UNSIGNED3)l.bus_zip,  (UNSIGNED3)l.mail_zip);
	self.zip4 		:= choose(c, (UNSIGNED2)l.bus_zip4,  (UNSIGNED2)l.mail_zip4, (UNSIGNED2)l.bus_zip4, (UNSIGNED2)l.mail_zip4);
	self.county 		:= choose(c, l.bus_fipscounty,       l.mail_fipscounty,      l.bus_fipscounty,      l.mail_fipscounty);
	self.msa 			:= choose(c, l.bus_msa,              l.mail_msa,             l.bus_msa,             l.mail_msa);
	self.geo_lat 		:= choose(c, l.bus_geo_lat,          l.mail_geo_lat,         l.bus_geo_lat,         l.mail_geo_lat);
	self.geo_long 		:= choose(c, l.bus_geo_long,         l.mail_geo_long,        l.bus_geo_long,        l.mail_geo_long);
	//self.fein := '';
	self.current := true;
	self.dt_first_seen := (unsigned4)l.dt_first_seen;
	self.dt_last_seen := (unsigned4)l.dt_last_seen;
	self.dt_vendor_first_reported := (unsigned4)l.dt_vendor_first_reported;
	self.dt_vendor_last_reported := (unsigned4)l.dt_vendor_last_reported;
	end;

	from_wither_norm := normalize(Wither_Seq, 4, Translate_Wither_to_BHF(left, counter));

	// -- figure out if it is a business, person, or both
	Address.Mac_Is_Business(from_wither_norm,company_name,wither_with_nametype,dodedup := false);

	Layout_wither_entity := recordof(wither_with_nametype);

	wither_Entity 		:= wither_with_nametype(company_name != '');
	wither_nonEntity 	:= wither_with_nametype(company_name  = '');

	// ----------------------------------------
	// -- Back to bus header layout
	// ----------------------------------------
	Business_Header.Layout_Business_Header_New  Translate_Entity_to_BHF(Layout_wither_entity l) := transform
		self := L;
	end;
	Wither_bus := project(Wither_entity(nameType  = 'B'), Translate_Entity_to_BHF(left));


	// -- rollup remaining records
	from_wither_norm_dist := distribute(Wither_bus, hash(group1_id, ut.CleanCompany(company_name)));
	from_wither_norm_sort := sort(from_wither_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	Business_Header.Layout_Business_Header_New RollupWitherNorm(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := transform
	self := l;
	end;

	from_wither_norm_rollup := rollup(from_wither_norm_sort,
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
								  RollupWitherNorm(left, right),
								  local);

	// Calculate stat to determine count by group_id
	Layout_Group_List := record
	from_wither_norm_rollup.group1_id;
	end;

	wither_group_list := table(from_wither_norm_rollup, Layout_Group_List);

	Layout_Group_Stat := record
	wither_group_list.group1_id;
	cnt := count(group);
	end;

	wither_group_stat := table(wither_group_list, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header_New FormatToBHF(Business_Header.Layout_Business_Header_New L, Layout_Group_Stat R) := TRANSForM
	self.group1_id := R.group1_id;
	SELF := L;
	END;

	wither_group_clean := join(from_wither_norm_rollup,
							 wither_group_stat(cnt > 1),
							 left.group1_id = right.group1_id,
							 FormatToBHF(left, right),
							 left outer,
							 lookup);

	// Rollup
	Business_Header.Layout_Business_Header_New Rollupwither(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSForM
	self.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
	self.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	self.company_name := if(L.company_name = '', R.company_name, L.company_name);
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

	wither_clean_dist := distribute(wither_group_clean,
						hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
	wither_clean_sort := sort(wither_clean_dist, zip, prim_range, prim_name, source_group, company_name,
						if(sec_range <> '', 0, 1), sec_range,
						if(phone <> 0, 0, 1), phone,
						if(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
	wither_clean_rollup := rollup(wither_clean_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.source_group = right.source_group and
						  left.company_name = right.company_name and
						  (right.sec_range = '' or left.sec_range = right.sec_range) and
						  (right.phone = 0 or left.phone = right.phone) and
						  (right.fein = 0 or left.fein = right.fein),
						Rollupwither(left, right),
						local);

	return wither_clean_rollup;
  end
 ;
