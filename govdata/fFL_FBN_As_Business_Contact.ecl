import Business_Header, ut,mdr;

export fFL_FBN_As_Business_Contact(dataset(Layout_FL_FBN_In) pInputFBN, dataset(Layout_FL_FBN_Events_In) pInputFBNEvents) :=
function

	f := pInputFBN;
	fev := pInputFBNEvents;

	// Extract Owners from Filings
	Business_Header.Layout_Business_Contact_Full_New ExtractOwners(Layout_FL_FBN_In l, unsigned1 c) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.vendor_id := 'FL' + l.fic_fil_doc_num;
	self.dt_first_seen := (unsigned4)l.fic_fil_date;
	self.dt_last_seen := (unsigned4)map(l.fic_fil_cancellation_date <> '' and l.fic_fil_cancellation_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_cancellation_date,
							 l.fic_fil_expiration_date <> '' and l.fic_fil_expiration_date < Stringlib.GetDateYYYYMMDD() => l.fic_fil_expiration_date,
							 Stringlib.GetDateYYYYMMDD());
	self.prim_range := choose(c,l.fic_owner1_prim_range,l.fic_owner2_prim_range,l.fic_owner3_prim_range,l.fic_owner4_prim_range,l.fic_owner5_prim_range,
								l.fic_owner6_prim_range,l.fic_owner7_prim_range,l.fic_owner8_prim_range,l.fic_owner9_prim_range,l.fic_owner10_prim_range);
	self.predir := choose(c,l.fic_owner1_predir,l.fic_owner2_predir,l.fic_owner3_predir,l.fic_owner4_predir,l.fic_owner5_predir,
								l.fic_owner6_predir,l.fic_owner7_predir,l.fic_owner8_predir,l.fic_owner9_predir,l.fic_owner10_predir);
	self.prim_name := choose(c,l.fic_owner1_prim_name,l.fic_owner2_prim_name,l.fic_owner3_prim_name,l.fic_owner4_prim_name,l.fic_owner5_prim_name,
								l.fic_owner6_prim_name,l.fic_owner7_prim_name,l.fic_owner8_prim_name,l.fic_owner9_prim_name,l.fic_owner10_prim_name);
	self.addr_suffix := choose(c,l.fic_owner1_addr_suffix,l.fic_owner2_addr_suffix,l.fic_owner3_addr_suffix,l.fic_owner4_addr_suffix,l.fic_owner5_addr_suffix,
								l.fic_owner6_addr_suffix,l.fic_owner7_addr_suffix,l.fic_owner8_addr_suffix,l.fic_owner9_addr_suffix,l.fic_owner10_addr_suffix);
	self.postdir := choose(c,l.fic_owner1_postdir,l.fic_owner2_postdir,l.fic_owner3_postdir,l.fic_owner4_postdir,l.fic_owner5_postdir,
								l.fic_owner6_postdir,l.fic_owner7_postdir,l.fic_owner8_postdir,l.fic_owner9_postdir,l.fic_owner10_postdir);
	self.unit_desig := choose(c,l.fic_owner1_unit_desig,l.fic_owner2_unit_desig,l.fic_owner3_unit_desig,l.fic_owner4_unit_desig,l.fic_owner5_unit_desig,
								l.fic_owner6_unit_desig,l.fic_owner7_unit_desig,l.fic_owner8_unit_desig,l.fic_owner9_unit_desig,l.fic_owner10_unit_desig);
	self.sec_range := choose(c,l.fic_owner1_sec_range,l.fic_owner2_sec_range,l.fic_owner3_sec_range,l.fic_owner4_sec_range,l.fic_owner5_sec_range,
								l.fic_owner6_sec_range,l.fic_owner7_sec_range,l.fic_owner8_sec_range,l.fic_owner9_sec_range,l.fic_owner10_sec_range);
	self.city := choose(c,l.fic_owner1_v_city_name,l.fic_owner2_v_city_name,l.fic_owner3_v_city_name,l.fic_owner4_v_city_name,l.fic_owner5_v_city_name,
								l.fic_owner6_v_city_name,l.fic_owner7_v_city_name,l.fic_owner8_v_city_name,l.fic_owner9_v_city_name,l.fic_owner10_v_city_name);
	self.state :=choose(c,l.fic_owner1_st,l.fic_owner2_st,l.fic_owner3_st,l.fic_owner4_st,l.fic_owner5_st,
								l.fic_owner6_st,l.fic_owner7_st,l.fic_owner8_st,l.fic_owner9_st,l.fic_owner10_st);
	self.zip := (unsigned3)choose(c,l.fic_owner1_zip,l.fic_owner2_zip,l.fic_owner3_zip,l.fic_owner4_zip,l.fic_owner5_zip,
								l.fic_owner6_zip,l.fic_owner7_zip,l.fic_owner8_zip,l.fic_owner9_zip,l.fic_owner10_zip);
	self.zip4 := (unsigned2)choose(c,l.fic_owner1_zip4,l.fic_owner2_zip4,l.fic_owner3_zip4,l.fic_owner4_zip4,l.fic_owner5_zip4,
								l.fic_owner6_zip4,l.fic_owner7_zip4,l.fic_owner8_zip4,l.fic_owner9_zip4,l.fic_owner10_zip4);
	self.county := choose(c,l.fic_owner1_fips_county,l.fic_owner2_fips_county,l.fic_owner3_fips_county,l.fic_owner4_fips_county,l.fic_owner5_fips_county,
								l.fic_owner6_fips_county,l.fic_owner7_fips_county,l.fic_owner8_fips_county,l.fic_owner9_fips_county,l.fic_owner10_fips_county);
	self.msa := choose(c,l.fic_owner1_msa,l.fic_owner2_msa,l.fic_owner3_msa,l.fic_owner4_msa,l.fic_owner5_msa,
								l.fic_owner6_msa,l.fic_owner7_msa,l.fic_owner8_msa,l.fic_owner9_msa,l.fic_owner10_msa);
	self.geo_lat := choose(c,l.fic_owner1_geo_lat,l.fic_owner2_geo_lat,l.fic_owner3_geo_lat,l.fic_owner4_geo_lat,l.fic_owner5_geo_lat,
								l.fic_owner6_geo_lat,l.fic_owner7_geo_lat,l.fic_owner8_geo_lat,l.fic_owner9_geo_lat,l.fic_owner10_geo_lat);
	self.geo_long := choose(c,l.fic_owner1_geo_long,l.fic_owner2_geo_long,l.fic_owner3_geo_long,l.fic_owner4_geo_long,l.fic_owner5_geo_long,
								l.fic_owner6_geo_long,l.fic_owner7_geo_long,l.fic_owner8_geo_long,l.fic_owner9_geo_long,l.fic_owner10_geo_long);
	self.phone := 0;
	self.title := choose(c,l.fic_owner1_title,l.fic_owner2_title,l.fic_owner3_title,l.fic_owner4_title,l.fic_owner5_title,
								l.fic_owner6_title,l.fic_owner7_title,l.fic_owner8_title,l.fic_owner9_title,l.fic_owner10_title);
	self.fname := choose(c,l.fic_owner1_fname,l.fic_owner2_fname,l.fic_owner3_fname,l.fic_owner4_fname,l.fic_owner5_fname,
								l.fic_owner6_fname,l.fic_owner7_fname,l.fic_owner8_fname,l.fic_owner9_fname,l.fic_owner10_fname);
	self.mname := choose(c,l.fic_owner1_mname,l.fic_owner2_mname,l.fic_owner3_mname,l.fic_owner4_mname,l.fic_owner5_mname,
								l.fic_owner6_mname,l.fic_owner7_mname,l.fic_owner8_mname,l.fic_owner9_mname,l.fic_owner10_mname);
	self.lname := choose(c,l.fic_owner1_lname,l.fic_owner2_lname,l.fic_owner3_lname,l.fic_owner4_lname,l.fic_owner5_lname,
								l.fic_owner6_lname,l.fic_owner7_lname,l.fic_owner8_lname,l.fic_owner9_lname,l.fic_owner10_lname);
	self.name_suffix := choose(c,l.fic_owner1_name_suffix,l.fic_owner2_name_suffix,l.fic_owner3_name_suffix,l.fic_owner4_name_suffix,l.fic_owner5_name_suffix,
								l.fic_owner6_name_suffix,l.fic_owner7_name_suffix,l.fic_owner8_name_suffix,l.fic_owner9_name_suffix,l.fic_owner10_name_suffix);
	self.name_score := choose(c, Business_Header.CleanName(l.fic_owner1_fname, l.fic_owner1_mname, l.fic_owner1_lname, l.fic_owner1_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner2_fname, l.fic_owner2_mname, l.fic_owner2_lname, l.fic_owner2_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner3_fname, l.fic_owner3_mname, l.fic_owner3_lname, l.fic_owner3_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner4_fname, l.fic_owner4_mname, l.fic_owner4_lname, l.fic_owner4_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner5_fname, l.fic_owner5_mname, l.fic_owner5_lname, l.fic_owner5_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner6_fname, l.fic_owner6_mname, l.fic_owner6_lname, l.fic_owner6_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner7_fname, l.fic_owner7_mname, l.fic_owner7_lname, l.fic_owner7_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner8_fname, l.fic_owner8_mname, l.fic_owner8_lname, l.fic_owner8_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner9_fname, l.fic_owner9_mname, l.fic_owner9_lname, l.fic_owner9_name_suffix)[142],
								 Business_Header.CleanName(l.fic_owner10_fname, l.fic_owner10_mname, l.fic_owner10_lname, l.fic_owner10_name_suffix)[142]);
	self.email_address := '';
	self.company_title := 'OWNER';
	self.company_source_group := 'FL' + l.fic_fil_doc_num;
	self.company_name := Stringlib.StringToUpperCase(l.fic_fil_name);
	self.company_prim_range := l.fic_fil_prim_range;
	self.company_predir := l.fic_fil_predir;
	self.company_prim_name := l.fic_fil_prim_name;
	self.company_addr_suffix := l.fic_fil_addr_suffix;
	self.company_postdir := l.fic_fil_postdir;
	self.company_unit_desig := l.fic_fil_unit_desig;
	self.company_sec_range := l.fic_fil_sec_range;
	self.company_city := l.fic_fil_v_city_name;
	self.company_state := l.fic_fil_st;
	self.company_zip := (unsigned3)l.fic_fil_zip;
	self.company_zip4 := (unsigned2)l.fic_fil_zip4;
	self.company_phone := 0;
	self.company_fein := (unsigned4)l.fic_fil_fei_num;
	self.record_type := if(l.fic_fil_status = 'A', 'C', 'H');          // Current/Historical indicator
	end;

	FL_FBN_Owners_Norm := normalize(f, 10, ExtractOwners(left, counter));

	FL_FBN_Owners := FL_FBN_Owners_Norm(lname <> '');

	// Extract Owners from Events
	Business_Header.Layout_Business_Contact_Full_New ExtractOwnerChange(Layout_FL_FBN_Events_In l, Layout_FL_FBN_In r) := transform
	self.source := MDR.sourceTools.src_FL_FBN;          // Source file type
	self.vendor_id := 'FL' + r.fic_fil_doc_num;
	self.dt_first_seen := (unsigned4)l.event_date;
	self.dt_last_seen := (unsigned4)l.event_date;
	self.prim_range := l.own_prim_range;
	self.predir := l.own_predir;
	self.prim_name := l.own_prim_name;
	self.addr_suffix := l.own_addr_suffix;
	self.postdir := l.own_postdir;
	self.unit_desig := l.own_unit_desig;
	self.sec_range := l.own_sec_range;
	self.city := l.own_v_city_name;
	self.state := l.own_st;
	self.zip := (unsigned3)l.own_zip;
	self.zip4 := (unsigned2)l.own_zip4;
	self.county := l.own_fipscounty;
	self.msa := l.own_msa;
	self.geo_lat := l.own_geo_lat;
	self.geo_long := l.own_geo_long;
	self.phone := 0;
	self.title := l.own_name_prefix;
	self.fname := l.own_name_first;
	self.mname := l.own_name_middle;
	self.lname := l.own_name_last;
	self.name_suffix := l.own_name_suffix;
	self.name_score := Business_Header.CleanName(l.own_name_first, l.own_name_middle, l.own_name_last, l.own_name_suffix)[142];
	self.email_address := '';
	self.company_title := 'OWNER';
	self.company_source_group := 'FL' + r.fic_fil_doc_num;
	self.company_name := Stringlib.StringToUpperCase(r.fic_fil_name);
	self.company_prim_range := r.fic_fil_prim_range;
	self.company_predir := r.fic_fil_predir;
	self.company_prim_name := r.fic_fil_prim_name;
	self.company_addr_suffix := r.fic_fil_addr_suffix;
	self.company_postdir := r.fic_fil_postdir;
	self.company_unit_desig := r.fic_fil_unit_desig;
	self.company_sec_range := r.fic_fil_sec_range;
	self.company_city := r.fic_fil_v_city_name;
	self.company_state := r.fic_fil_st;
	self.company_zip := (unsigned3)r.fic_fil_zip;
	self.company_zip4 := (unsigned2)r.fic_fil_zip4;
	self.company_phone := 0;
	self.company_fein := (unsigned4)r.fic_fil_fei_num;
	self.record_type := 'C';          // Current/Historical indicator
	end;

	FL_FBN_Event_CHO_Init := join(fev(action_code = 'CHO', own_name_last <> ''),
								  dedup(f, fic_fil_doc_num, all),
								  left.event_orig_doc_number = right.fic_fil_doc_num,
								  ExtractOwnerChange(left, right));

	FL_FBN_Event_CHO := FL_FBN_Event_CHO_Init(company_name <> '', lname <> '');

	FL_FBN_Contacts_Combined := FL_FBN_Owners + FL_FBN_Event_CHO;

	return FL_FBN_Contacts_Combined;

end;