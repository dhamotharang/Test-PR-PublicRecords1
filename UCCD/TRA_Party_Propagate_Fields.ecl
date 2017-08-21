rec := uccd.Layout_Updated_Party;

mac_forbasic(field) := macro
		self.field := if(r.ucc_vendor <> '' or r.ucc_state_origin <> '' or r.ucc_process_date <> '',
										 r.field, l.field);
endmacro;

mac_forstandard(field) := macro
		self.field := if(r.std_type <> '',
										 r.field, l.field);
endmacro;

mac_foraddress1(field) := macro
		self.field := if(r.address1_eff_date <> '' or r.address1_prim_range <> '' or r.address1_prim_name <> '',
										 r.field, l.field);
endmacro;

mac_foraddress2(field) := macro
		self.field := if(r.address2_eff_date <> '' or r.address2_prim_range <> '' or r.address2_prim_name <> '',
										 r.field, l.field);
endmacro;

mac_forname1(field) := macro
		self.field := if(r.pname1_fname <> '' or r.pname1_lname <> '',
										 r.field, l.field);
endmacro;

mac_forname2(field) := macro
		self.field := if(r.pname2_fname <> '' or r.pname2_lname <> '',
										 r.field, l.field);
endmacro;

mac_forname3(field) := macro
		self.field := if(r.pname3_fname <> '' or r.pname3_lname <> '',
										 r.field, l.field);
endmacro;

mac_forname4(field) := macro
		self.field := if(r.pname4_fname <> '' or r.pname4_lname <> '',
										 r.field, l.field);
endmacro;

mac_forname5(field) := macro
		self.field := if(r.pname5_fname <> '' or r.pname5_lname <> '',
										 r.field, l.field);
endmacro;

export rec TRA_Party_Propagate_Fields(rec l, rec r) := transform
	mac_forbasic(ucc_vendor)
	mac_forbasic(ucc_state_origin)
	mac_forbasic(ucc_process_date)
	mac_forbasic(event_key)
	mac_forbasic(party_key)
	mac_forbasic(collateral_key)

	mac_forstandard(std_type)
	mac_forstandard(type_cd)
	mac_forstandard(type_desc)
	mac_forstandard(role_cd)
	mac_forstandard(role_desc)
	mac_forstandard(name)
	mac_forstandard(std_name_type)
	mac_forstandard(fein)
	mac_forstandard(inc_date)
	mac_forstandard(ssn)
	mac_forstandard(dob)
	mac_forstandard(status_cd)
	mac_forstandard(status_desc)
	mac_forstandard(eff_date)
	mac_forstandard(exp_date)
	
	   //
	mac_foraddress1(phone_number)
	mac_foraddress1(phone_number_type_cd)
	mac_foraddress1(phone_number_type_desc)
	mac_foraddress1(email_address)
	mac_foraddress1(web_address)
		//
		
	mac_foraddress1(address1_type_cd)
	mac_foraddress1(address1_type_desc)
	mac_foraddress1(address1_eff_date)

   //
	mac_foraddress1(address1_prim_range)
	mac_foraddress1(address1_predir)
	mac_foraddress1(address1_prim_name)
	mac_foraddress1(address1_addr_suffix)
	mac_foraddress1(address1_postdir)
	mac_foraddress1(address1_unit_desig)
	mac_foraddress1(address1_sec_range)
 	mac_foraddress1(address1_p_city_name)
	mac_foraddress1(address1_v_city_name)
	mac_foraddress1(address1_st)
	mac_foraddress1(address1_zip)
	mac_foraddress1(address1_zip4)
	mac_foraddress1(address1_cart)
	mac_foraddress1(address1_cr_sort_sz)
	mac_foraddress1(address1_lot)
	mac_foraddress1(address1_lot_order)
	mac_foraddress1(address1_dbpc)
	mac_foraddress1(address1_chk_digit)
	mac_foraddress1(address1_rec_type)
 	mac_foraddress1(address1_fips_st)
	mac_foraddress1(address1_fips_county)
	mac_foraddress1(address1_geo_lat)
	mac_foraddress1(address1_geo_long)
	mac_foraddress1(address1_msa)
	mac_foraddress1(address1_geo_blk)
	mac_foraddress1(address1_geo_match)
	mac_foraddress1(address1_err_stat)
   //
	mac_foraddress2(address2_type_cd)
	mac_foraddress2(address2_type_desc)
	mac_foraddress2(address2_eff_date)
   //
	mac_foraddress2(address2_prim_range)
	mac_foraddress2(address2_predir)
	mac_foraddress2(address2_prim_name)
	mac_foraddress2(address2_addr_suffix)
	mac_foraddress2(address2_postdir)
	mac_foraddress2(address2_unit_desig)
	mac_foraddress2(address2_sec_range)
 	mac_foraddress2(address2_p_city_name)
	mac_foraddress2(address2_v_city_name)
	mac_foraddress2(address2_st)
	mac_foraddress2(address2_zip)
	mac_foraddress2(address2_zip4)
	mac_foraddress2(address2_cart)
	mac_foraddress2(address2_cr_sort_sz)
	mac_foraddress2(address2_lot)
	mac_foraddress2(address2_lot_order)
	mac_foraddress2(address2_dbpc)
	mac_foraddress2(address2_chk_digit)
	mac_foraddress2(address2_rec_type)
 	mac_foraddress2(address2_fips_st)
	mac_foraddress2(address2_fips_county)
	mac_foraddress2(address2_geo_lat)
	mac_foraddress2(address2_geo_long)
	mac_foraddress2(address2_msa)
	mac_foraddress2(address2_geo_blk)
	mac_foraddress2(address2_geo_match)
	mac_foraddress2(address2_err_stat)
	 
	//
	mac_forname1(pname1_title)
	mac_forname1(pname1_fname)
	mac_forname1(pname1_mname)
	mac_forname1(pname1_lname)
	mac_forname1(pname1_name_suffix)
	mac_forname1(pname1_name_score)
	
	mac_forname2(pname2_title)
	mac_forname2(pname2_fname)
	mac_forname2(pname2_mname)
	mac_forname2(pname2_lname)
	mac_forname2(pname2_name_suffix)
	mac_forname2(pname2_name_score)
	
	mac_forname3(pname3_title)
	mac_forname3(pname3_fname)
	mac_forname3(pname3_mname)
	mac_forname3(pname3_lname)
	mac_forname3(pname3_name_suffix)
	mac_forname3(pname3_name_score)
	
	mac_forname4(pname4_title)
	mac_forname4(pname4_fname)
	mac_forname4(pname4_mname)
	mac_forname4(pname4_lname)
	mac_forname4(pname4_name_suffix)
	mac_forname4(pname4_name_score)
	
	mac_forname5(pname5_title)
	mac_forname5(pname5_fname)
	mac_forname5(pname5_mname)
	mac_forname5(pname5_lname)
	mac_forname5(pname5_name_suffix)
	mac_forname5(pname5_name_score)

	self := r;
end;