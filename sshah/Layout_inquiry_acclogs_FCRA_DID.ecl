//EXPORT Layout_inquiry_acclogs_FCRA_DID := 'todo';

export Layout_inquiry_acclogs_FCRA_DID:=
RECORD
  //string10 phone10;
	 unsigned6 appended_adl;
 // mbslayout mbs;
 string mbs_company_id;
   string mbs_global_company_id;
  //allowlayout allow_flags;
	unsigned8 allow_flags_allowflags;
  //businfolayout bus_intel;
	string bus_intel_primary_market_code;
   string bus_intel_secondary_market_code;
   string bus_intel_industry_1_code;
   string bus_intel_industry_2_code;
   string bus_intel_sub_market;
   string bus_intel_vertical;
   string bus_intel_use;
   string bus_intel_industry;
  //persondatalayout person_q;
	string   person_q_full_name;
string   person_q_first_name;
string   person_q_middle_name;
string   person_q_last_name;
string   person_q_address;
string   person_q_city;
string   person_q_state;
string   person_q_zip;
string   person_q_personal_phone;
string   person_q_work_phone;
string   person_q_dob;
string   person_q_dl;
string   person_q_dl_st;
string   person_q_email_address;
string   person_q_ssn;
string   person_q_linkid;
string   Person_q_ipaddr;
string5   person_q_title;
string20   person_q_fname;
string20   person_q_mname;
string20   person_q_lname;
string5   person_q_name_suffix;
string10   person_q_prim_range;
string2   person_q_predir;
string28   person_q_prim_name;
string4   person_q_addr_suffix;
string2   person_q_postdir;
string10   person_q_unit_desig;
string8   person_q_sec_range;
string25   person_q_v_city_name;
string2   person_q_st;
string5   person_q_zip5;
string4   person_q_zip4;
string2   person_q_addr_rec_type;
string2   person_q_fips_state;
string3   person_q_fips_county;
string10   person_q_geo_lat;
string11   person_q_geo_long;
string4   person_q_cbsa;
string7   person_q_geo_blk;
string1   person_q_geo_match;
string4   person_q_err_stat;
string   person_q_appended_ssn;
unsigned6   person_q_appended_adl;

  //busdatalayout bus_q;
	string   bus_q_cname;
string   bus_q_address;
string   bus_q_city;
string   bus_q_state;
string   bus_q_zip;
string   bus_q_company_phone;
string   bus_q_ein;
string   bus_q_charter_number;
string   bus_q_ucc_number;
string   bus_q_domain_name;
string10   bus_q_prim_range;
string2   bus_q_predir;
string28   bus_q_prim_name;
string4   bus_q_addr_suffix;
string2   bus_q_postdir;
string10   bus_q_unit_desig;
string8   bus_q_sec_range;
string25   bus_q_v_city_name;
string2   bus_q_st;
string5   bus_q_zip5;
string4   bus_q_zip4;
string2   bus_q_addr_rec_type;
string2   bus_q_fips_state;
string3   bus_q_fips_county;
string10   bus_q_geo_lat;
string11   bus_q_geo_long;
string4   bus_q_cbsa;
string7   bus_q_geo_blk;
string1   bus_q_geo_match;
string4   bus_q_err_stat;
unsigned6   bus_q_appended_bdid;
string   bus_q_appended_ein;

  //bususerdatalayout bususer_q;
string   bususer_q_first_name;
string   bususer_q_middle_name;
string   bususer_q_last_name;
string   bususer_q_address;
string   bususer_q_city;
string   bususer_q_state;
string   bususer_q_zip;
string   bususer_q_personal_phone;
string   bususer_q_dob;
string   bususer_q_dl;
string   bususer_q_dl_st;
string   bususer_q_ssn;
string5   bususer_q_title;
string20   bususer_q_fname;
string20   bususer_q_mname;
string20   bususer_q_lname;
string5   bususer_q_name_suffix;
string10   bususer_q_prim_range;
string2   bususer_q_predir;
string28   bususer_q_prim_name;
string4   bususer_q_addr_suffix;
string2   bususer_q_postdir;
string10   bususer_q_unit_desig;
string8   bususer_q_sec_range;
string25   bususer_q_v_city_name;
string2   bususer_q_st;
string5   bususer_q_zip5;
string4   bususer_q_zip4;
string2   bususer_q_addr_rec_type;
string2   bususer_q_fips_state;
string3   bususer_q_fips_county;
string10   bususer_q_geo_lat;
string11   bususer_q_geo_long;
string4   bususer_q_cbsa;
string7   bususer_q_geo_blk;
string1   bususer_q_geo_match;
string4   bususer_q_err_stat;
string   bususer_q_appended_ssn;
unsigned6 bususer_q_appended_adl;

  //permissablelayout permissions;
	string permissions_glb_purpose;
   string permissions_dppa_purpose;
   string permissions_fcra_purpose;
  //searchlayout search_info;
	string search_info_datetime;
   string search_info_start_monitor;
   string search_info_stop_monitor;
   string search_info_login_history_id;
   string search_info_transaction_id;
   string search_info_sequence_number;
   string search_info_method;
   string search_info_product_code;
   string search_info_transaction_type;
   string search_info_function_description;
   string search_info_ipaddr;
  //unsigned8 __internal_fpos__;
 END;