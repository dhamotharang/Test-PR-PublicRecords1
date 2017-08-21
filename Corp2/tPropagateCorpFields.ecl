export Layout_Corporate_Direct_Corp_AID tPropagateCorpFields(Layout_Corporate_Direct_Corp_AID l, Layout_Corporate_Direct_Corp_AID r) := 
transform
	PropagateField(unsigned address_type) :=	(address_type = 1 and (r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '')) or
						(address_type = 2 and (r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '')) or
						(address_type = 3 and (r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> ''));
						
	self.corp_vendor := if(r.corp_vendor <> '', r.corp_vendor, l.corp_vendor);
	self.corp_legal_name := if(r.corp_legal_name <> '', r.corp_legal_name, l.corp_legal_name);
	// check to propagate address1
	self.corp_address1_type_cd := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_type_cd, l.corp_address1_type_cd);
	self.corp_address1_type_desc := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_type_desc, l.corp_address1_type_desc);
	self.corp_address1_line1 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line1, l.corp_address1_line1);
	self.corp_address1_line2 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line2, l.corp_address1_line2);
	self.corp_address1_line3 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line3, l.corp_address1_line3);
	self.corp_address1_line4 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line4, l.corp_address1_line4);
	self.corp_address1_line5 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line5, l.corp_address1_line5);
	self.corp_address1_line6 := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_line6 , l.corp_address1_line6 );
	self.corp_address1_effective_date := if(r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '', r.corp_address1_effective_date, l.corp_address1_effective_date);
	// check to propagate address 2
	self.corp_address2_type_cd := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_type_cd, l.corp_address2_type_cd);
	self.corp_address2_type_desc := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_type_desc, l.corp_address2_type_desc);
	self.corp_address2_line1 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line1, l.corp_address2_line1);
	self.corp_address2_line2 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line2, l.corp_address2_line2);
	self.corp_address2_line3 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line3, l.corp_address2_line3);
	self.corp_address2_line4 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line4, l.corp_address2_line4);
	self.corp_address2_line5 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line5, l.corp_address2_line5);
	self.corp_address2_line6 := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_line6 , l.corp_address2_line6 );
	self.corp_address2_effective_date := if(r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '', r.corp_address2_effective_date, l.corp_address2_effective_date);
	// check to propagate phone number
	self.corp_phone_number  := if(r.corp_phone_number <> '', r.corp_phone_number, l.corp_phone_number);
	self.corp_phone_number_type_cd  := if(r.corp_phone_number <> '', r.corp_phone_number_type_cd, l.corp_phone_number_type_cd);
	self.corp_phone_number_type_desc  := if(r.corp_phone_number <> '', r.corp_phone_number_type_desc, l.corp_phone_number_type_desc);
	//
	self.corp_email_address := if(r.corp_email_address <> '', r.corp_email_address, l.corp_email_address);
	self.corp_web_address := if(r.corp_web_address <> '', r.corp_web_address, l.corp_web_address);
	// check to propagate filing  and status info
	self.corp_filing_reference_nbr := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_filing_reference_nbr, l.corp_filing_reference_nbr);
	self.corp_filing_date := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_filing_date, l.corp_filing_date);
	self.corp_filing_cd := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_filing_cd, l.corp_filing_cd);
	self.corp_filing_desc := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_filing_desc, l.corp_filing_desc);
	self.corp_status_cd := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_status_cd, l.corp_status_cd);
	self.corp_status_desc := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_status_desc, l.corp_status_desc);
	self.corp_status_date := if(r.corp_filing_reference_nbr <> '' or r.corp_filing_date <> '' or r.corp_filing_cd <> '' or r.corp_filing_desc <> ''
	  or r.corp_status_cd <> '' or r.corp_status_date <> '' or r.corp_status_desc <> '', r.corp_status_date, l.corp_status_date);
	//
	self.corp_ticker_symbol := if(r.corp_stock_exchange <> '' or r.corp_ticker_symbol <> '', r.corp_ticker_symbol, l.corp_ticker_symbol);
	self.corp_stock_exchange := if(r.corp_stock_exchange <> '' or r.corp_ticker_symbol <> '', r.corp_stock_exchange, l.corp_stock_exchange);
	//
	self.corp_inc_state := if(r.corp_inc_state <> '', r.corp_inc_state, l.corp_inc_state);
	self.corp_inc_date 	:= if(	r.corp_inc_date <> '', 
								r.corp_inc_date, 
								if(	trim(stringlib.StringtoUpperCase(r.corp_filing_desc),left,right) = 'INCORPORATION',
									l.corp_inc_date,
									''
								   )
							  );
	self.corp_fed_tax_id := if(r.corp_fed_tax_id <> '', r.corp_fed_tax_id, l.corp_fed_tax_id);
	self.corp_state_tax_id := if(r.corp_state_tax_id <> '', r.corp_state_tax_id, l.corp_state_tax_id);
	// check to propagate term of existence info
	self.corp_term_exist_cd := if(r.corp_term_exist_cd <> '' or r.corp_term_exist_exp <> '' or r.corp_term_exist_desc <> '', r.corp_term_exist_cd, l.corp_term_exist_cd);
	self.corp_term_exist_exp := if(r.corp_term_exist_cd <> '' or r.corp_term_exist_exp <> '' or r.corp_term_exist_desc <> '', r.corp_term_exist_exp, l.corp_term_exist_exp);
	self.corp_term_exist_desc := if(r.corp_term_exist_cd <> '' or r.corp_term_exist_exp <> '' or r.corp_term_exist_desc <> '', r.corp_term_exist_desc, l.corp_term_exist_desc);
	//
	self.corp_foreign_domestic_ind := if(r.corp_foreign_domestic_ind <> '', r.corp_foreign_domestic_ind, l.corp_foreign_domestic_ind);
	// check to propagate foreign corp info
	self.corp_forgn_state_cd := if(r.corp_forgn_state_cd <> '' or r.corp_forgn_sos_charter_nbr <> '' or r.corp_forgn_date <> '' or r.corp_forgn_state_desc <> '', r.corp_forgn_state_cd, l.corp_forgn_state_cd);
	self.corp_forgn_state_desc := if(r.corp_forgn_state_cd <> '' or r.corp_forgn_sos_charter_nbr <> '' or r.corp_forgn_date <> '' or r.corp_forgn_state_desc <> '', r.corp_forgn_state_desc, l.corp_forgn_state_desc);
	self.corp_forgn_sos_charter_nbr := if(r.corp_forgn_state_cd <> '' or r.corp_forgn_sos_charter_nbr <> '' or r.corp_forgn_date <> '' or r.corp_forgn_state_desc <> '', r.corp_forgn_sos_charter_nbr, l.corp_forgn_sos_charter_nbr);
	self.corp_forgn_date := if(r.corp_forgn_state_cd <> '' or r.corp_forgn_sos_charter_nbr <> '' or r.corp_forgn_date <> '' or r.corp_forgn_state_desc <> '', r.corp_forgn_date, l.corp_forgn_date);
	//
	self.corp_forgn_fed_tax_id := if(r.corp_forgn_fed_tax_id <> '', r.corp_forgn_fed_tax_id, l.corp_forgn_fed_tax_id);
	self.corp_forgn_state_tax_id := if(r.corp_forgn_state_tax_id <> '', r.corp_forgn_state_tax_id, l.corp_forgn_state_tax_id);
	// check to propagate foreign term of existence info
	self.corp_forgn_term_exist_cd := if(r.corp_forgn_term_exist_cd <> '' or r.corp_forgn_term_exist_exp <> '' or r.corp_forgn_term_exist_desc <> '', r.corp_forgn_term_exist_cd, l.corp_forgn_term_exist_cd);
	self.corp_forgn_term_exist_exp := if(r.corp_forgn_term_exist_cd <> '' or r.corp_forgn_term_exist_exp <> '' or r.corp_forgn_term_exist_desc <> '', r.corp_forgn_term_exist_exp, l.corp_forgn_term_exist_exp);
	self.corp_forgn_term_exist_desc := if(r.corp_forgn_term_exist_cd <> '' or r.corp_forgn_term_exist_exp <> '' or r.corp_forgn_term_exist_desc <> '', r.corp_forgn_term_exist_desc, l.corp_forgn_term_exist_desc);
	// check to propagate org structure info
	self.corp_orig_org_structure_cd := if(r.corp_orig_org_structure_cd <> '' or r.corp_orig_org_structure_desc <> '', r.corp_orig_org_structure_cd, l.corp_orig_org_structure_cd);
	self.corp_orig_org_structure_desc := if(r.corp_orig_org_structure_cd <> '' or r.corp_orig_org_structure_desc <> '', r.corp_orig_org_structure_desc, l.corp_orig_org_structure_desc);
	//
	self.corp_for_profit_ind := if(r.corp_for_profit_ind <> '', r.corp_for_profit_ind, l.corp_for_profit_ind);
	// check to propagate business type info
	self.corp_sic_code := if(r.corp_sic_code <> '' or r.corp_orig_bus_type_cd <> '' or r.corp_orig_bus_type_desc <> '', r.corp_sic_code, l.corp_sic_code);
	self.corp_orig_bus_type_cd := if(r.corp_sic_code <> '' or r.corp_orig_bus_type_cd <> '' or r.corp_orig_bus_type_desc <> '', r.corp_orig_bus_type_cd, l.corp_orig_bus_type_cd);
	self.corp_orig_bus_type_desc := if(r.corp_sic_code <> '' or r.corp_orig_bus_type_cd <> '' or r.corp_orig_bus_type_desc <> '', r.corp_orig_bus_type_desc, l.corp_orig_bus_type_desc);
	// check to propagate registered agent info
	self.corp_ra_name := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_name, l.corp_ra_name);
	self.corp_ra_title_cd := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_title_cd, l.corp_ra_title_cd);
	self.corp_ra_title_desc := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_title_desc, l.corp_ra_title_desc);
	self.corp_ra_fein := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_fein, l.corp_ra_fein);
	self.corp_ra_ssn := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_ssn, l.corp_ra_ssn);
	self.corp_ra_dob := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_dob, l.corp_ra_dob);
	self.corp_ra_effective_date := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_effective_date, l.corp_ra_effective_date);
	// check to propagate registered agent address info
	self.corp_ra_address_type_cd := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_type_cd, l.corp_ra_address_type_cd);
	self.corp_ra_address_type_desc := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_type_desc, l.corp_ra_address_type_desc);
	self.corp_ra_address_line1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line1, l.corp_ra_address_line1);
	self.corp_ra_address_line2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line2, l.corp_ra_address_line2);
	self.corp_ra_address_line3 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line3, l.corp_ra_address_line3);
	self.corp_ra_address_line4 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line4, l.corp_ra_address_line4);
	self.corp_ra_address_line5 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line5, l.corp_ra_address_line5);
	self.corp_ra_address_line6 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '', r.corp_ra_address_line6, l.corp_ra_address_line6);
	// check to propagate registered agent phone info
	self.corp_ra_phone_number := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_phone_number <> '', r.corp_ra_phone_number, l.corp_ra_phone_number);
	self.corp_ra_phone_number_type_cd := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_phone_number <> '', r.corp_ra_phone_number_type_cd, l.corp_ra_phone_number_type_cd);
	self.corp_ra_phone_number_type_desc := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_phone_number <> '', r.corp_ra_phone_number_type_desc, l.corp_ra_phone_number_type_desc);
	self.corp_ra_email_address := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_email_address <> '', r.corp_ra_email_address, l.corp_ra_email_address);
	self.corp_ra_web_address := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_web_address <> '', r.corp_ra_web_address, l.corp_ra_web_address);
	// Check to propagate clean corporater addresses
self.corp_addr1_prim_range          := if(PropagateField(1), r.corp_addr1_prim_range         ,l.corp_addr1_prim_range);
self.corp_addr1_predir              := if(PropagateField(1), r.corp_addr1_predir             ,l.corp_addr1_predir);
self.corp_addr1_prim_name           := if(PropagateField(1), r.corp_addr1_prim_name          ,l.corp_addr1_prim_name);
self.corp_addr1_addr_suffix         := if(PropagateField(1), r.corp_addr1_addr_suffix        ,l.corp_addr1_addr_suffix);
self.corp_addr1_postdir             := if(PropagateField(1), r.corp_addr1_postdir            ,l.corp_addr1_postdir);
self.corp_addr1_unit_desig          := if(PropagateField(1), r.corp_addr1_unit_desig         ,l.corp_addr1_unit_desig);
self.corp_addr1_sec_range           := if(PropagateField(1), r.corp_addr1_sec_range          ,l.corp_addr1_sec_range);
self.corp_addr1_p_city_name         := if(PropagateField(1), r.corp_addr1_p_city_name        ,l.corp_addr1_p_city_name);
self.corp_addr1_v_city_name         := if(PropagateField(1), r.corp_addr1_v_city_name        ,l.corp_addr1_v_city_name);
self.corp_addr1_state               := if(PropagateField(1), r.corp_addr1_state              ,l.corp_addr1_state);
self.corp_addr1_zip5                := if(PropagateField(1), r.corp_addr1_zip5               ,l.corp_addr1_zip5);
self.corp_addr1_zip4                := if(PropagateField(1), r.corp_addr1_zip4               ,l.corp_addr1_zip4);
self.corp_addr1_cart                := if(PropagateField(1), r.corp_addr1_cart               ,l.corp_addr1_cart);
self.corp_addr1_cr_sort_sz          := if(PropagateField(1), r.corp_addr1_cr_sort_sz         ,l.corp_addr1_cr_sort_sz);
self.corp_addr1_lot                 := if(PropagateField(1), r.corp_addr1_lot                ,l.corp_addr1_lot);
self.corp_addr1_lot_order           := if(PropagateField(1), r.corp_addr1_lot_order          ,l.corp_addr1_lot_order);
self.corp_addr1_dpbc                := if(PropagateField(1), r.corp_addr1_dpbc               ,l.corp_addr1_dpbc);
self.corp_addr1_chk_digit           := if(PropagateField(1), r.corp_addr1_chk_digit          ,l.corp_addr1_chk_digit);
self.corp_addr1_rec_type            := if(PropagateField(1), r.corp_addr1_rec_type           ,l.corp_addr1_rec_type);
self.corp_addr1_ace_fips_st         := if(PropagateField(1), r.corp_addr1_ace_fips_st        ,l.corp_addr1_ace_fips_st);
self.corp_addr1_county              := if(PropagateField(1), r.corp_addr1_county             ,l.corp_addr1_county);
self.corp_addr1_geo_lat             := if(PropagateField(1), r.corp_addr1_geo_lat            ,l.corp_addr1_geo_lat);
self.corp_addr1_geo_long            := if(PropagateField(1), r.corp_addr1_geo_long           ,l.corp_addr1_geo_long);
self.corp_addr1_msa                 := if(PropagateField(1), r.corp_addr1_msa                ,l.corp_addr1_msa);
self.corp_addr1_geo_blk             := if(PropagateField(1), r.corp_addr1_geo_blk            ,l.corp_addr1_geo_blk);
self.corp_addr1_geo_match           := if(PropagateField(1), r.corp_addr1_geo_match          ,l.corp_addr1_geo_match);
self.corp_addr1_err_stat            := if(PropagateField(1), r.corp_addr1_err_stat           ,l.corp_addr1_err_stat);
self.corp_addr2_prim_range          := if(PropagateField(2), r.corp_addr2_prim_range         ,l.corp_addr2_prim_range);
self.corp_addr2_predir              := if(PropagateField(2), r.corp_addr2_predir             ,l.corp_addr2_predir);
self.corp_addr2_prim_name           := if(PropagateField(2), r.corp_addr2_prim_name          ,l.corp_addr2_prim_name);
self.corp_addr2_addr_suffix         := if(PropagateField(2), r.corp_addr2_addr_suffix        ,l.corp_addr2_addr_suffix);
self.corp_addr2_postdir             := if(PropagateField(2), r.corp_addr2_postdir            ,l.corp_addr2_postdir);
self.corp_addr2_unit_desig          := if(PropagateField(2), r.corp_addr2_unit_desig         ,l.corp_addr2_unit_desig);
self.corp_addr2_sec_range           := if(PropagateField(2), r.corp_addr2_sec_range          ,l.corp_addr2_sec_range);
self.corp_addr2_p_city_name         := if(PropagateField(2), r.corp_addr2_p_city_name        ,l.corp_addr2_p_city_name);
self.corp_addr2_v_city_name         := if(PropagateField(2), r.corp_addr2_v_city_name        ,l.corp_addr2_v_city_name);
self.corp_addr2_state               := if(PropagateField(2), r.corp_addr2_state              ,l.corp_addr2_state);
self.corp_addr2_zip5                := if(PropagateField(2), r.corp_addr2_zip5               ,l.corp_addr2_zip5);
self.corp_addr2_zip4                := if(PropagateField(2), r.corp_addr2_zip4               ,l.corp_addr2_zip4);
self.corp_addr2_cart                := if(PropagateField(2), r.corp_addr2_cart               ,l.corp_addr2_cart);
self.corp_addr2_cr_sort_sz          := if(PropagateField(2), r.corp_addr2_cr_sort_sz         ,l.corp_addr2_cr_sort_sz);
self.corp_addr2_lot                 := if(PropagateField(2), r.corp_addr2_lot                ,l.corp_addr2_lot);
self.corp_addr2_lot_order           := if(PropagateField(2), r.corp_addr2_lot_order          ,l.corp_addr2_lot_order);
self.corp_addr2_dpbc                := if(PropagateField(2), r.corp_addr2_dpbc               ,l.corp_addr2_dpbc);
self.corp_addr2_chk_digit           := if(PropagateField(2), r.corp_addr2_chk_digit          ,l.corp_addr2_chk_digit);
self.corp_addr2_rec_type            := if(PropagateField(2), r.corp_addr2_rec_type           ,l.corp_addr2_rec_type);
self.corp_addr2_ace_fips_st         := if(PropagateField(2), r.corp_addr2_ace_fips_st        ,l.corp_addr2_ace_fips_st);
self.corp_addr2_county              := if(PropagateField(2), r.corp_addr2_county             ,l.corp_addr2_county);
self.corp_addr2_geo_lat             := if(PropagateField(2), r.corp_addr2_geo_lat            ,l.corp_addr2_geo_lat);
self.corp_addr2_geo_long            := if(PropagateField(2), r.corp_addr2_geo_long           ,l.corp_addr2_geo_long);
self.corp_addr2_msa                 := if(PropagateField(2), r.corp_addr2_msa                ,l.corp_addr2_msa);
self.corp_addr2_geo_blk             := if(PropagateField(2), r.corp_addr2_geo_blk            ,l.corp_addr2_geo_blk);
self.corp_addr2_geo_match           := if(PropagateField(2), r.corp_addr2_geo_match          ,l.corp_addr2_geo_match);
self.corp_addr2_err_stat            := if(PropagateField(2), r.corp_addr2_err_stat           ,l.corp_addr2_err_stat);
	// Check to propagate clean registered agent names
	self.corp_ra_title1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_title1, l.corp_ra_title1);
	self.corp_ra_fname1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_fname1, l.corp_ra_fname1);
	self.corp_ra_mname1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_mname1, l.corp_ra_mname1);
	self.corp_ra_lname1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_lname1, l.corp_ra_lname1);
	self.corp_ra_name_suffix1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_name_suffix1, l.corp_ra_name_suffix1);
	self.corp_ra_score1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_score1, l.corp_ra_score1);
	self.corp_ra_title2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_title2, l.corp_ra_title2);
	self.corp_ra_fname2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_fname2, l.corp_ra_fname2);
	self.corp_ra_mname2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_mname2, l.corp_ra_mname2);
	self.corp_ra_lname2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_lname2, l.corp_ra_lname2);
	self.corp_ra_name_suffix2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_name_suffix2, l.corp_ra_name_suffix2);
	self.corp_ra_score2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_score2, l.corp_ra_score2);
	self.corp_ra_cname1 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_cname1, l.corp_ra_cname1);
	self.corp_ra_cname1_score := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_cname1_score, l.corp_ra_cname1_score);
	self.corp_ra_cname2 := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_cname2, l.corp_ra_cname2);
	self.corp_ra_cname2_score := if(r.corp_ra_name <> '' or r.corp_ra_effective_date <> '', r.corp_ra_cname2_score, l.corp_ra_cname2_score);
	// Check to propagate clean registered agent address
self.corp_ra_prim_range             := if(PropagateField(3), r.corp_ra_prim_range            ,l.corp_ra_prim_range);
self.corp_ra_predir                 := if(PropagateField(3), r.corp_ra_predir                ,l.corp_ra_predir);
self.corp_ra_prim_name              := if(PropagateField(3), r.corp_ra_prim_name             ,l.corp_ra_prim_name);
self.corp_ra_addr_suffix            := if(PropagateField(3), r.corp_ra_addr_suffix           ,l.corp_ra_addr_suffix);
self.corp_ra_postdir                := if(PropagateField(3), r.corp_ra_postdir               ,l.corp_ra_postdir);
self.corp_ra_unit_desig             := if(PropagateField(3), r.corp_ra_unit_desig            ,l.corp_ra_unit_desig);
self.corp_ra_sec_range              := if(PropagateField(3), r.corp_ra_sec_range             ,l.corp_ra_sec_range);
self.corp_ra_p_city_name            := if(PropagateField(3), r.corp_ra_p_city_name           ,l.corp_ra_p_city_name);
self.corp_ra_v_city_name            := if(PropagateField(3), r.corp_ra_v_city_name           ,l.corp_ra_v_city_name);
self.corp_ra_state                  := if(PropagateField(3), r.corp_ra_state                 ,l.corp_ra_state);
self.corp_ra_zip5                   := if(PropagateField(3), r.corp_ra_zip5                  ,l.corp_ra_zip5);
self.corp_ra_zip4                   := if(PropagateField(3), r.corp_ra_zip4                  ,l.corp_ra_zip4);
self.corp_ra_cart                   := if(PropagateField(3), r.corp_ra_cart                  ,l.corp_ra_cart);
self.corp_ra_cr_sort_sz             := if(PropagateField(3), r.corp_ra_cr_sort_sz            ,l.corp_ra_cr_sort_sz);
self.corp_ra_lot                    := if(PropagateField(3), r.corp_ra_lot                   ,l.corp_ra_lot);
self.corp_ra_lot_order              := if(PropagateField(3), r.corp_ra_lot_order             ,l.corp_ra_lot_order);
self.corp_ra_dpbc                   := if(PropagateField(3), r.corp_ra_dpbc                  ,l.corp_ra_dpbc);
self.corp_ra_chk_digit              := if(PropagateField(3), r.corp_ra_chk_digit             ,l.corp_ra_chk_digit);
self.corp_ra_rec_type               := if(PropagateField(3), r.corp_ra_rec_type              ,l.corp_ra_rec_type);
self.corp_ra_ace_fips_st            := if(PropagateField(3), r.corp_ra_ace_fips_st           ,l.corp_ra_ace_fips_st);
self.corp_ra_county                 := if(PropagateField(3), r.corp_ra_county                ,l.corp_ra_county);
self.corp_ra_geo_lat                := if(PropagateField(3), r.corp_ra_geo_lat               ,l.corp_ra_geo_lat);
self.corp_ra_geo_long               := if(PropagateField(3), r.corp_ra_geo_long              ,l.corp_ra_geo_long);
self.corp_ra_msa                    := if(PropagateField(3), r.corp_ra_msa                   ,l.corp_ra_msa);
self.corp_ra_geo_blk                := if(PropagateField(3), r.corp_ra_geo_blk               ,l.corp_ra_geo_blk);
self.corp_ra_geo_match              := if(PropagateField(3), r.corp_ra_geo_match             ,l.corp_ra_geo_match);
self.corp_ra_err_stat               := if(PropagateField(3), r.corp_ra_err_stat              ,l.corp_ra_err_stat);
	self := r;
end;