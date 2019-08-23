IMPORT header,business_header,mdr,_Validate,Address,PRTE2_ATF, ATF;

EXPORT as_headers := MODULE

	//For Person Records
	EXPORT person_header_ATF := FUNCTION
		RETURN ATF.ATF_as_header(PRTE2_ATF.files.ATF_Header,,true);
	END;
																		
	//For Business Records
	EXPORT business_header_ATF := FUNCTION
		RETURN ATF.fATF_as_Business_Header(PRTE2_ATF.files.ATF_Header, true);
	END;
	
	//For Business records with contacts
	EXPORT business_contacts_atf := FUNCTION
		RETURN ATF.fATF_as_Business_Contact(PRTE2_ATF.files.ATF_Header, true);
	END;
	
	//New Business Header with Contacts
	 Business_Header.Layout_Business_Linking.Linking_Interface Translate_atf_to_BCF_new(PRTE2_ATF.Layouts.base L, integer c) := TRANSFORM
	 	SELF.source 					            := if(L.record_type = 'F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives);
		SELF.dt_first_seen 				        := IF(_Validate.Date.fIsValid(L.date_first_seen),(INTEGER)L.date_first_seen,0);
		SELF.dt_last_seen 				        := IF(_Validate.Date.fIsValid(L.date_last_seen),(INTEGER)L.date_last_seen,0);
		SELF.company_bdid 						    := (integer)L.bdid;
		SELF.contact_did                  := (integer)L.did_out;
		SELF.company_name 			      	  := CHOOSE(C, L.license1_cname, 	L.license1_cname, 	   L.license2_cname, 	L.license2_cname, 
																									L.business_cname, 	L.business_cname, 	   L.business_cname, 	L.business_cname);
	  SELF.vl_id 			            		  := L.license_number;	
		SELF.current                      := TRUE;		
	  SELF.company_address.prim_range   := CHOOSE(C, L.premise_prim_range, L.mail_prim_range, L.premise_prim_range, L.mail_prim_range, 
																									L.premise_prim_range, L.mail_prim_range, L.premise_prim_range, L.mail_prim_range);
	  SELF.company_address.predir       := CHOOSE(C, L.premise_predir, L.mail_predir, L.premise_predir, L.mail_predir, 
																									L.premise_predir, L.mail_predir, L.premise_predir, L.mail_predir);
	  SELF.company_address.prim_name    := CHOOSE(C, L.premise_prim_name, L.mail_prim_name, L.premise_prim_name, L.mail_prim_name, 
																									L.premise_prim_name, L.mail_prim_name, L.premise_prim_name, L.mail_prim_name);
	  SELF.company_address.addr_suffix  := CHOOSE(C, L.premise_suffix, L.mail_suffix, L.premise_suffix, L.mail_suffix, 
																									L.premise_suffix, L.mail_suffix, L.premise_suffix, L.mail_suffix);
	  SELF.company_address.postdir      := CHOOSE(C, L.premise_postdir, L.mail_postdir, L.premise_postdir, L.mail_postdir, 
																									L.premise_postdir, 	L.mail_postdir, L.premise_postdir, L.mail_postdir);
	  SELF.company_address.unit_desig   := CHOOSE(C, L.premise_unit_desig, L.mail_unit_desig, L.premise_unit_desig, L.mail_unit_desig, 
																									L.premise_unit_desig, L.mail_unit_desig, L.premise_unit_desig, L.mail_unit_desig);
	  SELF.company_address.sec_range    := CHOOSE(C, L.premise_sec_range, L.mail_sec_range, L.premise_sec_range, L.mail_sec_range, 
																									L.premise_sec_range, L.mail_sec_range, L.premise_sec_range, L.mail_sec_range);
	  SELF.company_address.p_city_name  := CHOOSE(C, L.premise_p_city_name,L.mail_p_city_name, L.premise_p_city_name,L.mail_p_city_name, 
																									L.premise_p_city_name,L.mail_p_city_name, L.premise_p_city_name,L.mail_p_city_name);
	  SELF.company_address.v_city_name  := CHOOSE(C, L.premise_v_city_name,L.mail_v_city_name, L.premise_v_city_name,L.mail_v_city_name, 
																									L.premise_v_city_name,L.mail_v_city_name, L.premise_v_city_name,L.mail_v_city_name);
	  SELF.company_address.st           := CHOOSE(C, L.premise_st, L.mail_st, L.premise_st, L.mail_st, 
																									L.premise_st, L.mail_st, L.premise_st, L.mail_st);
	  SELF.company_address.zip          := CHOOSE(C, L.premise_zip, L.mail_zip, L.premise_zip, L.mail_zip, 
																										L.premise_zip, L.mail_zip, L.premise_zip, L.mail_zip);
	  SELF.company_address.zip4         := CHOOSE(C, L.premise_zip4,L.mail_zip4,L.premise_zip4,L.mail_zip4, 
																									L.premise_zip4,L.mail_zip4,L.premise_zip4,L.mail_zip4);
	  SELF.company_address.cart         := CHOOSE(C, L.premise_cart,L.mail_cart,L.premise_cart,L.mail_cart, 
																									L.premise_cart,L.mail_cart,L.premise_cart,L.mail_cart);
	  SELF.company_address.cr_sort_sz   := CHOOSE(C, L.premise_cr_sort_sz,L.mail_cr_sort_sz,L.premise_cr_sort_sz,L.mail_cr_sort_sz, 
																									L.premise_cr_sort_sz,L.mail_cr_sort_sz,L.premise_cr_sort_sz,L.mail_cr_sort_sz);
	  SELF.company_address.lot          := CHOOSE(C, L.premise_lot,L.mail_lot,L.premise_lot,L.mail_lot, 
																									L.premise_lot,L.mail_lot,L.premise_lot,L.mail_lot);
	  SELF.company_address.lot_order    := CHOOSE(C, L.premise_lot_order,L.mail_lot_order,L.premise_lot_order,L.mail_lot_order, 
																									L.premise_lot_order,L.mail_lot_order,L.premise_lot_order,L.mail_lot_order);
	  SELF.company_address.dbpc         := CHOOSE(C, L.premise_dpbc,L.mail_dpbc,L.premise_dpbc,L.mail_dpbc, 
																									L.premise_dpbc,L.mail_dpbc,L.premise_dpbc,L.mail_dpbc);
	  SELF.company_address.chk_digit    := CHOOSE(C, L.premise_chk_digit,L.mail_chk_digit,L.premise_chk_digit,L.mail_chk_digit, 
																									L.premise_chk_digit,L.mail_chk_digit,L.premise_chk_digit,L.mail_chk_digit);
	  SELF.company_address.fips_state   := CHOOSE(C, L.premise_fips_st,L.mail_fips_st,L.premise_fips_st,L.mail_fips_st, 
																									L.premise_fips_st,L.mail_fips_st,L.premise_fips_st,L.mail_fips_st);
	  SELF.company_address.fips_county  := CHOOSE(C, L.premise_fips_county,L.mail_fips_county,L.premise_fips_county,L.mail_fips_county, 
																									L.premise_fips_county,L.mail_fips_county,L.premise_fips_county,L.mail_fips_county);
	  SELF.company_address.geo_lat      := CHOOSE(C, L.premise_geo_lat,L.mail_geo_lat,L.premise_geo_lat,L.mail_geo_lat, 
																									L.premise_geo_lat,L.mail_geo_lat,L.premise_geo_lat,L.mail_geo_lat);
	  SELF.company_address.geo_long     := CHOOSE(C, L.premise_geo_long,L.mail_geo_long,L.premise_geo_long,L.mail_geo_long, 
																									L.premise_geo_long,L.mail_geo_long,L.premise_geo_long,L.mail_geo_long);
	  SELF.company_address.msa          := CHOOSE(C, L.premise_msa,L.mail_msa,L.premise_msa,L.mail_msa, 
																									L.premise_msa,L.mail_msa,L.premise_msa,L.mail_msa);
	  SELF.company_address.geo_blk      := CHOOSE(C, L.premise_geo_blk,L.mail_geo_blk,L.premise_geo_blk,L.mail_geo_blk, 
																									L.premise_geo_blk,L.mail_geo_blk,L.premise_geo_blk,L.mail_geo_blk);
	  SELF.company_address.geo_match    := CHOOSE(C, L.premise_geo_match,L.mail_geo_match,L.premise_geo_match,L.mail_geo_match, 
																									L.premise_geo_match,L.mail_geo_match,L.premise_geo_match,L.mail_geo_match);
	  SELF.company_address.err_stat     := CHOOSE(C, L.premise_err_stat,L.mail_err_stat,L.premise_err_stat,L.mail_err_stat, 
																									L.premise_err_stat,L.mail_err_stat,L.premise_err_stat,L.mail_err_stat);
		SELF.contact_name.title           := CHOOSE(C, L.license1_title, L.license1_title, L.license2_title, L.license2_title, 
																									L.license1_title, L.license1_title, L.license2_title, L.license2_title);
		SELF.contact_name.fname           := CHOOSE(C, L.license1_fname, L.license1_fname, L.license2_fname, L.license2_fname, 
																									L.license1_fname, L.license1_fname, L.license2_fname, L.license2_fname);
		SELF.contact_name.mname           := CHOOSE(C, L.license1_mname, L.license1_mname, L.license2_mname, L.license2_mname, 
																									L.license1_mname, L.license1_mname, L.license2_mname, L.license2_mname);		
		SELF.contact_name.lname           := CHOOSE(C, L.license1_lname, L.license1_lname, L.license2_lname, L.license2_lname, 
																									L.license1_lname, L.license1_lname, L.license2_lname, L.license2_lname);		
		SELF.contact_name.name_suffix     := CHOOSE(C, L.license1_name_suffix, L.license1_name_suffix, L.license2_name_suffix, L.license2_name_suffix, 
																									L.license1_name_suffix, L.license1_name_suffix, L.license2_name_suffix, L.license2_name_suffix); 		
		SELF.contact_name.name_score      := CHOOSE(C, Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
																									Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
																									Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
																									Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
																									Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
																									Business_Header.CleanName(L.license1_fname,L.license1_mname,L.license1_lname,L.license1_name_suffix)[142],
																									Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142],
																									Business_Header.CleanName(L.license2_fname,L.license2_mname,L.license2_lname,L.license2_name_suffix)[142]);
		SELF 																:= L;
		SELF 																:= [];
	END;

  atf_for_new_bh        := normalize(PRTE2_ATF.files.ATF_Header,8,Translate_atf_to_BCF_new(left,counter));
	atf_for_new_bh_filter := atf_for_new_bh(company_address.prim_range<>'' and company_address.prim_name<>'' and company_address.zip<>'');

export new_business_header_atf := atf_for_new_bh_filter(company_name != '' and company_bdid>0); 

END;
	
	