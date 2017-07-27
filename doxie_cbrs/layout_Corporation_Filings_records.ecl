export layout_Corporation_Filings_records := record
	//cfr0.level;
	unsigned6 bdid;       
	unsigned4 dt_first_seen;
	unsigned4 dt_last_seen;
	unsigned4 dt_vendor_first_reported;
	unsigned4 dt_vendor_last_reported;
	string30  corp_key;
	string2   corp_vendor;
	string2   corp_state_origin;
	string8   corp_process_date;
	string32  corp_orig_sos_charter_nbr;
	string350 corp_legal_name;
	string30  corp_email_address;
	string30  corp_web_address;
	string30  corp_filing_reference_nbr;
	string8   corp_filing_date;
	string8   corp_filing_cd;
	string60  corp_filing_desc;
	string8   corp_status_cd;
	string60  corp_status_desc;
	string8   corp_status_date;
	string8   corp_ticker_symbol;
	string8   corp_stock_exchange;
	string2   corp_inc_state;
	string8   corp_inc_date;
	string32  corp_fed_tax_id;
	string32  corp_state_tax_id;
	//
	string8   corp_sic_code;
	string8   corp_orig_bus_type_cd;
	string70  corp_orig_bus_type_desc;
	
	string60  corp_orig_org_structure_desc;
	
	string8   corp_term_exist_cd;
	string8   corp_term_exist_exp;
	string60  corp_term_exist_desc;
	
	string8   corp_address1_type_cd;
	string60  corp_address1_type_desc;
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
	
	string100 corp_ra_name;
	
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

	//
	string1   corp_for_profit_ind;
	string1   corp_foreign_domestic_ind;
	string10  corp_ra_fein;
	string9   corp_ra_ssn;
	
	string10  corp_phone10;
	string10  corp_ra_phone10;
	STRING1   record_type;     
	string25	corp_state_origin_decoded;
	string25	corp_inc_state_decoded;
	string25	corp_for_profit_ind_decoded;
	string25 	corp_foreign_domestic_ind_decoded;
end;