export layout_corpPreClean := record
string8   dt_vendor_first_reported;
string8   dt_vendor_last_reported;
string8   dt_first_seen;
string8   dt_last_seen;
string8   corp_ra_dt_first_seen;
string8   corp_ra_dt_last_seen;
	
string30  corp_key;
string30  corp_supp_key;
string2	  corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2	  corp_state_origin;
string8	  corp_process_date;
string32  corp_orig_sos_charter_nbr;
string3   corp_src_type;
	
string350 corp_legal_name;
string2   corp_ln_name_type_cd;
string30  corp_ln_name_type_desc;
string32  corp_supp_nbr;
string250 corp_name_comment;  //modified length from 100 to 250
	
string8	  corp_address1_type_cd;
string60  corp_address1_type_desc;
string70  corp_address1_line1;
string70  corp_address1_line2;
string70  corp_address1_line3;
string70  corp_address1_line4;
string70  corp_address1_line5;
string70  corp_address1_line6;
string8	  corp_address1_effective_date;
	
string8	  corp_address2_type_cd;
string60  corp_address2_type_desc;
string70  corp_address2_line1;
string70  corp_address2_line2;
string70  corp_address2_line3;
string70  corp_address2_line4;
string70  corp_address2_line5;
string70  corp_address2_line6;
string8	  corp_address2_effective_date;
	
string30  corp_phone_number;
string8	  corp_phone_number_type_cd;
string60  corp_phone_number_type_desc;
string15  corp_fax_nbr;
string30  corp_email_address;
string30  corp_web_address;
	
string30  corp_filing_reference_nbr;
string8	  corp_filing_date;
string8	  corp_filing_cd;
string60  corp_filing_desc;
	
string8	  corp_status_cd;
string60  corp_status_desc;
string8	  corp_status_date;
string1   corp_standing;
string350 corp_status_comment; //modified length from 100 to 350
	
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
string1	  corp_foreign_domestic_ind;
	
string3	  corp_forgn_state_cd;
string60  corp_forgn_state_desc;
string32  corp_forgn_sos_charter_nbr;
string8	  corp_forgn_date;
string32  corp_forgn_fed_tax_id;
string32  corp_forgn_state_tax_id;
string8	  corp_forgn_term_exist_cd;
string8	  corp_forgn_term_exist_exp;
string60  corp_forgn_term_exist_desc;
	
string8	  corp_orig_org_structure_cd;
string60  corp_orig_org_structure_desc;
string1	  corp_for_profit_ind;
string1   corp_public_or_private_ind;
string8	  corp_sic_code;
string8   corp_naic_code;
string8	  corp_orig_bus_type_cd;
string350 corp_orig_bus_type_desc;  //modified length from 70 to 350
string350 corp_entity_desc;         //modified length from 60 to 350
string32  corp_certificate_nbr;
string32  corp_internal_nbr;
string32  corp_previous_nbr;
string32  corp_microfilm_nbr;
string5   corp_amendments_filed;
string50  corp_acts;
string1   corp_partnership_ind;
string1   corp_mfg_ind;
string250 corp_addl_info;        //modified length from 100 to 250

string10  corp_taxes;
string8   corp_franchise_taxes;
string8   corp_tax_program_cd;
string30  corp_tax_program_desc;
	
string100 corp_ra_name;
string8	  corp_ra_title_cd;
string60  corp_ra_title_desc;
string10  corp_ra_fein;
string9	  corp_ra_ssn;
string8	  corp_ra_dob;
string8	  corp_ra_effective_date;
string8   corp_ra_resign_date;
string5   corp_ra_no_comp;
string5   corp_ra_no_comp_igs;
string250 corp_ra_addl_info; //modified length from 100 to 250
	
string8	  corp_ra_address_type_cd;
string60  corp_ra_address_type_desc;
string70  corp_ra_address_line1;
string70  corp_ra_address_line2;
string70  corp_ra_address_line3;
string70  corp_ra_address_line4;
string70  corp_ra_address_line5;
string70  corp_ra_address_line6;
	
string30  corp_ra_phone_number;
string8	  corp_ra_phone_number_type_cd;
string60  corp_ra_phone_number_type_desc;
string15  corp_ra_fax_nbr;
string30  corp_ra_email_address;
string30  corp_ra_web_address;
end;