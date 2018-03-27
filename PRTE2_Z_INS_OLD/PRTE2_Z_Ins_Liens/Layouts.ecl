//--------------------------------------------------------------------
// PRTE2_Liens.Layouts
// Project on hold.
// CT Liens are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

IMPORT PRTE2_Liens ,PRTE_CSV;

EXPORT Layouts := MODULE

	EXPORT Base_main	:= RECORD
		string tmsid;									//LN Internal unique case id
		string rmsid;									//LN Internal Case Event ID
		string process_date;
		string record_code;
		string date_vendor_removed;
		string filing_jurisdiction;
		string filing_state;
		string orig_filing_number;
		string orig_filing_type;
		string orig_filing_date;
		string orig_filing_time;
		string case_number;
		string filing_number;
		string filing_type_desc;
		string filing_date;
		string filing_time;
		string vendor_entry_date;
		string judge;
		string case_title;
		string filing_book;
		string filing_page;
		string release_date;
		string amount;
		string eviction;
		string satisifaction_type;
		string judg_satisfied_date;
		string judg_vacated_date;
		string tax_code;
		string irs_serial_number;
		string effective_date;
		string lapse_date;
		string accident_date;
		string sherrif_indc;
		string expiration_date;
		string agency;
		string agency_city;
		string agency_state;
		string agency_county;
		string legal_lot;
		string legal_block;
		string legal_borough;
		string certificate_number;
		string persistent_record_id;	//_key_main.tmsid.rmsid
		string bug_num;								//DI Field	bugzilla # when requested (if known)
		string cust_name;							//DI Field	name of customer who requested rec (if known)
	END;

	EXPORT Base_status	:= RECORD
		string tmsid;									//LN Internal unique case id
		string filing_status;					//LN Internal Case Event ID
		string filing_status_desc;
		string record_code;
		string filing_status;
		string filing_status_desc;
		string bug_num;								//DI Field	bugzilla # when requested (if known)
		string cust_name;							//DI Field	name of customer who requested rec (if known)
	END;


	EXPORT Base_party	:= RECORD
		string tmsid;									//LN Internal unique case id
		string rmsid;									//LN Internal Case Event ID
		
		string orig_full_debtorname;
		string orig_name;
		string orig_lname;
		string orig_fname;
		string orig_mname;
		string orig_suffix;
		string tax_id;
		string ssn;
		string title;
		string fname;
		string mname;
		string lname;
		string name_suffix;
		string name_score;
		string cname;
		string orig_address1;
		string orig_address2;
		string orig_city;
		string orig_state;
		string orig_zip5;
		string orig_zip4;
		string orig_county;
		string orig_country;
		string prim_range;
		string predir;
		string prim_name;
		string addr_suffix;
		string postdir;
		string unit_desig;
		string sec_range;
		string p_city_name;
		string v_city_name;
		string st;
		string zip;
		string zip4;
		string cart;
		string cr_sort_sz;
		string lot;
		string lot_order;
		string dbpc;
		string chk_digit;
		string rec_type;
		string county;
		string geo_lat;
		string geo_long;
		string msa;
		string geo_blk;
		string geo_match;
		string err_stat;
		string phone;
		string name_type;
		string did;
		string bdid;
		string date_first_seen;
		string date_last_seen;
		string date_vendor_first_reported;
		string date_vendor_last_reported;
		string app_ssn;
		string app_tax_id;
		
		
		
		string bug_num;								//DI Field	bugzilla # when requested (if known)
		string cust_name;							//DI Field	name of customer who requested rec (if known)
	END;


END;