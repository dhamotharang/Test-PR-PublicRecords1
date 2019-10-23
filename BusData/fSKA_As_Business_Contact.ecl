import business_header, ut, address,mdr;

export fSKA_As_Business_Contact(

	 dataset(Layout_SKA_Verified_bdid	) pSka_Verified_Base	= File_SKA_Verified_Base
	,dataset(Layout_SKA_Nixie_bdid		) pSka_Nixie_base			= File_SKA_Nixie_Base		

) :=
function

	Layout_SKA_Verified_Local := record
	unsigned6 record_id := 0;
	Layout_SKA_Verified_bdid;
	end;

	Layout_BCF_Local := record
	Business_Header.Layout_Business_Contact_Full_New;
	unsigned6 orig_id;
	end;

	// Add unique record id to SKA Verified file
	Layout_SKA_Verified_Local AddRecordID(Layout_SKA_Verified_bdid l) := transform
	self := l;
	end;

	SKA_Verified_Init := project(pSka_Verified_Base, AddRecordID(left));

	ut.MAC_Sequence_Records(SKA_Verified_Init, record_id, SKA_Verified_Seq)

	Layout_BCF_Local Translate_SKA_Verfied_to_BCF(Layout_SKA_Verified_Local l, integer CTR) := transform
	self.orig_id := l.record_id;
	self.dt_first_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_last_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.vl_id := 'SKAV' + l.id;
	self.vendor_id := 'SKAV' + l.persid;
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
	self.phone := (unsigned6)address.CleanPhone(l.phone);
	self.source := MDR.sourceTools.src_SKA;
	self.company_title := Stringlib.StringToUpperCase(l.T1);
	self.title := l.title;
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.name_score := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142];
	self.email_address := '';
	self.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
	self.company_source_group := '';
	self.company_prim_range := choose(CTR, l.mail_prim_range, l.alt_prim_range);
	self.company_predir := choose(CTR, l.mail_predir, l.alt_predir);
	self.company_prim_name := choose(CTR, l.mail_prim_name, l.alt_prim_name);
	self.company_addr_suffix := choose(CTR, l.mail_addr_suffix, l.alt_addr_suffix);
	self.company_postdir := choose(CTR, l.mail_postdir, l.alt_postdir);
	self.company_unit_desig := choose(CTR, l.mail_unit_desig, l.alt_unit_desig);
	self.company_sec_range := choose(CTR, l.mail_sec_range, l.alt_sec_range);
	self.company_city := choose(CTR, l.mail_v_city_name, l.alt_v_city_name);
	self.company_state := choose(CTR, l.mail_st, l.alt_st);
	self.company_zip := choose(CTR, (unsigned3)l.mail_zip, (unsigned3)l.alt_zip);
	self.company_zip4 := choose(CTR, (unsigned2)l.mail_zip4, (unsigned2)l.alt_zip4);
	self.company_phone := (unsigned6)address.CleanPhone(l.phone);
	self.record_type := 'C';
	self := l;
	end;

	from_ska_verified_norm := normalize(SKA_Verified_Seq, 2, Translate_SKA_Verfied_to_BCF(left, counter));
	from_ska_verified_norm_dist := distribute(from_ska_verified_norm, hash(orig_id, company_name));
	from_ska_verified_norm_sort := sort(from_ska_verified_norm_dist, orig_id, company_name,  -zip, -state, -city, local);

	Layout_BCF_Local RollupSKAVerifiedNorm(Layout_BCF_Local l, Layout_BCF_Local r) := transform
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
								  
	Business_Header.Layout_Business_Contact_Full_New Format_to_BCF(Layout_BCF_Local l) := transform
	self := l;
	end;

	contacts_ska_verified := project(from_ska_verified_norm_rollup, Format_to_BCF(left));

	Business_Header.Layout_Business_Contact_Full_New Translate_SKA_Nixie_to_BCF(Layout_SKA_Nixie_bdid l) := transform
	self.dt_first_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.dt_last_seen := (unsigned4)Stringlib.GetDateYYYYMMDD();
	self.vl_id := 'SKAN' + l.persid;
	self.vendor_id := 'SKAN' + l.persid;
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
	self.geo_lat := l.mail_geo_lat;
	self.geo_long := l.mail_geo_long;
	self.phone := (unsigned6)address.CleanPhone(if(l.area_code <> '', l.area_code, '000') + l.NUMBER);
	self.source := MDR.sourceTools.src_SKA;
	self.company_title := Stringlib.StringToUpperCase(l.T1);
	self.title := l.title;
	self.fname := l.fname;
	self.mname := l.mname;
	self.lname := l.lname;
	self.name_score := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142];
	self.email_address := '';
	self.company_name := Stringlib.StringToUpperCase(l.COMPANY1);
	self.company_source_group := '';
	self.company_prim_range := l.mail_prim_range;
	self.company_predir := l.mail_predir;
	self.company_prim_name := l.mail_prim_name;
	self.company_addr_suffix := l.mail_addr_suffix;
	self.company_postdir := l.mail_postdir;
	self.company_unit_desig := l.mail_unit_desig;
	self.company_sec_range := l.mail_sec_range;
	self.company_city := l.mail_v_city_name;
	self.company_state := l.mail_st;
	self.company_zip := (unsigned3)l.mail_zip;
	self.company_zip4 := (unsigned2)l.mail_zip4;
	self.company_phone := (unsigned6)address.CleanPhone(if(l.area_code <> '', l.area_code, '000') + l.NUMBER);
	self.record_type := 'C';
	self := l;
	end;

	contacts_ska_nixie := project(pSka_Nixie_base, Translate_SKA_Nixie_to_BCF(left));
	return contacts_ska_verified + contacts_ska_nixie;

end;