export Corp.Layout_Corp_Cont_Temp TRA_Cont_Propagate_Fields(Corp.Layout_Corp_Cont_Temp l, Corp.Layout_Corp_Cont_Temp r) := transform
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
self.cont_filing_reference_nbr := if(r.cont_filing_reference_nbr <> '' or r.cont_filing_date <> '' or r.cont_filing_cd <> '' or r.cont_filing_desc <> '', r.cont_filing_reference_nbr, l.cont_filing_reference_nbr);
self.cont_filing_date := if(r.cont_filing_reference_nbr <> '' or r.cont_filing_date <> '' or r.cont_filing_cd <> '' or r.cont_filing_desc <> '', r.cont_filing_date, l.cont_filing_date);
self.cont_filing_cd := if(r.cont_filing_reference_nbr <> '' or r.cont_filing_date <> '' or r.cont_filing_cd <> '' or r.cont_filing_desc <> '', r.cont_filing_cd, l.cont_filing_cd);
self.cont_filing_desc := if(r.cont_filing_reference_nbr <> '' or r.cont_filing_date <> '' or r.cont_filing_cd <> '' or r.cont_filing_desc <> '', r.cont_filing_desc, l.cont_filing_desc);
// check to propagate type info
self.cont_type_cd := if(r.cont_type_cd <> '' or r.cont_type_desc <> '', r.cont_type_cd, l.cont_type_cd);
self.cont_type_desc := if(r.cont_type_cd <> '' or r.cont_type_desc <> '', r.cont_type_desc, l.cont_type_desc);
// check to propagate contact name info
self.cont_name := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_name, l.cont_name);
self.cont_title_desc := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_title_desc, l.cont_title_desc);
self.cont_fein := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_fein, l.cont_fein);
self.cont_ssn := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_ssn, l.cont_ssn);
self.cont_dob := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_dob, l.cont_dob);
self.cont_effective_date := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_effective_date, l.cont_effective_date);
// check to propagate contact address info
self.cont_address_type_cd := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_type_cd, l.cont_address_type_cd);
self.cont_address_type_desc := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_type_desc, l.cont_address_type_desc);
self.cont_address_line1 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line1, l.cont_address_line1);
self.cont_address_line2 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line2, l.cont_address_line2);
self.cont_address_line3 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line3, l.cont_address_line3);
self.cont_address_line4 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line4, l.cont_address_line4);
self.cont_address_line5 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line5, l.cont_address_line5);
self.cont_address_line6 := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_line6, l.cont_address_line6);
self.cont_address_effective_date := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_address_effective_date <> '' or r.cont_address_line1 <> '' or r.cont_address_line2 <> '', r.cont_address_effective_date, l.cont_address_effective_date);
// check to propagate contact phone info
self.cont_phone_number := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_phone_number <> '', r.cont_phone_number, l.cont_phone_number);
self.cont_phone_number_type_cd := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_phone_number <> '', r.cont_phone_number_type_cd, l.cont_phone_number_type_cd);
self.cont_phone_number_type_desc := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_phone_number <> '', r.cont_phone_number_type_desc, l.cont_phone_number_type_desc);
self.cont_email_address := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_email_address <> '', r.cont_email_address, l.cont_email_address);
self.cont_web_address := if(r.cont_name <> '' or r.cont_effective_date <> '' or r.cont_web_address <> '', r.cont_web_address, l.cont_web_address);
// Check to propagate clean corporate addresses
MAC_PADDR_Cont(corp_addr1_prim_range,1)
MAC_PADDR_Cont(corp_addr1_predir,1)
MAC_PADDR_Cont(corp_addr1_prim_name,1)
MAC_PADDR_Cont(corp_addr1_addr_suffix,1)
MAC_PADDR_Cont(corp_addr1_postdir,1)
MAC_PADDR_Cont(corp_addr1_unit_desig,1)
MAC_PADDR_Cont(corp_addr1_sec_range,1)
MAC_PADDR_Cont(corp_addr1_p_city_name,1)
MAC_PADDR_Cont(corp_addr1_v_city_name,1)
MAC_PADDR_Cont(corp_addr1_state,1)
MAC_PADDR_Cont(corp_addr1_zip5,1)
MAC_PADDR_Cont(corp_addr1_zip4,1)
MAC_PADDR_Cont(corp_addr1_cart,1)
MAC_PADDR_Cont(corp_addr1_cr_sort_sz,1)
MAC_PADDR_Cont(corp_addr1_lot,1)
MAC_PADDR_Cont(corp_addr1_lot_order,1)
MAC_PADDR_Cont(corp_addr1_dpbc,1)
MAC_PADDR_Cont(corp_addr1_chk_digit,1)
MAC_PADDR_Cont(corp_addr1_rec_type,1)
MAC_PADDR_Cont(corp_addr1_ace_fips_st,1)
MAC_PADDR_Cont(corp_addr1_county,1)
MAC_PADDR_Cont(corp_addr1_geo_lat,1)
MAC_PADDR_Cont(corp_addr1_geo_long,1)
MAC_PADDR_Cont(corp_addr1_msa,1)
MAC_PADDR_Cont(corp_addr1_geo_blk,1)
MAC_PADDR_Cont(corp_addr1_geo_match,1)
MAC_PADDR_Cont(corp_addr1_err_stat,1)
// Check to propagate clean contact names
self.cont_title := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_title, l.cont_title);
self.cont_fname := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_fname, l.cont_fname);
self.cont_mname := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_mname, l.cont_mname);
self.cont_lname := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_lname, l.cont_lname);
self.cont_name_suffix := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_name_suffix, l.cont_name_suffix);
self.cont_score := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_score, l.cont_score);
self.cont_cname := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_cname, l.cont_cname);
self.cont_cname_score := if(r.cont_name <> '' or r.cont_effective_date <> '', r.cont_cname_score, l.cont_cname_score);
// Check to propagate clean contact address
MAC_PADDR_Cont(cont_prim_range,2)
MAC_PADDR_Cont(cont_predir,2)
MAC_PADDR_Cont(cont_prim_name,2)
MAC_PADDR_Cont(cont_addr_suffix,2)
MAC_PADDR_Cont(cont_postdir,2)
MAC_PADDR_Cont(cont_unit_desig,2)
MAC_PADDR_Cont(cont_sec_range,2)
MAC_PADDR_Cont(cont_p_city_name,2)
MAC_PADDR_Cont(cont_v_city_name,2)
MAC_PADDR_Cont(cont_state,2)
MAC_PADDR_Cont(cont_zip5,2)
MAC_PADDR_Cont(cont_zip4,2)
MAC_PADDR_Cont(cont_cart,2)
MAC_PADDR_Cont(cont_cr_sort_sz,2)
MAC_PADDR_Cont(cont_lot,2)
MAC_PADDR_Cont(cont_lot_order,2)
MAC_PADDR_Cont(cont_dpbc,2)
MAC_PADDR_Cont(cont_chk_digit,2)
MAC_PADDR_Cont(cont_rec_type,2)
MAC_PADDR_Cont(cont_ace_fips_st,2)
MAC_PADDR_Cont(cont_county,2)
MAC_PADDR_Cont(cont_geo_lat,2)
MAC_PADDR_Cont(cont_geo_long,2)
MAC_PADDR_Cont(cont_msa,2)
MAC_PADDR_Cont(cont_geo_blk,2)
MAC_PADDR_Cont(cont_geo_match,2)
MAC_PADDR_Cont(cont_err_stat,2)
self := r;
end;