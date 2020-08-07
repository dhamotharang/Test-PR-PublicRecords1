EXPORT layout_Corporation_Filings_records := RECORD
  //cfr0.level;
  UNSIGNED6 bdid;
  UNSIGNED4 dt_first_seen;
  UNSIGNED4 dt_last_seen;
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
  STRING30 corp_key;
  STRING2 corp_vendor;
  STRING2 corp_state_origin;
  STRING8 corp_process_date;
  STRING32 corp_orig_sos_charter_nbr;
  STRING350 corp_legal_name;
  STRING30 corp_email_address;
  STRING30 corp_web_address;
  STRING30 corp_filing_reference_nbr;
  STRING8 corp_filing_date;
  STRING8 corp_filing_cd;
  STRING60 corp_filing_desc;
  STRING8 corp_status_cd;
  STRING60 corp_status_desc;
  STRING8 corp_status_date;
  STRING8 corp_ticker_symbol;
  STRING8 corp_stock_exchange;
  STRING2 corp_inc_state;
  STRING8 corp_inc_date;
  STRING32 corp_fed_tax_id;
  STRING32 corp_state_tax_id;
  //
  STRING8 corp_sic_code;
  STRING8 corp_orig_bus_type_cd;
  STRING70 corp_orig_bus_type_desc;
  
  STRING60 corp_orig_org_structure_desc;
  
  STRING8 corp_term_exist_cd;
  STRING8 corp_term_exist_exp;
  STRING60 corp_term_exist_desc;
  
  STRING8 corp_address1_type_cd;
  STRING60 corp_address1_type_desc;
  STRING10 corp_addr1_prim_range;
  STRING2 corp_addr1_predir;
  STRING28 corp_addr1_prim_name;
  STRING4 corp_addr1_addr_suffix;
  STRING2 corp_addr1_postdir;
  STRING10 corp_addr1_unit_desig;
  STRING8 corp_addr1_sec_range;
  STRING25 corp_addr1_p_city_name;
  STRING25 corp_addr1_v_city_name;
  STRING2 corp_addr1_state;
  STRING5 corp_addr1_zip5;
  STRING4 corp_addr1_zip4;
  
  STRING100 corp_ra_name;
  
  STRING10 corp_ra_prim_range;
  STRING2 corp_ra_predir;
  STRING28 corp_ra_prim_name;
  STRING4 corp_ra_addr_suffix;
  STRING2 corp_ra_postdir;
  STRING10 corp_ra_unit_desig;
  STRING8 corp_ra_sec_range;
  STRING25 corp_ra_p_city_name;
  STRING25 corp_ra_v_city_name;
  STRING2 corp_ra_state;
  STRING5 corp_ra_zip5;
  STRING4 corp_ra_zip4;

  //
  STRING1 corp_for_profit_ind;
  STRING1 corp_foreign_domestic_ind;
  STRING10 corp_ra_fein;
  STRING9 corp_ra_ssn;
  
  STRING10 corp_phone10;
  STRING10 corp_ra_phone10;
  STRING1 record_type;
  STRING25 corp_state_origin_decoded;
  STRING25 corp_inc_state_decoded;
  STRING25 corp_for_profit_ind_decoded;
  STRING25 corp_foreign_domestic_ind_decoded;
END;
