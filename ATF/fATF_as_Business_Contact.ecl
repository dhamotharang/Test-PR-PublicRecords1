IMPORT ut, Business_Header,mdr;

export fATF_as_Business_Contact(dataset(layout_firearms_explosives_out_bip) pInput, boolean IsPRCT = false) :=
function


	//*************************************************************************
	// Translate atf Contacts to Common Business Header Contact Format
	//*************************************************************************

	atf_init := pInput;

	Business_Header.Layout_Business_Contact_Full_New Translate_atf_to_BCF(atf.layout_firearms_explosives_out_Bip  L, INTEGER C) :=
	TRANSFORM
		SELF.bdid := IF(IsPRCT, (integer)L.bdid, 0);
		SELF.DID	:= IF(IsPRCT, (integer)L.did_out, 0);
		self.vl_id := l.license_number;
		self.company_source_group := l.license_number;
		self.vendor_id := l.license_number;
		self.dt_first_seen := (unsigned4)l.date_first_seen;
		self.dt_last_seen := (unsigned4)l.date_last_seen;
		self.source := if(l.record_type = 'F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives);
		SELF.record_type := 'C';     // 'C' = Current, 'H' = Historical
		SELF.company_title := '';

		SELF.title 		:= CHOOSE(C, L.license1_title,  L.license1_title,  L.license2_title,  L.license2_title, 
								   L.license1_title,  L.license1_title,  L.license2_title,  L.license2_title);
		SELF.fname 		:= CHOOSE(C, L.license1_fname,  L.license1_fname,  L.license2_fname,  L.license2_fname, 
								   L.license1_fname,  L.license1_fname,  L.license2_fname,  L.license2_fname);
		SELF.mname 		:= CHOOSE(C, L.license1_mname,  L.license1_mname,  L.license2_mname,  L.license2_mname, 
								   L.license1_mname,  L.license1_mname,  L.license2_mname,  L.license2_mname);
		SELF.lname 		:= CHOOSE(C, L.license1_lname,   L.license1_lname,   L.license2_lname,   L.license2_lname, 
								   L.license1_lname,   L.license1_lname,   L.license2_lname,   L.license2_lname);
		SELF.name_suffix 	:= CHOOSE(C, L.license1_name_suffix, L.license1_name_suffix, L.license2_name_suffix, L.license2_name_suffix, 
								   L.license1_name_suffix, L.license1_name_suffix, L.license2_name_suffix, L.license2_name_suffix);
		SELF.name_score 	:= CHOOSE(C, Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
								   Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
								   Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
								   Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
								   Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
								   Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
								   Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
								   Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142]);
		SELF.phone := (UNSIGNED6)((UNSIGNED8)stringlib.stringfilter(L.Voice_Phone,'01234567889'));
		SELF.prim_range 	:= L.premise_prim_range;
		SELF.predir 		:= L.premise_predir;
		SELF.prim_name 	:= L.premise_prim_name;
		SELF.addr_suffix 	:= L.premise_suffix;
		SELF.postdir 		:= L.premise_postdir;
		SELF.unit_desig 	:= L.premise_unit_desig;
		SELF.sec_range 	:= L.premise_sec_range;
		SELF.city 		:= L.premise_v_city_name;
		SELF.state 		:= L.premise_st;
		SELF.zip 			:= (UNSIGNED3)L.premise_zip;
		SELF.zip4 		:= (UNSIGNED2)L.premise_zip4;
		SELF.county		:= L.premise_fips_county;
		SELF.msa			:= L.premise_msa;
		SELF.geo_lat		:= L.premise_geo_lat;
		SELF.geo_long		:= L.premise_geo_long;

		SELF.company_name 		:= CHOOSE(C, L.license1_cname, 	L.license1_cname, 	   L.license1_cname, 	L.license1_cname, 
									   L.business_cname, 	L.business_cname, 	   L.business_cname, 	L.business_cname); 
		SELF.company_prim_range 	:= CHOOSE(C, L.premise_prim_range, L.mail_prim_range, 	   L.premise_prim_range, L.mail_prim_range, 
									   L.premise_prim_range, L.mail_prim_range, 	   L.premise_prim_range, L.mail_prim_range);
		SELF.company_predir 	:= CHOOSE(C, L.premise_predir, 	L.mail_predir, 	   L.premise_predir, 	L.mail_predir, 
									   L.premise_predir, 	L.mail_predir, 	   L.premise_predir, 	L.mail_predir);
		SELF.company_prim_name 	:= CHOOSE(C, L.premise_prim_name, 	L.mail_prim_name,      L.premise_prim_name, 	L.mail_prim_name, 
									   L.premise_prim_name, 	L.mail_prim_name,      L.premise_prim_name, 	L.mail_prim_name);
		SELF.company_addr_suffix := CHOOSE(C, L.premise_suffix, 	L.mail_suffix,    	   L.premise_suffix, 	L.mail_suffix, 
									   L.premise_suffix, 	L.mail_suffix,         L.premise_suffix, 	L.mail_suffix);
		SELF.company_postdir 	:= CHOOSE(C, L.premise_postdir, 	L.mail_postdir,        L.premise_postdir, 	L.mail_postdir, 
									   L.premise_postdir, 	L.mail_postdir,        L.premise_postdir, 	L.mail_postdir);
		SELF.company_unit_desig 	:= CHOOSE(C, L.premise_unit_desig, L.mail_unit_desig,     L.premise_unit_desig, L.mail_unit_desig, 
									   L.premise_unit_desig, L.mail_unit_desig,     L.premise_unit_desig, L.mail_unit_desig);
		SELF.company_sec_range 	:= CHOOSE(C, L.premise_sec_range, 	L.mail_sec_range,      L.premise_sec_range, 	L.mail_sec_range, 
									   L.premise_sec_range, 	L.mail_sec_range,      L.premise_sec_range, 	L.mail_sec_range);
		SELF.company_city 		:= CHOOSE(C, L.premise_v_city_name,L.mail_v_city_name,    L.premise_v_city_name,L.mail_v_city_name, 
									   L.premise_v_city_name,L.mail_v_city_name,    L.premise_v_city_name,L.mail_v_city_name);
		SELF.company_state 		:= CHOOSE(C, L.premise_st, 		L.mail_st, 		   L.premise_st, 		L.mail_st, 
									   L.premise_st, 		L.mail_st, 		   L.premise_st, 		L.mail_st);
		SELF.company_zip 		:= CHOOSE(C, (UNSIGNED3)L.premise_zip, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.premise_zip, (UNSIGNED3)L.mail_zip, 
									   (UNSIGNED3)L.premise_zip, (UNSIGNED3)L.mail_zip, (UNSIGNED3)L.premise_zip, (UNSIGNED3)L.mail_zip);
		SELF.company_zip4 		:= CHOOSE(C, (UNSIGNED2)L.premise_zip4,(UNSIGNED2)L.mail_zip4,(UNSIGNED2)L.premise_zip4,(UNSIGNED2)L.mail_zip4, 
									   (UNSIGNED2)L.premise_zip4,(UNSIGNED2)L.mail_zip4,(UNSIGNED2)L.premise_zip4,(UNSIGNED2)L.mail_zip4);
		SELF.company_phone 		:= (UNSIGNED6)((UNSIGNED8)stringlib.stringfilter(L.Voice_Phone,'01234567889'));
		SELF.email_address := '';
	END;

	atf_Contacts := NORMALIZE(atf_Init, 8, Translate_atf_to_BCF(LEFT, COUNTER));

	return atf_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix), company_name != '', company_prim_name != '');
end;