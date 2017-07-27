import BIPV2;

export layout_corps_out := RECORD
	string350 corp_legal_name;
	string30  corp_supp_key;
	string2	  corp_vendor;
	string3   corp_vendor_county;
	string5   corp_vendor_subcode;

	string1 	record_type;
	string10  record_date;
	string8	  corp_process_date;
	unsigned4   dt_last_seen;
	string12   bdid;
	BIPV2.IDlayouts.l_key_ids_bare;
	string30  corp_ln_name_type_desc;
	string32  corp_supp_nbr;
	string250 corp_name_comment;
	string60  corp_address1_type_desc; //this is in the spreadsheet but do we want it?
	string10  corp_addr1_prim_range;
	string2   corp_addr1_predir;
	string28  corp_addr1_prim_name;
	string4   corp_addr1_addr_suffix;
	string2   corp_addr1_postdir;
	string10  corp_addr1_unit_desig;
	string8   corp_addr1_sec_range;
	string25  corp_addr1_p_city_name;
	string25  corp_addr1_v_city_name;
	string2   corp_addr1_state;
	string5   corp_addr1_zip5;
	string4   corp_addr1_zip4;
	string70  corp_address1_line1;
	string70  corp_address1_line2;
	string70  corp_address1_line3;
	string70  corp_address1_line4;
	string70  corp_address1_line5;
	string70  corp_address1_line6;
	string8	  corp_address1_effective_date;	
	
	string60  corp_address2_type_desc;
	string10  corp_addr2_prim_range;
	string2   corp_addr2_predir;
	string28  corp_addr2_prim_name;
	string4   corp_addr2_addr_suffix;
	string2   corp_addr2_postdir;
	string10  corp_addr2_unit_desig;
	string8   corp_addr2_sec_range;
	string25  corp_addr2_p_city_name;
	string25  corp_addr2_v_city_name;
	string2   corp_addr2_state;
	string5   corp_addr2_zip5;
	string4   corp_addr2_zip4;
	string70  corp_address2_line1;
	string70  corp_address2_line2;
	string70  corp_address2_line3;
	string70  corp_address2_line4;
	string70  corp_address2_line5;
	string70  corp_address2_line6;
	string8	  corp_address2_effective_date;

	string10  corp_phone10;//using phone10 rather than phone number
	string60  corp_phone_number_type_desc;
	string15  corp_fax_nbr;
	string30  corp_email_address;
	string30  corp_web_address;



	string30  corp_filing_reference_nbr;
	string8	  corp_filing_date;

	string60  corp_filing_desc;
		

	string60  corp_status_desc;
	string8	  corp_status_date;
	string1   corp_standing;
	string350 corp_status_comment;
		
	string8	  corp_ticker_symbol;
	string8	  corp_stock_exchange;
		
	string2	  corp_inc_state;
	string30  corp_inc_county;
	string8	  corp_inc_date;
	string15  corp_anniversary_month;
	string32  corp_fed_tax_id;
	string32  corp_state_tax_id;
	string8	  corp_term_exist_cd;

	string8	  corp_term_exist_exp;
	string60  corp_term_exist_desc;

	string1   corp_foreign_domestic_ind;
	string3	  corp_forgn_state_cd;		
	string60  corp_forgn_state_desc;
	string32  corp_forgn_sos_charter_nbr;
	string8	  corp_forgn_date;
	string32  corp_forgn_fed_tax_id;
	string32  corp_forgn_state_tax_id;
	string8	  corp_forgn_term_exist_cd;

	string8	  corp_forgn_term_exist_exp;
	string60  corp_forgn_term_exist_desc;
		
	string60  corp_orig_org_structure_desc;
	string1	  corp_for_profit_ind;
	string1   corp_public_or_private_ind;
	string25  corp_public_or_private_ind_decoded;
	string8	  corp_sic_code;
	string8   corp_naic_code;

	string350  corp_orig_bus_type_desc;
	string350  corp_entity_desc;
	string32  corp_certificate_nbr;

	string32  corp_internal_nbr;
	string32  corp_previous_nbr;

	string32  corp_microfilm_nbr;
	string5   corp_amendments_filed;
	string50  corp_acts;
	string1   corp_partnership_ind;
	string1   corp_mfg_ind;
	string250 corp_addl_info;

	string10  corp_taxes;
	string8   corp_franchise_taxes;

	string30  corp_tax_program_desc;
		
	string100 corp_ra_name;
	string20 corp_ra_fname1;
	string20 corp_ra_mname1;
	string20 corp_ra_lname1;
	string20 corp_ra_fname2;
	string20 corp_ra_mname2;
	string20 corp_ra_lname2;

	string60  corp_ra_title_desc;
	string10  corp_ra_fein;
	string9	  corp_ra_ssn;
	string8	  corp_ra_dob;
	string8	  corp_ra_effective_date;
	string8   corp_ra_resign_date;
	string5   corp_ra_no_comp;
	string5   corp_ra_no_comp_igs;
	string250 corp_ra_addl_info;
		

	string60  corp_ra_address_type_desc;
	string10  corp_ra_prim_range;
	string2   corp_ra_predir;
	string28  corp_ra_prim_name;
	string4   corp_ra_addr_suffix;
	string2   corp_ra_postdir;
	string10  corp_ra_unit_desig;
	string8   corp_ra_sec_range;
	string25  corp_ra_p_city_name;
	string25  corp_ra_v_city_name;
	string2   corp_ra_state;
	string5   corp_ra_zip5;
	string4   corp_ra_zip4;
  string70 corp_ra_address_line1;
  string70 corp_ra_address_line2;
  string70 corp_ra_address_line3;
  string70 corp_ra_address_line4;
  string70 corp_ra_address_line5;
  string70 corp_ra_address_line6;		
	string10  corp_ra_phone10; //using phone10 rather than phone_number
	string60  corp_ra_phone_number_type_desc;
	string15  corp_ra_fax_nbr;
	string30  corp_ra_email_address;
	string30  corp_ra_web_address;
	end;













