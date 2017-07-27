export Corp.Layout_Corp_Supp_Temp TRA_Supp_Propagate_Fields(Corp.Layout_Corp_Supp_Temp l, Corp.Layout_Corp_Supp_Temp r) := transform
self.corp_vendor := if(r.corp_vendor <> '', r.corp_vendor, l.corp_vendor);
self.corp_legal_name := if(r.corp_legal_name <> '', r.corp_legal_name, l.corp_legal_name);
// check to propagate corp address1
self.corp_address1_type_cd := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_type_cd, l.corp_address1_type_cd);
self.corp_address1_type_desc := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_type_desc, l.corp_address1_type_desc);
self.corp_address1_line1 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line1, l.corp_address1_line1);
self.corp_address1_line2 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line2, l.corp_address1_line2);
self.corp_address1_line3 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line3, l.corp_address1_line3);
self.corp_address1_line4 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line4, l.corp_address1_line4);
self.corp_address1_line5 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line5, l.corp_address1_line5);
self.corp_address1_line6 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line6 , l.corp_address1_line6 );
self.corp_address1_effective_date := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_effective_date, l.corp_address1_effective_date);
// check to propagate phone number
self.corp_phone_number  := if(r.corp_phone_number <> '', r.corp_phone_number, l.corp_phone_number);
self.corp_phone_number_type_cd  := if(r.corp_phone_number <> '', r.corp_phone_number_type_cd, l.corp_phone_number_type_cd);
self.corp_phone_number_type_desc  := if(r.corp_phone_number <> '', r.corp_phone_number_type_desc, l.corp_phone_number_type_desc);
//
self.corp_email_address := if(r.corp_email_address <> '', r.corp_email_address, l.corp_email_address);
self.corp_web_address := if(r.corp_web_address <> '', r.corp_web_address, l.corp_web_address);
// check to propagate filing info

self.supp_name := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_name, l.supp_name);
self.supp_filing_reference_nbr := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_filing_reference_nbr, l.supp_filing_reference_nbr);
self.supp_filing_date := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_filing_date, l.supp_filing_date);
self.supp_filing_cd := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_filing_cd, l.supp_filing_cd);
self.supp_filing_desc := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_filing_desc, l.supp_filing_desc);
self.supp_exp_date := if(r.supp_name <> '' or r.supp_filing_reference_nbr <> '' or r.supp_filing_date <> '' or r.supp_exp_date <> '' or r.supp_filing_cd <> '' or r.supp_filing_desc <> '', r.supp_exp_date, l.supp_exp_date);
// check to propagate type info
self.supp_type_cd := if(r.supp_type_cd <> '' or r.supp_type_desc <> '', r.supp_type_cd, l.supp_type_cd);
self.supp_type_desc := if(r.supp_type_cd <> '' or r.supp_type_desc <> '', r.supp_type_desc, l.supp_type_desc);
// check to propagate location info
self.supp_location_cd := if(r.supp_location_cd <> '' or r.supp_location_desc <> '', r.supp_location_cd, l.supp_location_cd);
self.supp_location_desc := if(r.supp_location_cd <> '' or r.supp_location_desc <> '', r.supp_location_desc, l.supp_location_desc);
// check to propagate contact address info
self.supp_address_type_cd := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_type_cd, l.supp_address_type_cd);
self.supp_address_type_desc := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_type_desc, l.supp_address_type_desc);
self.supp_address_line1 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line1, l.supp_address_line1);
self.supp_address_line2 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line2, l.supp_address_line2);
self.supp_address_line3 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line3, l.supp_address_line3);
self.supp_address_line4 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line4, l.supp_address_line4);
self.supp_address_line5 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line5, l.supp_address_line5);
self.supp_address_line6 := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_line6, l.supp_address_line6);
self.supp_address_effective_date := if(r.supp_name <> '' or r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> '', r.supp_address_effective_date, l.supp_address_effective_date);
// check to propagate supplemental name info
self.supp_cont_name := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_name, l.supp_cont_name);
self.supp_cont_title_cd := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_title_cd, l.supp_cont_title_cd);
self.supp_cont_title_desc := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_title_desc, l.supp_cont_title_desc);
self.supp_cont_fein := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_fein, l.supp_cont_fein);
self.supp_cont_ssn := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_ssn, l.supp_cont_ssn);
self.supp_cont_dob := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_dob, l.supp_cont_dob);
self.supp_cont_effective_date := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_effective_date, l.supp_cont_effective_date);
// check to propagate contact phone info
self.supp_phone_number := if(r.supp_phone_number <> '', r.supp_phone_number, l.supp_phone_number);
self.supp_phone_number_type_cd := if(r.supp_phone_number <> '', r.supp_phone_number_type_cd, l.supp_phone_number_type_cd);
self.supp_phone_number_type_desc := if(r.supp_phone_number <> '', r.supp_phone_number_type_desc, l.supp_phone_number_type_desc);
self.supp_email_address := if(r.supp_email_address <> '' , r.supp_email_address, l.supp_email_address);
self.supp_web_address := if(r.supp_web_address <> '', r.supp_web_address, l.supp_web_address);
// Check to propagate clean corporate addresses
MAC_PADDR_Supp(corp_addr1_prim_range,1)
MAC_PADDR_Supp(corp_addr1_predir,1)
MAC_PADDR_Supp(corp_addr1_prim_name,1)
MAC_PADDR_Supp(corp_addr1_addr_suffix,1)
MAC_PADDR_Supp(corp_addr1_postdir,1)
MAC_PADDR_Supp(corp_addr1_unit_desig,1)
MAC_PADDR_Supp(corp_addr1_sec_range,1)
MAC_PADDR_Supp(corp_addr1_p_city_name,1)
MAC_PADDR_Supp(corp_addr1_v_city_name,1)
MAC_PADDR_Supp(corp_addr1_state,1)
MAC_PADDR_Supp(corp_addr1_zip5,1)
MAC_PADDR_Supp(corp_addr1_zip4,1)
MAC_PADDR_Supp(corp_addr1_cart,1)
MAC_PADDR_Supp(corp_addr1_cr_sort_sz,1)
MAC_PADDR_Supp(corp_addr1_lot,1)
MAC_PADDR_Supp(corp_addr1_lot_order,1)
MAC_PADDR_Supp(corp_addr1_dpbc,1)
MAC_PADDR_Supp(corp_addr1_chk_digit,1)
MAC_PADDR_Supp(corp_addr1_rec_type,1)
MAC_PADDR_Supp(corp_addr1_ace_fips_st,1)
MAC_PADDR_Supp(corp_addr1_county,1)
MAC_PADDR_Supp(corp_addr1_geo_lat,1)
MAC_PADDR_Supp(corp_addr1_geo_long,1)
MAC_PADDR_Supp(corp_addr1_msa,1)
MAC_PADDR_Supp(corp_addr1_geo_blk,1)
MAC_PADDR_Supp(corp_addr1_geo_match,1)
MAC_PADDR_Supp(corp_addr1_err_stat,1)
// Check to propagate clean contact names
self.supp_cont_title1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_title1, l.supp_cont_title1);
self.supp_cont_fname1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_fname1, l.supp_cont_fname1);
self.supp_cont_mname1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_mname1, l.supp_cont_mname1);
self.supp_cont_lname1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_lname1, l.supp_cont_lname1);
self.supp_cont_name_suffix1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_name_suffix1, l.supp_cont_name_suffix1);
self.supp_cont_score1 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_score1, l.supp_cont_score1);
self.supp_cont_title2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_title2, l.supp_cont_title2);
self.supp_cont_fname2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_fname2, l.supp_cont_fname2);
self.supp_cont_mname2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_mname2, l.supp_cont_mname2);
self.supp_cont_lname2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_lname2, l.supp_cont_lname2);
self.supp_cont_name_suffix2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_name_suffix2, l.supp_cont_name_suffix2);
self.supp_cont_score2 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_score2, l.supp_cont_score2);
self.supp_cont_title3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_title3, l.supp_cont_title3);
self.supp_cont_fname3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_fname3, l.supp_cont_fname3);
self.supp_cont_mname3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_mname3, l.supp_cont_mname3);
self.supp_cont_lname3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_lname3, l.supp_cont_lname3);
self.supp_cont_name_suffix3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_name_suffix3, l.supp_cont_name_suffix3);
self.supp_cont_score3 := if(r.supp_cont_name <> '' or r.supp_cont_effective_date <> '', r.supp_cont_score3, l.supp_cont_score3);
self.supp_cname1 := if(r.supp_name <> '' or r.supp_cont_effective_date <> '', r.supp_cname1, l.supp_cname1);
self.supp_cname1_score := if(r.supp_name <> '' or r.supp_cont_effective_date <> '', r.supp_cname1_score, l.supp_cname1_score);
self.supp_cname2 := if(r.supp_name <> '' or r.supp_cont_effective_date <> '', r.supp_cname2, l.supp_cname2);
self.supp_cname2_score := if(r.supp_name <> '' or r.supp_cont_effective_date <> '', r.supp_cname2_score, l.supp_cname2_score);
// Check to propagate clean contact address
MAC_PADDR_Supp(supp_cont_prim_range,2)
MAC_PADDR_Supp(supp_cont_predir,2)
MAC_PADDR_Supp(supp_cont_prim_name,2)
MAC_PADDR_Supp(supp_cont_addr_suffix,2)
MAC_PADDR_Supp(supp_cont_postdir,2)
MAC_PADDR_Supp(supp_cont_unit_desig,2)
MAC_PADDR_Supp(supp_cont_sec_range,2)
MAC_PADDR_Supp(supp_cont_p_city_name,2)
MAC_PADDR_Supp(supp_cont_v_city_name,2)
MAC_PADDR_Supp(supp_cont_state,2)
MAC_PADDR_Supp(supp_cont_zip5,2)
MAC_PADDR_Supp(supp_cont_zip4,2)
MAC_PADDR_Supp(supp_cont_cart,2)
MAC_PADDR_Supp(supp_cont_cr_sort_sz,2)
MAC_PADDR_Supp(supp_cont_lot,2)
MAC_PADDR_Supp(supp_cont_lot_order,2)
MAC_PADDR_Supp(supp_cont_dpbc,2)
MAC_PADDR_Supp(supp_cont_chk_digit,2)
MAC_PADDR_Supp(supp_cont_rec_type,2)
MAC_PADDR_Supp(supp_cont_ace_fips_st,2)
MAC_PADDR_Supp(supp_cont_county,2)
MAC_PADDR_Supp(supp_cont_geo_lat,2)
MAC_PADDR_Supp(supp_cont_geo_long,2)
MAC_PADDR_Supp(supp_cont_msa,2)
MAC_PADDR_Supp(supp_cont_geo_blk,2)
MAC_PADDR_Supp(supp_cont_geo_match,2)
MAC_PADDR_Supp(supp_cont_err_stat,2)
self := r;
end;