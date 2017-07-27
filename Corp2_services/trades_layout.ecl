export trades_layout := RECORD

	string30  corp_supp_key;
	string32 corp_certificate_nbr;
	string350 corp_legal_name;
	string1 	record_type;
	string8	  corp_process_date;
	string60 corp_status_desc;
	string8	  corp_term_exist_cd;
	string8	  corp_term_exist_exp;
	string60  corp_term_exist_desc;
	
	string2	  corp_vendor;
	string3   corp_vendor_county;
	string5   corp_vendor_subcode;
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


	string70  corp_orig_bus_type_desc;
	unsigned4   dt_last_seen;
	string30  corp_ln_name_type_desc;
	string32  corp_supp_nbr;
	string100 corp_name_comment;
	string30  corp_filing_reference_nbr;
	string8	  corp_filing_date;

	string60  corp_filing_desc;
	dataset(layout_events_out) events {maxcount(25)};
END;