export Layout_AccLogs_Base := module

export transaction := record
	string hash_key;
	unsigned6 transaction_id_count;
	string orig_dateadded;
end;

export main := record
  string orig_company_id;
  string orig_loginid;
  string orig_billing_code;
  string orig_user_companyname;
  string orig_user_firstname;
  string orig_user_lastname;
  string orig_user_status;
  string orig_login_history_id;
  string orig_fname;
  string orig_mname;
  string orig_lname;
  string orig_full_name;
  string orig_business_name;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zip;
  string orig_zip4;
  string orig_phone;
  string orig_ssn;
  string orig_dob;
  string orig_transaction_type;
  string orig_function_name;
  string orig_searchdescription;
  string orig_transaction_code;
  string orig_unique_id;
  string orig_ein;
  string orig_charter_nbr;
  string orig_ucc_nbr;
  string orig_filing_nbr;
  string orig_did;
  string orig_domain;
  string orig_dl;
  string user_id;
  string user_title;
  string user_fname;
  string user_mname;
  string user_lname;
  string user_name_suffix;
  string user_name_append;
  string user_cname;
  string title;
  string fname;
  string mname;
  string lname;
  string name_suffix;
  string cname;
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
  string ssn;
  string dob;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string8 dt_first_seen := '';
  string8 dt_last_seen := '';
  unsigned6 did;
  unsigned6 bdid;
  unsigned8 transaction_count := 1;
  string search_description;
  string hash_key;
end;

export full_layout := record, maxlength(250000)
		Main;
		dataset(transaction) transactions;
end;

export transaction_list_layout := record
		string60 hash_key;
		string orig_transaction_id;
		string orig_dateadded;
end;

end;