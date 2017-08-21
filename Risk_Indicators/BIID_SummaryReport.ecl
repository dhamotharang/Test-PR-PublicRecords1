IMPORT STD;

EXPORT BIID_SummaryReport := MODULE

		
	EXPORT BIIDRecord := RECORD
		// unsigned4 seq;
		string30 acctno;
		unsigned6 transaction_id;
		unsigned1 numbervalidauthrepsinput;
		unsigned6 historydate;
		string120 bus_company_name;
		string120 bus_alt_company_name;
		string120 bus_addr1;
		string120 bus_addr2;
		string25 bus_city_name;
		string2 bus_st;
		string9 bus_z5;
		string9 bus_fein;
		string10 bus_phone10;
		string10 bus_fax;
		string16 bus_ipaddr;
		string120 bus_url;
		string5 rep1_titlename;
		string120 rep1_fullname;
		string20 rep1_firstname;
		string20 rep1_middlename;
		string20 rep1_lastname;
		string120 rep1_addr1;
		string120 rep1_addr2;
		string25 rep1_city_name;
		string2 rep1_st;
		string9 rep1_z5;
		string9 rep1_ssn;
		string8 rep1_dob;
		string3 rep1_age;
		string10 rep1_phone10;
		string25 rep1_dlnumber;
		string2 rep1_dlstate;
		string100 rep1_email;
		string5 rep2_titlename;
		string120 rep2_fullname;
		string20 rep2_firstname;
		string20 rep2_middlename;
		string20 rep2_lastname;
		string120 rep2_addr1;
		string120 rep2_addr2;
		string25 rep2_city_name;
		string2 rep2_st;
		string9 rep2_z5;
		string9 rep2_ssn;
		string8 rep2_dob;
		string3 rep2_age;
		string10 rep2_phone10;
		string25 rep2_dlnumber;
		string2 rep2_dlstate;
		string100 rep2_email;
		string5 rep3_titlename;
		string120 rep3_fullname;
		string20 rep3_firstname;
		string20 rep3_middlename;
		string20 rep3_lastname;
		string120 rep3_addr1;
		string120 rep3_addr2;
		string25 rep3_city_name;
		string2 rep3_st;
		string9 rep3_z5;
		string9 rep3_ssn;
		string8 rep3_dob;
		string3 rep3_age;
		string10 rep3_phone10;
		string25 rep3_dlnumber;
		string2 rep3_dlstate;
		string100 rep3_email;
		string5 rep4_titlename;
		string120 rep4_fullname;
		string20 rep4_firstname;
		string20 rep4_middlename;
		string20 rep4_lastname;
		string120 rep4_addr1;
		string120 rep4_addr2;
		string25 rep4_city_name;
		string2 rep4_st;
		string9 rep4_z5;
		string9 rep4_ssn;
		string8 rep4_dob;
		string3 rep4_age;
		string10 rep4_phone10;
		string25 rep4_dlnumber;
		string2 rep4_dlstate;
		string100 rep4_email;
		string5 rep5_titlename;
		string120 rep5_fullname;
		string20 rep5_firstname;
		string20 rep5_middlename;
		string20 rep5_lastname;
		string120 rep5_addr1;
		string120 rep5_addr2;
		string25 rep5_city_name;
		string2 rep5_st;
		string9 rep5_z5;
		string9 rep5_ssn;
		string8 rep5_dob;
		string3 rep5_age;
		string10 rep5_phone10;
		string25 rep5_dlnumber;
		string2 rep5_dlstate;
		string100 rep5_email;
		string120 vercmpy;
		string50 veraddr;
		string30 vercity;
		string2 verstate;
		string5 verzip;
		string10 verphone;
		string9 verfein;
		string1 cnamematchflag;
		string1 addrmatchflag;
		string1 citymatchflag;
		string1 statematchflag;
		string1 zipmatchflag;
		string1 phonematchflag;
		string1 feinmatchflag;
		string120 bestcompanyname;
		string120 bestaddr;
		string25 bestcity;
		string2 beststate;
		string5 bestzip;
		string4 bestzip4;
		string10 bestphone;
		string9 bestfein;
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		string3 bvi;
		string150 bvi_desc;
		string4 bus_ri_1;
		string110 bus_ri_desc_1;
		string4 bus_ri_2;
		string110 bus_ri_desc_2;
		string4 bus_ri_3;
		string110 bus_ri_desc_3;
		string4 bus_ri_4;
		string110 bus_ri_desc_4;
		string4 bus_ri_5;
		string110 bus_ri_desc_5;
		string4 bus_ri_6;
		string110 bus_ri_desc_6;
		string4 bus_ri_7;
		string110 bus_ri_desc_7;
		string4 bus_ri_8;
		string110 bus_ri_desc_8;
		string2 bus2exec_index_rep1;
		string150 bus2exec_desc_rep1;
		string2 bus2exec_index_rep2;
		string150 bus2exec_desc_rep2;
		string2 bus2exec_index_rep3;
		string150 bus2exec_desc_rep3;
		string2 bus2exec_index_rep4;
		string150 bus2exec_desc_rep4;
		string2 bus2exec_index_rep5;
		string150 bus2exec_desc_rep5;
		string1 residential_bus_indicator;
		string30 residential_bus_desc;
		unsigned1 phone_verification;
		string60 phone_ver_desc;
		unsigned1 bureau_verification;
		string60 bureau_ver_desc;
		unsigned1 govt_reg_verification;
		string60 govt_reg_ver_desc;
		unsigned1 pubrec_filings_verification;
		string60 pubrec_filings_ver_desc;
		unsigned1 bus_directories_verification;
		string60 bus_directories_ver_desc;
		string120 bus_phone_match_company_1;
		string10 bus_phone_match_prim_range_1;
		string2 bus_phone_match_predir_1;
		string28 bus_phone_match_prim_name_1;
		string4 bus_phone_match_suffix_1;
		string2 bus_phone_match_postdir_1;
		string10 bus_phone_match_unit_desig_1;
		string8 bus_phone_match_sec_range_1;
		string50 bus_phone_match_addr_1;
		string30 bus_phone_match_city_1;
		string2 bus_phone_match_state_1;
		string5 bus_phone_match_zip_1;
		string4 bus_phone_match_zip4_1;
		unsigned6 bus_phone_match_seleid_1;
		string120 bus_phone_match_company_2;
		string10 bus_phone_match_prim_range_2;
		string2 bus_phone_match_predir_2;
		string28 bus_phone_match_prim_name_2;
		string4 bus_phone_match_suffix_2;
		string2 bus_phone_match_postdir_2;
		string10 bus_phone_match_unit_desig_2;
		string8 bus_phone_match_sec_range_2;
		string50 bus_phone_match_addr_2;
		string30 bus_phone_match_city_2;
		string2 bus_phone_match_state_2;
		string5 bus_phone_match_zip_2;
		string4 bus_phone_match_zip4_2;
		unsigned6 bus_phone_match_seleid_2;
		string120 bus_phone_match_company_3;
		string10 bus_phone_match_prim_range_3;
		string2 bus_phone_match_predir_3;
		string28 bus_phone_match_prim_name_3;
		string4 bus_phone_match_suffix_3;
		string2 bus_phone_match_postdir_3;
		string10 bus_phone_match_unit_desig_3;
		string8 bus_phone_match_sec_range_3;
		string50 bus_phone_match_addr_3;
		string30 bus_phone_match_city_3;
		string2 bus_phone_match_state_3;
		string5 bus_phone_match_zip_3;
		string4 bus_phone_match_zip4_3;
		unsigned6 bus_phone_match_seleid_3;
		string10 bus_addr_match_phone_1;
		string10 bus_addr_match_phone_2;
		string10 bus_addr_match_phone_3;
		string120 bus_fein_match_company_1;
		string10 bus_fein_match_prim_range_1;
		string2 bus_fein_match_predir_1;
		string28 bus_fein_match_prim_name_1;
		string4 bus_fein_match_suffix_1;
		string2 bus_fein_match_postdir_1;
		string10 bus_fein_match_unit_desig_1;
		string8 bus_fein_match_sec_range_1;
		string50 bus_fein_match_addr_1;
		string30 bus_fein_match_city_1;
		string2 bus_fein_match_state_1;
		string5 bus_fein_match_zip_1;
		string4 bus_fein_match_zip4_1;
		unsigned6 bus_fein_match_seleid_1;
		string120 bus_fein_match_company_2;
		string10 bus_fein_match_prim_range_2;
		string2 bus_fein_match_predir_2;
		string28 bus_fein_match_prim_name_2;
		string4 bus_fein_match_suffix_2;
		string2 bus_fein_match_postdir_2;
		string10 bus_fein_match_unit_desig_2;
		string8 bus_fein_match_sec_range_2;
		string50 bus_fein_match_addr_2;
		string30 bus_fein_match_city_2;
		string2 bus_fein_match_state_2;
		string5 bus_fein_match_zip_2;
		string4 bus_fein_match_zip4_2;
		unsigned6 bus_fein_match_seleid_2;
		string120 bus_fein_match_company_3;
		string10 bus_fein_match_prim_range_3;
		string2 bus_fein_match_predir_3;
		string28 bus_fein_match_prim_name_3;
		string4 bus_fein_match_suffix_3;
		string2 bus_fein_match_postdir_3;
		string10 bus_fein_match_unit_desig_3;
		string8 bus_fein_match_sec_range_3;
		string50 bus_fein_match_addr_3;
		string30 bus_fein_match_city_3;
		string2 bus_fein_match_state_3;
		string5 bus_fein_match_zip_3;
		string4 bus_fein_match_zip4_3;
		unsigned6 bus_fein_match_seleid_3;
		string60 bus_ofac_table_1;
		string120 bus_ofac_program_1;
		string10 bus_ofac_record_number_1;
		string120 bus_ofac_companyname_1;
		string20 bus_ofac_firstname_1;
		string20 bus_ofac_lastname_1;
		string50 bus_ofac_address_1;
		string30 bus_ofac_city_1;
		string2 bus_ofac_state_1;
		string9 bus_ofac_zip_1;
		string30 bus_ofac_country_1;
		string200 bus_ofac_entity_name_1;
		string4 bus_ofac_sequence_1;
		string60 bus_ofac_table_2;
		string120 bus_ofac_program_2;
		string10 bus_ofac_record_number_2;
		string120 bus_ofac_companyname_2;
		string20 bus_ofac_firstname_2;
		string20 bus_ofac_lastname_2;
		string50 bus_ofac_address_2;
		string30 bus_ofac_city_2;
		string2 bus_ofac_state_2;
		string9 bus_ofac_zip_2;
		string30 bus_ofac_country_2;
		string200 bus_ofac_entity_name_2;
		string4 bus_ofac_sequence_2;
		string60 bus_ofac_table_3;
		string120 bus_ofac_program_3;
		string10 bus_ofac_record_number_3;
		string120 bus_ofac_companyname_3;
		string20 bus_ofac_firstname_3;
		string20 bus_ofac_lastname_3;
		string50 bus_ofac_address_3;
		string30 bus_ofac_city_3;
		string2 bus_ofac_state_3;
		string9 bus_ofac_zip_3;
		string30 bus_ofac_country_3;
		string200 bus_ofac_entity_name_3;
		string4 bus_ofac_sequence_3;
		string60 bus_ofac_table_4;
		string120 bus_ofac_program_4;
		string10 bus_ofac_record_number_4;
		string120 bus_ofac_companyname_4;
		string20 bus_ofac_firstname_4;
		string20 bus_ofac_lastname_4;
		string50 bus_ofac_address_4;
		string30 bus_ofac_city_4;
		string2 bus_ofac_state_4;
		string9 bus_ofac_zip_4;
		string30 bus_ofac_country_4;
		string200 bus_ofac_entity_name_4;
		string4 bus_ofac_sequence_4;
		string60 bus_ofac_table_5;
		string120 bus_ofac_program_5;
		string10 bus_ofac_record_number_5;
		string120 bus_ofac_companyname_5;
		string20 bus_ofac_firstname_5;
		string20 bus_ofac_lastname_5;
		string50 bus_ofac_address_5;
		string30 bus_ofac_city_5;
		string2 bus_ofac_state_5;
		string9 bus_ofac_zip_5;
		string30 bus_ofac_country_5;
		string200 bus_ofac_entity_name_5;
		string4 bus_ofac_sequence_5;
		string60 bus_ofac_table_6;
		string120 bus_ofac_program_6;
		string10 bus_ofac_record_number_6;
		string120 bus_ofac_companyname_6;
		string20 bus_ofac_firstname_6;
		string20 bus_ofac_lastname_6;
		string50 bus_ofac_address_6;
		string30 bus_ofac_city_6;
		string2 bus_ofac_state_6;
		string9 bus_ofac_zip_6;
		string30 bus_ofac_country_6;
		string200 bus_ofac_entity_name_6;
		string4 bus_ofac_sequence_6;
		string60 bus_ofac_table_7;
		string120 bus_ofac_program_7;
		string10 bus_ofac_record_number_7;
		string120 bus_ofac_companyname_7;
		string20 bus_ofac_firstname_7;
		string20 bus_ofac_lastname_7;
		string50 bus_ofac_address_7;
		string30 bus_ofac_city_7;
		string2 bus_ofac_state_7;
		string9 bus_ofac_zip_7;
		string30 bus_ofac_country_7;
		string200 bus_ofac_entity_name_7;
		string4 bus_ofac_sequence_7;
		string60 bus_watchlist_table_1;
		string120 bus_watchlist_program_1;
		string10 bus_watchlist_record_number_1;
		string120 bus_watchlist_companyname_1;
		string20 bus_watchlist_firstname_1;
		string20 bus_watchlist_lastname_1;
		string50 bus_watchlist_address_1;
		string30 bus_watchlist_city_1;
		string2 bus_watchlist_state_1;
		string9 bus_watchlist_zip_1;
		string30 bus_watchlist_country_1;
		string200 bus_watchlist_entity_name_1;
		string4 bus_watchlist_sequence_1;
		string60 bus_watchlist_table_2;
		string120 bus_watchlist_program_2;
		string10 bus_watchlist_record_number_2;
		string120 bus_watchlist_companyname_2;
		string20 bus_watchlist_firstname_2;
		string20 bus_watchlist_lastname_2;
		string50 bus_watchlist_address_2;
		string30 bus_watchlist_city_2;
		string2 bus_watchlist_state_2;
		string9 bus_watchlist_zip_2;
		string30 bus_watchlist_country_2;
		string200 bus_watchlist_entity_name_2;
		string4 bus_watchlist_sequence_2;
		string60 bus_watchlist_table_3;
		string120 bus_watchlist_program_3;
		string10 bus_watchlist_record_number_3;
		string120 bus_watchlist_companyname_3;
		string20 bus_watchlist_firstname_3;
		string20 bus_watchlist_lastname_3;
		string50 bus_watchlist_address_3;
		string30 bus_watchlist_city_3;
		string2 bus_watchlist_state_3;
		string9 bus_watchlist_zip_3;
		string30 bus_watchlist_country_3;
		string200 bus_watchlist_entity_name_3;
		string4 bus_watchlist_sequence_3;
		string60 bus_watchlist_table_4;
		string120 bus_watchlist_program_4;
		string10 bus_watchlist_record_number_4;
		string120 bus_watchlist_companyname_4;
		string20 bus_watchlist_firstname_4;
		string20 bus_watchlist_lastname_4;
		string50 bus_watchlist_address_4;
		string30 bus_watchlist_city_4;
		string2 bus_watchlist_state_4;
		string9 bus_watchlist_zip_4;
		string30 bus_watchlist_country_4;
		string200 bus_watchlist_entity_name_4;
		string4 bus_watchlist_sequence_4;
		string60 bus_watchlist_table_5;
		string120 bus_watchlist_program_5;
		string10 bus_watchlist_record_number_5;
		string120 bus_watchlist_companyname_5;
		string20 bus_watchlist_firstname_5;
		string20 bus_watchlist_lastname_5;
		string50 bus_watchlist_address_5;
		string30 bus_watchlist_city_5;
		string2 bus_watchlist_state_5;
		string9 bus_watchlist_zip_5;
		string30 bus_watchlist_country_5;
		string200 bus_watchlist_entity_name_5;
		string4 bus_watchlist_sequence_5;
		string60 bus_watchlist_table_6;
		string120 bus_watchlist_program_6;
		string10 bus_watchlist_record_number_6;
		string120 bus_watchlist_companyname_6;
		string20 bus_watchlist_firstname_6;
		string20 bus_watchlist_lastname_6;
		string50 bus_watchlist_address_6;
		string30 bus_watchlist_city_6;
		string2 bus_watchlist_state_6;
		string9 bus_watchlist_zip_6;
		string30 bus_watchlist_country_6;
		string200 bus_watchlist_entity_name_6;
		string4 bus_watchlist_sequence_6;
		string60 bus_watchlist_table_7;
		string120 bus_watchlist_program_7;
		string10 bus_watchlist_record_number_7;
		string120 bus_watchlist_companyname_7;
		string20 bus_watchlist_firstname_7;
		string20 bus_watchlist_lastname_7;
		string50 bus_watchlist_address_7;
		string30 bus_watchlist_city_7;
		string2 bus_watchlist_state_7;
		string9 bus_watchlist_zip_7;
		string30 bus_watchlist_country_7;
		string200 bus_watchlist_entity_name_7;
		string4 bus_watchlist_sequence_7;
		string50 ln_status;
		string10 sos_status;
		string120 sos_filing_name;
		string5 time_on_sos;
		string8 sic;
		string120 sic_desc;
		string6 naics;
		string120 naics_desc;
		string4 bus_firstseen_yyyy;
		string5 time_on_publicrecord;
		string120 bus_description;
		string25 bus_county;
		string100 rep1_title;
		string100 rep2_title;
		string100 rep3_title;
		string100 rep4_title;
		string100 rep5_title;
		unsigned6 parent_seleid;
		string120 parent_best_bus_name;
		string3 time_on_sbfe;
		string3 last_seen_sbfe;
		string3 count_of_trades_sbfe;
		string20 rep1_verfirst;
		string20 rep1_verlast;
		string50 rep1_veraddr;
		string30 rep1_vercity;
		string2 rep1_verstate;
		string5 rep1_verzip;
		string4 rep1_verzip4;
		string20 rep1_vercounty;
		string9 rep1_verssn;
		string8 rep1_verdob;
		string10 rep1_verhphone;
		string25 rep1_verdl;
		string1 rep1_verify_addr;
		string1 rep1_verify_dob;
		string1 rep1_valid_ssn;
		string3 rep1_nas_summary;
		string3 rep1_nap_summary;
		string1 rep1_nap_type;
		string1 rep1_nap_status;
		string3 rep1_cvi;
		string8 rep1_deceaseddate;
		string8 rep1_deceaseddob;
		string20 rep1_deceasedfirst;
		string20 rep1_deceasedlast;
		string1 rep1_dobmatchlevel;
		string4 rep1_hri_1;
		string100 rep1_hri_desc_1;
		string4 rep1_hri_2;
		string100 rep1_hri_desc_2;
		string4 rep1_hri_3;
		string100 rep1_hri_desc_3;
		string4 rep1_hri_4;
		string100 rep1_hri_desc_4;
		string4 rep1_hri_5;
		string100 rep1_hri_desc_5;
		string4 rep1_hri_6;
		string100 rep1_hri_desc_6;
		string4 rep1_hri_7;
		string100 rep1_hri_desc_7;
		string4 rep1_hri_8;
		string100 rep1_hri_desc_8;
		string4 rep1_hri_9;
		string100 rep1_hri_desc_9;
		string4 rep1_hri_10;
		string100 rep1_hri_desc_10;
		string4 rep1_fua_1;
		string150 rep1_fua_desc_1;
		string4 rep1_fua_2;
		string150 rep1_fua_desc_2;
		string4 rep1_fua_3;
		string150 rep1_fua_desc_3;
		string4 rep1_fua_4;
		string150 rep1_fua_desc_4;
		string20 rep1_corrected_lname;
		string8 rep1_corrected_dob;
		string10 rep1_corrected_phone;
		string9 rep1_corrected_ssn;
		string65 rep1_corrected_address;
		string3 rep1_area_code_split;
		string8 rep1_area_code_split_date;
		string20 rep1_phone_fname;
		string20 rep1_phone_lname;
		string65 rep1_phone_address;
		string25 rep1_phone_city;
		string2 rep1_phone_st;
		string5 rep1_phone_zip;
		string10 rep1_name_addr_phone;
		string6 rep1_ssa_date_first;
		string6 rep1_ssa_date_last;
		string2 rep1_ssa_state;
		string20 rep1_ssa_state_name;
		string20 rep1_current_fname;
		string20 rep1_current_lname;
		string65 rep1_chron_address_1;
		string25 rep1_chron_city_1;
		string2 rep1_chron_st_1;
		string5 rep1_chron_zip_1;
		string4 rep1_chron_zip4_1;
		string50 rep1_chron_phone_1;
		string6 rep1_chron_dt_first_seen_1;
		string6 rep1_chron_dt_last_seen_1;
		string65 rep1_chron_address_2;
		string25 rep1_chron_city_2;
		string2 rep1_chron_st_2;
		string5 rep1_chron_zip_2;
		string4 rep1_chron_zip4_2;
		string50 rep1_chron_phone_2;
		string6 rep1_chron_dt_first_seen_2;
		string6 rep1_chron_dt_last_seen_2;
		string65 rep1_chron_address_3;
		string25 rep1_chron_city_3;
		string2 rep1_chron_st_3;
		string5 rep1_chron_zip_3;
		string4 rep1_chron_zip4_3;
		string50 rep1_chron_phone_3;
		string6 rep1_chron_dt_first_seen_3;
		string6 rep1_chron_dt_last_seen_3;
		string20 rep1_addl_fname_1;
		string20 rep1_addl_lname_1;
		string8 rep1_addl_lname_date_last_1;
		string20 rep1_addl_fname_2;
		string20 rep1_addl_lname_2;
		string8 rep1_addl_lname_date_last_2;
		string20 rep1_addl_fname_3;
		string20 rep1_addl_lname_3;
		string8 rep1_addl_lname_date_last_3;
		boolean rep1_addresspobox;
		boolean rep1_addresscmra;
		string60 rep1_watchlist_table;
		string120 rep1_watchlist_program;
		string10 rep1_watchlist_record_number;
		string20 rep1_watchlist_fname;
		string20 rep1_watchlist_lname;
		string65 rep1_watchlist_address;
		string25 rep1_watchlist_city;
		string2 rep1_watchlist_state;
		string5 rep1_watchlist_zip;
		string30 rep1_watchlist_country;
		string200 rep1_watchlist_entity_name;
		string60 rep1_watchlist_table_2;
		string120 rep1_watchlist_program_2;
		string10 rep1_watchlist_record_number_2;
		string20 rep1_watchlist_fname_2;
		string20 rep1_watchlist_lname_2;
		string65 rep1_watchlist_address_2;
		string25 rep1_watchlist_city_2;
		string2 rep1_watchlist_state_2;
		string5 rep1_watchlist_zip_2;
		string30 rep1_watchlist_country_2;
		string200 rep1_watchlist_entity_name_2;
		string60 rep1_watchlist_table_3;
		string120 rep1_watchlist_program_3;
		string10 rep1_watchlist_record_number_3;
		string20 rep1_watchlist_fname_3;
		string20 rep1_watchlist_lname_3;
		string65 rep1_watchlist_address_3;
		string25 rep1_watchlist_city_3;
		string2 rep1_watchlist_state_3;
		string5 rep1_watchlist_zip_3;
		string30 rep1_watchlist_country_3;
		string200 rep1_watchlist_entity_name_3;
		string60 rep1_watchlist_table_4;
		string120 rep1_watchlist_program_4;
		string10 rep1_watchlist_record_number_4;
		string20 rep1_watchlist_fname_4;
		string20 rep1_watchlist_lname_4;
		string65 rep1_watchlist_address_4;
		string25 rep1_watchlist_city_4;
		string2 rep1_watchlist_state_4;
		string5 rep1_watchlist_zip_4;
		string30 rep1_watchlist_country_4;
		string200 rep1_watchlist_entity_name_4;
		string60 rep1_watchlist_table_5;
		string120 rep1_watchlist_program_5;
		string10 rep1_watchlist_record_number_5;
		string20 rep1_watchlist_fname_5;
		string20 rep1_watchlist_lname_5;
		string65 rep1_watchlist_address_5;
		string25 rep1_watchlist_city_5;
		string2 rep1_watchlist_state_5;
		string5 rep1_watchlist_zip_5;
		string30 rep1_watchlist_country_5;
		string200 rep1_watchlist_entity_name_5;
		string60 rep1_watchlist_table_6;
		string120 rep1_watchlist_program_6;
		string10 rep1_watchlist_record_number_6;
		string20 rep1_watchlist_fname_6;
		string20 rep1_watchlist_lname_6;
		string65 rep1_watchlist_address_6;
		string25 rep1_watchlist_city_6;
		string2 rep1_watchlist_state_6;
		string5 rep1_watchlist_zip_6;
		string30 rep1_watchlist_country_6;
		string200 rep1_watchlist_entity_name_6;
		string60 rep1_watchlist_table_7;
		string120 rep1_watchlist_program_7;
		string10 rep1_watchlist_record_number_7;
		string20 rep1_watchlist_fname_7;
		string20 rep1_watchlist_lname_7;
		string65 rep1_watchlist_address_7;
		string25 rep1_watchlist_city_7;
		string2 rep1_watchlist_state_7;
		string5 rep1_watchlist_zip_7;
		string30 rep1_watchlist_country_7;
		string200 rep1_watchlist_entity_name_7;
		string20 rep2_verfirst;
		string20 rep2_verlast;
		string50 rep2_veraddr;
		string30 rep2_vercity;
		string2 rep2_verstate;
		string5 rep2_verzip;
		string4 rep2_verzip4;
		string20 rep2_vercounty;
		string9 rep2_verssn;
		string8 rep2_verdob;
		string10 rep2_verhphone;
		string25 rep2_verdl;
		string1 rep2_verify_addr;
		string1 rep2_verify_dob;
		string1 rep2_valid_ssn;
		string3 rep2_nas_summary;
		string3 rep2_nap_summary;
		string1 rep2_nap_type;
		string1 rep2_nap_status;
		string3 rep2_cvi;
		string8 rep2_deceaseddate;
		string8 rep2_deceaseddob;
		string20 rep2_deceasedfirst;
		string20 rep2_deceasedlast;
		string1 rep2_dobmatchlevel;
		string4 rep2_hri_1;
		string100 rep2_hri_desc_1;
		string4 rep2_hri_2;
		string100 rep2_hri_desc_2;
		string4 rep2_hri_3;
		string100 rep2_hri_desc_3;
		string4 rep2_hri_4;
		string100 rep2_hri_desc_4;
		string4 rep2_hri_5;
		string100 rep2_hri_desc_5;
		string4 rep2_hri_6;
		string100 rep2_hri_desc_6;
		string4 rep2_hri_7;
		string100 rep2_hri_desc_7;
		string4 rep2_hri_8;
		string100 rep2_hri_desc_8;
		string4 rep2_hri_9;
		string100 rep2_hri_desc_9;
		string4 rep2_hri_10;
		string100 rep2_hri_desc_10;
		string4 rep2_fua_1;
		string150 rep2_fua_desc_1;
		string4 rep2_fua_2;
		string150 rep2_fua_desc_2;
		string4 rep2_fua_3;
		string150 rep2_fua_desc_3;
		string4 rep2_fua_4;
		string150 rep2_fua_desc_4;
		string20 rep2_corrected_lname;
		string8 rep2_corrected_dob;
		string10 rep2_corrected_phone;
		string9 rep2_corrected_ssn;
		string65 rep2_corrected_address;
		string3 rep2_area_code_split;
		string8 rep2_area_code_split_date;
		string20 rep2_phone_fname;
		string20 rep2_phone_lname;
		string65 rep2_phone_address;
		string25 rep2_phone_city;
		string2 rep2_phone_st;
		string5 rep2_phone_zip;
		string10 rep2_name_addr_phone;
		string6 rep2_ssa_date_first;
		string6 rep2_ssa_date_last;
		string2 rep2_ssa_state;
		string20 rep2_ssa_state_name;
		string20 rep2_current_fname;
		string20 rep2_current_lname;
		string65 rep2_chron_address_1;
		string25 rep2_chron_city_1;
		string2 rep2_chron_st_1;
		string5 rep2_chron_zip_1;
		string4 rep2_chron_zip4_1;
		string50 rep2_chron_phone_1;
		string6 rep2_chron_dt_first_seen_1;
		string6 rep2_chron_dt_last_seen_1;
		string65 rep2_chron_address_2;
		string25 rep2_chron_city_2;
		string2 rep2_chron_st_2;
		string5 rep2_chron_zip_2;
		string4 rep2_chron_zip4_2;
		string50 rep2_chron_phone_2;
		string6 rep2_chron_dt_first_seen_2;
		string6 rep2_chron_dt_last_seen_2;
		string65 rep2_chron_address_3;
		string25 rep2_chron_city_3;
		string2 rep2_chron_st_3;
		string5 rep2_chron_zip_3;
		string4 rep2_chron_zip4_3;
		string50 rep2_chron_phone_3;
		string6 rep2_chron_dt_first_seen_3;
		string6 rep2_chron_dt_last_seen_3;
		string20 rep2_addl_fname_1;
		string20 rep2_addl_lname_1;
		string8 rep2_addl_lname_date_last_1;
		string20 rep2_addl_fname_2;
		string20 rep2_addl_lname_2;
		string8 rep2_addl_lname_date_last_2;
		string20 rep2_addl_fname_3;
		string20 rep2_addl_lname_3;
		string8 rep2_addl_lname_date_last_3;
		boolean rep2_addresspobox;
		boolean rep2_addresscmra;
		string60 rep2_watchlist_table;
		string120 rep2_watchlist_program;
		string10 rep2_watchlist_record_number;
		string20 rep2_watchlist_fname;
		string20 rep2_watchlist_lname;
		string65 rep2_watchlist_address;
		string25 rep2_watchlist_city;
		string2 rep2_watchlist_state;
		string5 rep2_watchlist_zip;
		string30 rep2_watchlist_country;
		string200 rep2_watchlist_entity_name;
		string60 rep2_watchlist_table_2;
		string120 rep2_watchlist_program_2;
		string10 rep2_watchlist_record_number_2;
		string20 rep2_watchlist_fname_2;
		string20 rep2_watchlist_lname_2;
		string65 rep2_watchlist_address_2;
		string25 rep2_watchlist_city_2;
		string2 rep2_watchlist_state_2;
		string5 rep2_watchlist_zip_2;
		string30 rep2_watchlist_country_2;
		string200 rep2_watchlist_entity_name_2;
		string60 rep2_watchlist_table_3;
		string120 rep2_watchlist_program_3;
		string10 rep2_watchlist_record_number_3;
		string20 rep2_watchlist_fname_3;
		string20 rep2_watchlist_lname_3;
		string65 rep2_watchlist_address_3;
		string25 rep2_watchlist_city_3;
		string2 rep2_watchlist_state_3;
		string5 rep2_watchlist_zip_3;
		string30 rep2_watchlist_country_3;
		string200 rep2_watchlist_entity_name_3;
		string60 rep2_watchlist_table_4;
		string120 rep2_watchlist_program_4;
		string10 rep2_watchlist_record_number_4;
		string20 rep2_watchlist_fname_4;
		string20 rep2_watchlist_lname_4;
		string65 rep2_watchlist_address_4;
		string25 rep2_watchlist_city_4;
		string2 rep2_watchlist_state_4;
		string5 rep2_watchlist_zip_4;
		string30 rep2_watchlist_country_4;
		string200 rep2_watchlist_entity_name_4;
		string60 rep2_watchlist_table_5;
		string120 rep2_watchlist_program_5;
		string10 rep2_watchlist_record_number_5;
		string20 rep2_watchlist_fname_5;
		string20 rep2_watchlist_lname_5;
		string65 rep2_watchlist_address_5;
		string25 rep2_watchlist_city_5;
		string2 rep2_watchlist_state_5;
		string5 rep2_watchlist_zip_5;
		string30 rep2_watchlist_country_5;
		string200 rep2_watchlist_entity_name_5;
		string60 rep2_watchlist_table_6;
		string120 rep2_watchlist_program_6;
		string10 rep2_watchlist_record_number_6;
		string20 rep2_watchlist_fname_6;
		string20 rep2_watchlist_lname_6;
		string65 rep2_watchlist_address_6;
		string25 rep2_watchlist_city_6;
		string2 rep2_watchlist_state_6;
		string5 rep2_watchlist_zip_6;
		string30 rep2_watchlist_country_6;
		string200 rep2_watchlist_entity_name_6;
		string60 rep2_watchlist_table_7;
		string120 rep2_watchlist_program_7;
		string10 rep2_watchlist_record_number_7;
		string20 rep2_watchlist_fname_7;
		string20 rep2_watchlist_lname_7;
		string65 rep2_watchlist_address_7;
		string25 rep2_watchlist_city_7;
		string2 rep2_watchlist_state_7;
		string5 rep2_watchlist_zip_7;
		string30 rep2_watchlist_country_7;
		string200 rep2_watchlist_entity_name_7;
		string20 rep3_verfirst;
		string20 rep3_verlast;
		string50 rep3_veraddr;
		string30 rep3_vercity;
		string2 rep3_verstate;
		string5 rep3_verzip;
		string4 rep3_verzip4;
		string20 rep3_vercounty;
		string9 rep3_verssn;
		string8 rep3_verdob;
		string10 rep3_verhphone;
		string25 rep3_verdl;
		string1 rep3_verify_addr;
		string1 rep3_verify_dob;
		string1 rep3_valid_ssn;
		string3 rep3_nas_summary;
		string3 rep3_nap_summary;
		string1 rep3_nap_type;
		string1 rep3_nap_status;
		string3 rep3_cvi;
		string8 rep3_deceaseddate;
		string8 rep3_deceaseddob;
		string20 rep3_deceasedfirst;
		string20 rep3_deceasedlast;
		string1 rep3_dobmatchlevel;
		string4 rep3_hri_1;
		string100 rep3_hri_desc_1;
		string4 rep3_hri_2;
		string100 rep3_hri_desc_2;
		string4 rep3_hri_3;
		string100 rep3_hri_desc_3;
		string4 rep3_hri_4;
		string100 rep3_hri_desc_4;
		string4 rep3_hri_5;
		string100 rep3_hri_desc_5;
		string4 rep3_hri_6;
		string100 rep3_hri_desc_6;
		string4 rep3_hri_7;
		string100 rep3_hri_desc_7;
		string4 rep3_hri_8;
		string100 rep3_hri_desc_8;
		string4 rep3_hri_9;
		string100 rep3_hri_desc_9;
		string4 rep3_hri_10;
		string100 rep3_hri_desc_10;
		string4 rep3_fua_1;
		string150 rep3_fua_desc_1;
		string4 rep3_fua_2;
		string150 rep3_fua_desc_2;
		string4 rep3_fua_3;
		string150 rep3_fua_desc_3;
		string4 rep3_fua_4;
		string150 rep3_fua_desc_4;
		string20 rep3_corrected_lname;
		string8 rep3_corrected_dob;
		string10 rep3_corrected_phone;
		string9 rep3_corrected_ssn;
		string65 rep3_corrected_address;
		string3 rep3_area_code_split;
		string8 rep3_area_code_split_date;
		string20 rep3_phone_fname;
		string20 rep3_phone_lname;
		string65 rep3_phone_address;
		string25 rep3_phone_city;
		string2 rep3_phone_st;
		string5 rep3_phone_zip;
		string10 rep3_name_addr_phone;
		string6 rep3_ssa_date_first;
		string6 rep3_ssa_date_last;
		string2 rep3_ssa_state;
		string20 rep3_ssa_state_name;
		string20 rep3_current_fname;
		string20 rep3_current_lname;
		string65 rep3_chron_address_1;
		string25 rep3_chron_city_1;
		string2 rep3_chron_st_1;
		string5 rep3_chron_zip_1;
		string4 rep3_chron_zip4_1;
		string50 rep3_chron_phone_1;
		string6 rep3_chron_dt_first_seen_1;
		string6 rep3_chron_dt_last_seen_1;
		string65 rep3_chron_address_2;
		string25 rep3_chron_city_2;
		string2 rep3_chron_st_2;
		string5 rep3_chron_zip_2;
		string4 rep3_chron_zip4_2;
		string50 rep3_chron_phone_2;
		string6 rep3_chron_dt_first_seen_2;
		string6 rep3_chron_dt_last_seen_2;
		string65 rep3_chron_address_3;
		string25 rep3_chron_city_3;
		string2 rep3_chron_st_3;
		string5 rep3_chron_zip_3;
		string4 rep3_chron_zip4_3;
		string50 rep3_chron_phone_3;
		string6 rep3_chron_dt_first_seen_3;
		string6 rep3_chron_dt_last_seen_3;
		string20 rep3_addl_fname_1;
		string20 rep3_addl_lname_1;
		string8 rep3_addl_lname_date_last_1;
		string20 rep3_addl_fname_2;
		string20 rep3_addl_lname_2;
		string8 rep3_addl_lname_date_last_2;
		string20 rep3_addl_fname_3;
		string20 rep3_addl_lname_3;
		string8 rep3_addl_lname_date_last_3;
		boolean rep3_addresspobox;
		boolean rep3_addresscmra;
		string60 rep3_watchlist_table;
		string120 rep3_watchlist_program;
		string10 rep3_watchlist_record_number;
		string20 rep3_watchlist_fname;
		string20 rep3_watchlist_lname;
		string65 rep3_watchlist_address;
		string25 rep3_watchlist_city;
		string2 rep3_watchlist_state;
		string5 rep3_watchlist_zip;
		string30 rep3_watchlist_country;
		string200 rep3_watchlist_entity_name;
		string60 rep3_watchlist_table_2;
		string120 rep3_watchlist_program_2;
		string10 rep3_watchlist_record_number_2;
		string20 rep3_watchlist_fname_2;
		string20 rep3_watchlist_lname_2;
		string65 rep3_watchlist_address_2;
		string25 rep3_watchlist_city_2;
		string2 rep3_watchlist_state_2;
		string5 rep3_watchlist_zip_2;
		string30 rep3_watchlist_country_2;
		string200 rep3_watchlist_entity_name_2;
		string60 rep3_watchlist_table_3;
		string120 rep3_watchlist_program_3;
		string10 rep3_watchlist_record_number_3;
		string20 rep3_watchlist_fname_3;
		string20 rep3_watchlist_lname_3;
		string65 rep3_watchlist_address_3;
		string25 rep3_watchlist_city_3;
		string2 rep3_watchlist_state_3;
		string5 rep3_watchlist_zip_3;
		string30 rep3_watchlist_country_3;
		string200 rep3_watchlist_entity_name_3;
		string60 rep3_watchlist_table_4;
		string120 rep3_watchlist_program_4;
		string10 rep3_watchlist_record_number_4;
		string20 rep3_watchlist_fname_4;
		string20 rep3_watchlist_lname_4;
		string65 rep3_watchlist_address_4;
		string25 rep3_watchlist_city_4;
		string2 rep3_watchlist_state_4;
		string5 rep3_watchlist_zip_4;
		string30 rep3_watchlist_country_4;
		string200 rep3_watchlist_entity_name_4;
		string60 rep3_watchlist_table_5;
		string120 rep3_watchlist_program_5;
		string10 rep3_watchlist_record_number_5;
		string20 rep3_watchlist_fname_5;
		string20 rep3_watchlist_lname_5;
		string65 rep3_watchlist_address_5;
		string25 rep3_watchlist_city_5;
		string2 rep3_watchlist_state_5;
		string5 rep3_watchlist_zip_5;
		string30 rep3_watchlist_country_5;
		string200 rep3_watchlist_entity_name_5;
		string60 rep3_watchlist_table_6;
		string120 rep3_watchlist_program_6;
		string10 rep3_watchlist_record_number_6;
		string20 rep3_watchlist_fname_6;
		string20 rep3_watchlist_lname_6;
		string65 rep3_watchlist_address_6;
		string25 rep3_watchlist_city_6;
		string2 rep3_watchlist_state_6;
		string5 rep3_watchlist_zip_6;
		string30 rep3_watchlist_country_6;
		string200 rep3_watchlist_entity_name_6;
		string60 rep3_watchlist_table_7;
		string120 rep3_watchlist_program_7;
		string10 rep3_watchlist_record_number_7;
		string20 rep3_watchlist_fname_7;
		string20 rep3_watchlist_lname_7;
		string65 rep3_watchlist_address_7;
		string25 rep3_watchlist_city_7;
		string2 rep3_watchlist_state_7;
		string5 rep3_watchlist_zip_7;
		string30 rep3_watchlist_country_7;
		string200 rep3_watchlist_entity_name_7;
		string20 rep4_verfirst;
		string20 rep4_verlast;
		string50 rep4_veraddr;
		string30 rep4_vercity;
		string2 rep4_verstate;
		string5 rep4_verzip;
		string4 rep4_verzip4;
		string20 rep4_vercounty;
		string9 rep4_verssn;
		string8 rep4_verdob;
		string10 rep4_verhphone;
		string25 rep4_verdl;
		string1 rep4_verify_addr;
		string1 rep4_verify_dob;
		string1 rep4_valid_ssn;
		string3 rep4_nas_summary;
		string3 rep4_nap_summary;
		string1 rep4_nap_type;
		string1 rep4_nap_status;
		string3 rep4_cvi;
		string8 rep4_deceaseddate;
		string8 rep4_deceaseddob;
		string20 rep4_deceasedfirst;
		string20 rep4_deceasedlast;
		string1 rep4_dobmatchlevel;
		string4 rep4_hri_1;
		string100 rep4_hri_desc_1;
		string4 rep4_hri_2;
		string100 rep4_hri_desc_2;
		string4 rep4_hri_3;
		string100 rep4_hri_desc_3;
		string4 rep4_hri_4;
		string100 rep4_hri_desc_4;
		string4 rep4_hri_5;
		string100 rep4_hri_desc_5;
		string4 rep4_hri_6;
		string100 rep4_hri_desc_6;
		string4 rep4_hri_7;
		string100 rep4_hri_desc_7;
		string4 rep4_hri_8;
		string100 rep4_hri_desc_8;
		string4 rep4_hri_9;
		string100 rep4_hri_desc_9;
		string4 rep4_hri_10;
		string100 rep4_hri_desc_10;
		string4 rep4_fua_1;
		string150 rep4_fua_desc_1;
		string4 rep4_fua_2;
		string150 rep4_fua_desc_2;
		string4 rep4_fua_3;
		string150 rep4_fua_desc_3;
		string4 rep4_fua_4;
		string150 rep4_fua_desc_4;
		string20 rep4_corrected_lname;
		string8 rep4_corrected_dob;
		string10 rep4_corrected_phone;
		string9 rep4_corrected_ssn;
		string65 rep4_corrected_address;
		string3 rep4_area_code_split;
		string8 rep4_area_code_split_date;
		string20 rep4_phone_fname;
		string20 rep4_phone_lname;
		string65 rep4_phone_address;
		string25 rep4_phone_city;
		string2 rep4_phone_st;
		string5 rep4_phone_zip;
		string10 rep4_name_addr_phone;
		string6 rep4_ssa_date_first;
		string6 rep4_ssa_date_last;
		string2 rep4_ssa_state;
		string20 rep4_ssa_state_name;
		string20 rep4_current_fname;
		string20 rep4_current_lname;
		string65 rep4_chron_address_1;
		string25 rep4_chron_city_1;
		string2 rep4_chron_st_1;
		string5 rep4_chron_zip_1;
		string4 rep4_chron_zip4_1;
		string50 rep4_chron_phone_1;
		string6 rep4_chron_dt_first_seen_1;
		string6 rep4_chron_dt_last_seen_1;
		string65 rep4_chron_address_2;
		string25 rep4_chron_city_2;
		string2 rep4_chron_st_2;
		string5 rep4_chron_zip_2;
		string4 rep4_chron_zip4_2;
		string50 rep4_chron_phone_2;
		string6 rep4_chron_dt_first_seen_2;
		string6 rep4_chron_dt_last_seen_2;
		string65 rep4_chron_address_3;
		string25 rep4_chron_city_3;
		string2 rep4_chron_st_3;
		string5 rep4_chron_zip_3;
		string4 rep4_chron_zip4_3;
		string50 rep4_chron_phone_3;
		string6 rep4_chron_dt_first_seen_3;
		string6 rep4_chron_dt_last_seen_3;
		string20 rep4_addl_fname_1;
		string20 rep4_addl_lname_1;
		string8 rep4_addl_lname_date_last_1;
		string20 rep4_addl_fname_2;
		string20 rep4_addl_lname_2;
		string8 rep4_addl_lname_date_last_2;
		string20 rep4_addl_fname_3;
		string20 rep4_addl_lname_3;
		string8 rep4_addl_lname_date_last_3;
		boolean rep4_addresspobox;
		boolean rep4_addresscmra;
		string60 rep4_watchlist_table;
		string120 rep4_watchlist_program;
		string10 rep4_watchlist_record_number;
		string20 rep4_watchlist_fname;
		string20 rep4_watchlist_lname;
		string65 rep4_watchlist_address;
		string25 rep4_watchlist_city;
		string2 rep4_watchlist_state;
		string5 rep4_watchlist_zip;
		string30 rep4_watchlist_country;
		string200 rep4_watchlist_entity_name;
		string60 rep4_watchlist_table_2;
		string120 rep4_watchlist_program_2;
		string10 rep4_watchlist_record_number_2;
		string20 rep4_watchlist_fname_2;
		string20 rep4_watchlist_lname_2;
		string65 rep4_watchlist_address_2;
		string25 rep4_watchlist_city_2;
		string2 rep4_watchlist_state_2;
		string5 rep4_watchlist_zip_2;
		string30 rep4_watchlist_country_2;
		string200 rep4_watchlist_entity_name_2;
		string60 rep4_watchlist_table_3;
		string120 rep4_watchlist_program_3;
		string10 rep4_watchlist_record_number_3;
		string20 rep4_watchlist_fname_3;
		string20 rep4_watchlist_lname_3;
		string65 rep4_watchlist_address_3;
		string25 rep4_watchlist_city_3;
		string2 rep4_watchlist_state_3;
		string5 rep4_watchlist_zip_3;
		string30 rep4_watchlist_country_3;
		string200 rep4_watchlist_entity_name_3;
		string60 rep4_watchlist_table_4;
		string120 rep4_watchlist_program_4;
		string10 rep4_watchlist_record_number_4;
		string20 rep4_watchlist_fname_4;
		string20 rep4_watchlist_lname_4;
		string65 rep4_watchlist_address_4;
		string25 rep4_watchlist_city_4;
		string2 rep4_watchlist_state_4;
		string5 rep4_watchlist_zip_4;
		string30 rep4_watchlist_country_4;
		string200 rep4_watchlist_entity_name_4;
		string60 rep4_watchlist_table_5;
		string120 rep4_watchlist_program_5;
		string10 rep4_watchlist_record_number_5;
		string20 rep4_watchlist_fname_5;
		string20 rep4_watchlist_lname_5;
		string65 rep4_watchlist_address_5;
		string25 rep4_watchlist_city_5;
		string2 rep4_watchlist_state_5;
		string5 rep4_watchlist_zip_5;
		string30 rep4_watchlist_country_5;
		string200 rep4_watchlist_entity_name_5;
		string60 rep4_watchlist_table_6;
		string120 rep4_watchlist_program_6;
		string10 rep4_watchlist_record_number_6;
		string20 rep4_watchlist_fname_6;
		string20 rep4_watchlist_lname_6;
		string65 rep4_watchlist_address_6;
		string25 rep4_watchlist_city_6;
		string2 rep4_watchlist_state_6;
		string5 rep4_watchlist_zip_6;
		string30 rep4_watchlist_country_6;
		string200 rep4_watchlist_entity_name_6;
		string60 rep4_watchlist_table_7;
		string120 rep4_watchlist_program_7;
		string10 rep4_watchlist_record_number_7;
		string20 rep4_watchlist_fname_7;
		string20 rep4_watchlist_lname_7;
		string65 rep4_watchlist_address_7;
		string25 rep4_watchlist_city_7;
		string2 rep4_watchlist_state_7;
		string5 rep4_watchlist_zip_7;
		string30 rep4_watchlist_country_7;
		string200 rep4_watchlist_entity_name_7;
		string20 rep5_verfirst;
		string20 rep5_verlast;
		string50 rep5_veraddr;
		string30 rep5_vercity;
		string2 rep5_verstate;
		string5 rep5_verzip;
		string4 rep5_verzip4;
		string20 rep5_vercounty;
		string9 rep5_verssn;
		string8 rep5_verdob;
		string10 rep5_verhphone;
		string25 rep5_verdl;
		string1 rep5_verify_addr;
		string1 rep5_verify_dob;
		string1 rep5_valid_ssn;
		string3 rep5_nas_summary;
		string3 rep5_nap_summary;
		string1 rep5_nap_type;
		string1 rep5_nap_status;
		string3 rep5_cvi;
		string8 rep5_deceaseddate;
		string8 rep5_deceaseddob;
		string20 rep5_deceasedfirst;
		string20 rep5_deceasedlast;
		string1 rep5_dobmatchlevel;
		string4 rep5_hri_1;
		string100 rep5_hri_desc_1;
		string4 rep5_hri_2;
		string100 rep5_hri_desc_2;
		string4 rep5_hri_3;
		string100 rep5_hri_desc_3;
		string4 rep5_hri_4;
		string100 rep5_hri_desc_4;
		string4 rep5_hri_5;
		string100 rep5_hri_desc_5;
		string4 rep5_hri_6;
		string100 rep5_hri_desc_6;
		string4 rep5_hri_7;
		string100 rep5_hri_desc_7;
		string4 rep5_hri_8;
		string100 rep5_hri_desc_8;
		string4 rep5_hri_9;
		string100 rep5_hri_desc_9;
		string4 rep5_hri_10;
		string100 rep5_hri_desc_10;
		string4 rep5_fua_1;
		string150 rep5_fua_desc_1;
		string4 rep5_fua_2;
		string150 rep5_fua_desc_2;
		string4 rep5_fua_3;
		string150 rep5_fua_desc_3;
		string4 rep5_fua_4;
		string150 rep5_fua_desc_4;
		string20 rep5_corrected_lname;
		string8 rep5_corrected_dob;
		string10 rep5_corrected_phone;
		string9 rep5_corrected_ssn;
		string65 rep5_corrected_address;
		string3 rep5_area_code_split;
		string8 rep5_area_code_split_date;
		string20 rep5_phone_fname;
		string20 rep5_phone_lname;
		string65 rep5_phone_address;
		string25 rep5_phone_city;
		string2 rep5_phone_st;
		string5 rep5_phone_zip;
		string10 rep5_name_addr_phone;
		string6 rep5_ssa_date_first;
		string6 rep5_ssa_date_last;
		string2 rep5_ssa_state;
		string20 rep5_ssa_state_name;
		string20 rep5_current_fname;
		string20 rep5_current_lname;
		string65 rep5_chron_address_1;
		string25 rep5_chron_city_1;
		string2 rep5_chron_st_1;
		string5 rep5_chron_zip_1;
		string4 rep5_chron_zip4_1;
		string50 rep5_chron_phone_1;
		string6 rep5_chron_dt_first_seen_1;
		string6 rep5_chron_dt_last_seen_1;
		string65 rep5_chron_address_2;
		string25 rep5_chron_city_2;
		string2 rep5_chron_st_2;
		string5 rep5_chron_zip_2;
		string4 rep5_chron_zip4_2;
		string50 rep5_chron_phone_2;
		string6 rep5_chron_dt_first_seen_2;
		string6 rep5_chron_dt_last_seen_2;
		string65 rep5_chron_address_3;
		string25 rep5_chron_city_3;
		string2 rep5_chron_st_3;
		string5 rep5_chron_zip_3;
		string4 rep5_chron_zip4_3;
		string50 rep5_chron_phone_3;
		string6 rep5_chron_dt_first_seen_3;
		string6 rep5_chron_dt_last_seen_3;
		string20 rep5_addl_fname_1;
		string20 rep5_addl_lname_1;
		string8 rep5_addl_lname_date_last_1;
		string20 rep5_addl_fname_2;
		string20 rep5_addl_lname_2;
		string8 rep5_addl_lname_date_last_2;
		string20 rep5_addl_fname_3;
		string20 rep5_addl_lname_3;
		string8 rep5_addl_lname_date_last_3;
		boolean rep5_addresspobox;
		boolean rep5_addresscmra;
		string60 rep5_watchlist_table;
		string120 rep5_watchlist_program;
		string10 rep5_watchlist_record_number;
		string20 rep5_watchlist_fname;
		string20 rep5_watchlist_lname;
		string65 rep5_watchlist_address;
		string25 rep5_watchlist_city;
		string2 rep5_watchlist_state;
		string5 rep5_watchlist_zip;
		string30 rep5_watchlist_country;
		string200 rep5_watchlist_entity_name;
		string60 rep5_watchlist_table_2;
		string120 rep5_watchlist_program_2;
		string10 rep5_watchlist_record_number_2;
		string20 rep5_watchlist_fname_2;
		string20 rep5_watchlist_lname_2;
		string65 rep5_watchlist_address_2;
		string25 rep5_watchlist_city_2;
		string2 rep5_watchlist_state_2;
		string5 rep5_watchlist_zip_2;
		string30 rep5_watchlist_country_2;
		string200 rep5_watchlist_entity_name_2;
		string60 rep5_watchlist_table_3;
		string120 rep5_watchlist_program_3;
		string10 rep5_watchlist_record_number_3;
		string20 rep5_watchlist_fname_3;
		string20 rep5_watchlist_lname_3;
		string65 rep5_watchlist_address_3;
		string25 rep5_watchlist_city_3;
		string2 rep5_watchlist_state_3;
		string5 rep5_watchlist_zip_3;
		string30 rep5_watchlist_country_3;
		string200 rep5_watchlist_entity_name_3;
		string60 rep5_watchlist_table_4;
		string120 rep5_watchlist_program_4;
		string10 rep5_watchlist_record_number_4;
		string20 rep5_watchlist_fname_4;
		string20 rep5_watchlist_lname_4;
		string65 rep5_watchlist_address_4;
		string25 rep5_watchlist_city_4;
		string2 rep5_watchlist_state_4;
		string5 rep5_watchlist_zip_4;
		string30 rep5_watchlist_country_4;
		string200 rep5_watchlist_entity_name_4;
		string60 rep5_watchlist_table_5;
		string120 rep5_watchlist_program_5;
		string10 rep5_watchlist_record_number_5;
		string20 rep5_watchlist_fname_5;
		string20 rep5_watchlist_lname_5;
		string65 rep5_watchlist_address_5;
		string25 rep5_watchlist_city_5;
		string2 rep5_watchlist_state_5;
		string5 rep5_watchlist_zip_5;
		string30 rep5_watchlist_country_5;
		string200 rep5_watchlist_entity_name_5;
		string60 rep5_watchlist_table_6;
		string120 rep5_watchlist_program_6;
		string10 rep5_watchlist_record_number_6;
		string20 rep5_watchlist_fname_6;
		string20 rep5_watchlist_lname_6;
		string65 rep5_watchlist_address_6;
		string25 rep5_watchlist_city_6;
		string2 rep5_watchlist_state_6;
		string5 rep5_watchlist_zip_6;
		string30 rep5_watchlist_country_6;
		string200 rep5_watchlist_entity_name_6;
		string60 rep5_watchlist_table_7;
		string120 rep5_watchlist_program_7;
		string10 rep5_watchlist_record_number_7;
		string20 rep5_watchlist_fname_7;
		string20 rep5_watchlist_lname_7;
		string65 rep5_watchlist_address_7;
		string25 rep5_watchlist_city_7;
		string2 rep5_watchlist_state_7;
		string5 rep5_watchlist_zip_7;
		string30 rep5_watchlist_country_7;
		string200 rep5_watchlist_entity_name_7;
	END;
	
	
	EXPORT BIID_Report_Function(STRING filename, STRING output_base_location, STRING jobid_in = ''):= FUNCTION
		
		eyeball := 100;
		string jobid := if(jobid_in = '', thorlib.wuid(), jobid_in);

		biidInputRecords :=  DATASET(filename, BIIDRecord ,CSV(SEPARATOR('|'), HEADING(single), QUOTE('"'), MAXLENGTH(30000)));
		// biidInputRecords :=  DATASET(filename, BIIDRecord ,CSV(HEADING(single), QUOTE('"'), MAXLENGTH(30000)));
		
		totalNumberOfRecords :=  COUNT(biidInputRecords);
		
		NUM_POSS_SEARCHED_CODES := 106;
		NUMBER_OF_CASES := 'Number of Cases';
		PERCENT_OF_TOTOAL := '% of Total';
		INVALID := 'Invalid';
		
		calcPercentage(provided) := FUNCTION
			RETURN (provided/totalNumberOfRecords) * 100;
		END;


/* **************************************
 *              Overview                *
 ****************************************/		
		InputSummary_Layout := RECORD
			UNSIGNED 	total_records_provided;
			REAL			total_records_percentage;
			UNSIGNED 	company_name_count;
			REAL 			company_name_percentage;
			UNSIGNED 	dba_count;
			REAL 			dba_percentage;
			UNSIGNED 	fein_count;
			REAL 			fein_percentage;
			UNSIGNED 	address_count;
			REAL 			address_percentage;
			UNSIGNED 	city_count;
			REAL 			city_percentage;
			UNSIGNED 	state_count;
			REAL 			state_percentage;
			UNSIGNED 	zip_count;
			REAL 			zip_percentage;
			UNSIGNED 	phone_count;
			REAL 			phone_percentage;
			
			UNSIGNED rep1_ssn_count;
			REAL     rep1_ssn_percentage;
			UNSIGNED rep1_first_name_count;
			REAL     rep1_first_name_percentage;
			UNSIGNED rep1_middle_name_count;
			REAL     rep1_middle_name_percentage;
			UNSIGNED rep1_last_name_count;
			REAL     rep1_last_name_percentage;
			UNSIGNED rep1_dob_count;
			REAL     rep1_dob_percentage;
			UNSIGNED rep1_address_count;
			REAL     rep1_address_percentage;
			UNSIGNED rep1_city_count;
			REAL     rep1_city_percentage;
			UNSIGNED rep1_state_count;
			REAL     rep1_state_percentage;
			UNSIGNED rep1_zip_count;
			REAL     rep1_zip_percentage;
			UNSIGNED rep1_phone_count;
			REAL     rep1_phone_percentage;
			UNSIGNED rep1_dl_number_count;
			REAL     rep1_dl_number_percentage;
			UNSIGNED rep1_dl_state_count;
			REAL     rep1_dl_state_percentage;

			UNSIGNED rep2_ssn_count;
			REAL     rep2_ssn_percentage;
			UNSIGNED rep2_first_name_count;
			REAL     rep2_first_name_percentage;
			UNSIGNED rep2_middle_name_count;
			REAL     rep2_middle_name_percentage;
			UNSIGNED rep2_last_name_count;
			REAL     rep2_last_name_percentage;
			UNSIGNED rep2_dob_count;
			REAL     rep2_dob_percentage;
			UNSIGNED rep2_address_count;
			REAL     rep2_address_percentage;
			UNSIGNED rep2_city_count;
			REAL     rep2_city_percentage;
			UNSIGNED rep2_state_count;
			REAL     rep2_state_percentage;
			UNSIGNED rep2_zip_count;
			REAL     rep2_zip_percentage;
			UNSIGNED rep2_phone_count;
			REAL     rep2_phone_percentage;
			UNSIGNED rep2_dl_number_count;
			REAL     rep2_dl_number_percentage;
			UNSIGNED rep2_dl_state_count;
			REAL     rep2_dl_state_percentage;

			UNSIGNED rep3_ssn_count;
			REAL     rep3_ssn_percentage;
			UNSIGNED rep3_first_name_count;
			REAL     rep3_first_name_percentage;
			UNSIGNED rep3_middle_name_count;
			REAL     rep3_middle_name_percentage;
			UNSIGNED rep3_last_name_count;
			REAL     rep3_last_name_percentage;
			UNSIGNED rep3_dob_count;
			REAL     rep3_dob_percentage;
			UNSIGNED rep3_address_count;
			REAL     rep3_address_percentage;
			UNSIGNED rep3_city_count;
			REAL     rep3_city_percentage;
			UNSIGNED rep3_state_count;
			REAL     rep3_state_percentage;
			UNSIGNED rep3_zip_count;
			REAL     rep3_zip_percentage;
			UNSIGNED rep3_phone_count;
			REAL     rep3_phone_percentage;
			UNSIGNED rep3_dl_number_count;
			REAL     rep3_dl_number_percentage;
			UNSIGNED rep3_dl_state_count;
			REAL     rep3_dl_state_percentage;

			UNSIGNED rep4_ssn_count;
			REAL     rep4_ssn_percentage;
			UNSIGNED rep4_first_name_count;
			REAL     rep4_first_name_percentage;
			UNSIGNED rep4_middle_name_count;
			REAL     rep4_middle_name_percentage;
			UNSIGNED rep4_last_name_count;
			REAL     rep4_last_name_percentage;
			UNSIGNED rep4_dob_count;
			REAL     rep4_dob_percentage;
			UNSIGNED rep4_address_count;
			REAL     rep4_address_percentage;
			UNSIGNED rep4_city_count;
			REAL     rep4_city_percentage;
			UNSIGNED rep4_state_count;
			REAL     rep4_state_percentage;
			UNSIGNED rep4_zip_count;
			REAL     rep4_zip_percentage;
			UNSIGNED rep4_phone_count;
			REAL     rep4_phone_percentage;
			UNSIGNED rep4_dl_number_count;
			REAL     rep4_dl_number_percentage;
			UNSIGNED rep4_dl_state_count;
			REAL     rep4_dl_state_percentage;

			UNSIGNED rep5_ssn_count;
			REAL     rep5_ssn_percentage;
			UNSIGNED rep5_first_name_count;
			REAL     rep5_first_name_percentage;
			UNSIGNED rep5_middle_name_count;
			REAL     rep5_middle_name_percentage;
			UNSIGNED rep5_last_name_count;
			REAL     rep5_last_name_percentage;
			UNSIGNED rep5_dob_count;
			REAL     rep5_dob_percentage;
			UNSIGNED rep5_address_count;
			REAL     rep5_address_percentage;
			UNSIGNED rep5_city_count;
			REAL     rep5_city_percentage;
			UNSIGNED rep5_state_count;
			REAL     rep5_state_percentage;
			UNSIGNED rep5_zip_count;
			REAL     rep5_zip_percentage;
			UNSIGNED rep5_phone_count;
			REAL     rep5_phone_percentage;
			UNSIGNED rep5_dl_number_count;
			REAL     rep5_dl_number_percentage;
			UNSIGNED rep5_dl_state_count;
			REAL     rep5_dl_state_percentage;
		END;
		

		Input_Detailed_Summary := DATASET([TRANSFORM(InputSummary_Layout,
																	SELF.total_records_provided := totalNumberOfRecords;
																	SELF.total_records_percentage := calcPercentage(totalNumberOfRecords);
																	SELF.company_name_count := COUNT(biidInputRecords(bus_company_name != ''));
																	SELF.company_name_percentage := calcPercentage(SELF.company_name_count);
																	SELF.dba_count := COUNT(biidInputRecords(bus_alt_company_name != ''));
																	SELF.dba_percentage := calcPercentage(SELF.dba_count);
																	SELF.fein_count := COUNT(biidInputRecords(bus_fein != ''));
																	SELF.fein_percentage := calcPercentage(SELF.fein_count);
																	SELF.address_count := COUNT(biidInputRecords(bus_addr1 != ''));
																	SELF.address_percentage := calcPercentage(SELF.address_count);
																	SELF.city_count := COUNT(biidInputRecords(bus_city_name != ''));
																	SELF.city_percentage := calcPercentage(SELF.city_count);
																	SELF.state_count := COUNT(biidInputRecords(bus_st != ''));
																	SELF.state_percentage := calcPercentage(SELF.state_count);
																	SELF.zip_count := COUNT(biidInputRecords(bus_z5 != ''));
																	SELF.zip_percentage := calcPercentage(SELF.zip_count);
																	SELF.phone_count := COUNT(biidInputRecords(bus_phone10 != ''));
																	SELF.phone_percentage := calcPercentage(SELF.phone_count);

																	SELF.rep1_ssn_count := COUNT(biidInputRecords(rep1_ssn != ''));
																	SELF.rep1_ssn_percentage := calcPercentage(SELF.rep1_ssn_count);
																	SELF.rep1_first_name_count := COUNT(biidInputRecords(rep1_firstname != ''));
																	SELF.rep1_first_name_percentage := calcPercentage(SELF.rep1_first_name_count);
																	SELF.rep1_middle_name_count := COUNT(biidInputRecords(rep1_middlename != ''));
																	SELF.rep1_middle_name_percentage := calcPercentage(SELF.rep1_middle_name_count);
																	SELF.rep1_last_name_count := COUNT(biidInputRecords(rep1_lastname != ''));
																	SELF.rep1_last_name_percentage := calcPercentage(SELF.rep1_last_name_count);
																	SELF.rep1_dob_count := COUNT(biidInputRecords(rep1_dob != ''));
																	SELF.rep1_dob_percentage := calcPercentage(SELF.rep1_dob_count);
																	SELF.rep1_address_count := COUNT(biidInputRecords(rep1_addr1 != ''));
																	SELF.rep1_address_percentage := calcPercentage(SELF.rep1_address_count);
																	SELF.rep1_city_count := COUNT(biidInputRecords(rep1_city_name != ''));
																	SELF.rep1_city_percentage := calcPercentage(SELF.rep1_city_count);
																	SELF.rep1_state_count := COUNT(biidInputRecords(rep1_st != ''));
																	SELF.rep1_state_percentage := calcPercentage(SELF.rep1_state_count);
																	SELF.rep1_zip_count := COUNT(biidInputRecords(rep1_z5 != ''));
																	SELF.rep1_zip_percentage := calcPercentage(SELF.rep1_zip_count);
																	SELF.rep1_phone_count := COUNT(biidInputRecords(rep1_phone10 != ''));
																	SELF.rep1_phone_percentage := calcPercentage(SELF.rep1_phone_count);
																	SELF.rep1_dl_number_count := COUNT(biidInputRecords(rep1_dlnumber != ''));
																	SELF.rep1_dl_number_percentage := calcPercentage(SELF.rep1_dl_number_count);
																	SELF.rep1_dl_state_count := COUNT(biidInputRecords(rep1_dlstate != ''));
																	SELF.rep1_dl_state_percentage := calcPercentage(SELF.rep1_dl_state_count);

																	SELF.rep2_ssn_count := COUNT(biidInputRecords(rep2_ssn != ''));
																	SELF.rep2_ssn_percentage := calcPercentage(SELF.rep2_ssn_count);
																	SELF.rep2_first_name_count := COUNT(biidInputRecords(rep2_firstname != ''));
																	SELF.rep2_first_name_percentage := calcPercentage(SELF.rep2_first_name_count);
																	SELF.rep2_middle_name_count := COUNT(biidInputRecords(rep2_middlename != ''));
																	SELF.rep2_middle_name_percentage := calcPercentage(SELF.rep2_middle_name_count);
																	SELF.rep2_last_name_count := COUNT(biidInputRecords(rep2_lastname != ''));
																	SELF.rep2_last_name_percentage := calcPercentage(SELF.rep2_last_name_count);
																	SELF.rep2_dob_count := COUNT(biidInputRecords(rep2_dob != ''));
																	SELF.rep2_dob_percentage := calcPercentage(SELF.rep2_dob_count);
																	SELF.rep2_address_count := COUNT(biidInputRecords(rep2_addr1 != ''));
																	SELF.rep2_address_percentage := calcPercentage(SELF.rep2_address_count);
																	SELF.rep2_city_count := COUNT(biidInputRecords(rep2_city_name != ''));
																	SELF.rep2_city_percentage := calcPercentage(SELF.rep2_city_count);
																	SELF.rep2_state_count := COUNT(biidInputRecords(rep2_st != ''));
																	SELF.rep2_state_percentage := calcPercentage(SELF.rep2_state_count);
																	SELF.rep2_zip_count := COUNT(biidInputRecords(rep2_z5 != ''));
																	SELF.rep2_zip_percentage := calcPercentage(SELF.rep2_zip_count);
																	SELF.rep2_phone_count := COUNT(biidInputRecords(rep2_phone10 != ''));
																	SELF.rep2_phone_percentage := calcPercentage(SELF.rep2_phone_count);
																	SELF.rep2_dl_number_count := COUNT(biidInputRecords(rep2_dlnumber != ''));
																	SELF.rep2_dl_number_percentage := calcPercentage(SELF.rep2_dl_number_count);
																	SELF.rep2_dl_state_count := COUNT(biidInputRecords(rep2_dlstate != ''));
																	SELF.rep2_dl_state_percentage := calcPercentage(SELF.rep2_dl_state_count);

																	SELF.rep3_ssn_count := COUNT(biidInputRecords(rep3_ssn != ''));
																	SELF.rep3_ssn_percentage := calcPercentage(SELF.rep3_ssn_count);
																	SELF.rep3_first_name_count := COUNT(biidInputRecords(rep3_firstname != ''));
																	SELF.rep3_first_name_percentage := calcPercentage(SELF.rep3_first_name_count);
																	SELF.rep3_middle_name_count := COUNT(biidInputRecords(rep3_middlename != ''));
																	SELF.rep3_middle_name_percentage := calcPercentage(SELF.rep3_middle_name_count);
																	SELF.rep3_last_name_count := COUNT(biidInputRecords(rep3_lastname != ''));
																	SELF.rep3_last_name_percentage := calcPercentage(SELF.rep3_last_name_count);
																	SELF.rep3_dob_count := COUNT(biidInputRecords(rep3_dob != ''));
																	SELF.rep3_dob_percentage := calcPercentage(SELF.rep3_dob_count);
																	SELF.rep3_address_count := COUNT(biidInputRecords(rep3_addr1 != ''));
																	SELF.rep3_address_percentage := calcPercentage(SELF.rep3_address_count);
																	SELF.rep3_city_count := COUNT(biidInputRecords(rep3_city_name != ''));
																	SELF.rep3_city_percentage := calcPercentage(SELF.rep3_city_count);
																	SELF.rep3_state_count := COUNT(biidInputRecords(rep3_st != ''));
																	SELF.rep3_state_percentage := calcPercentage(SELF.rep3_state_count);
																	SELF.rep3_zip_count := COUNT(biidInputRecords(rep3_z5 != ''));
																	SELF.rep3_zip_percentage := calcPercentage(SELF.rep3_zip_count);
																	SELF.rep3_phone_count := COUNT(biidInputRecords(rep3_phone10 != ''));
																	SELF.rep3_phone_percentage := calcPercentage(SELF.rep3_phone_count);
																	SELF.rep3_dl_number_count := COUNT(biidInputRecords(rep3_dlnumber != ''));
																	SELF.rep3_dl_number_percentage := calcPercentage(SELF.rep3_dl_number_count);
																	SELF.rep3_dl_state_count := COUNT(biidInputRecords(rep3_dlstate != ''));
																	SELF.rep3_dl_state_percentage := calcPercentage(SELF.rep3_dl_state_count);

																	SELF.rep4_ssn_count := COUNT(biidInputRecords(rep4_ssn != ''));
																	SELF.rep4_ssn_percentage := calcPercentage(SELF.rep4_ssn_count);
																	SELF.rep4_first_name_count := COUNT(biidInputRecords(rep4_firstname != ''));
																	SELF.rep4_first_name_percentage := calcPercentage(SELF.rep4_first_name_count);
																	SELF.rep4_middle_name_count := COUNT(biidInputRecords(rep4_middlename != ''));
																	SELF.rep4_middle_name_percentage := calcPercentage(SELF.rep4_middle_name_count);
																	SELF.rep4_last_name_count := COUNT(biidInputRecords(rep4_lastname != ''));
																	SELF.rep4_last_name_percentage := calcPercentage(SELF.rep4_last_name_count);
																	SELF.rep4_dob_count := COUNT(biidInputRecords(rep4_dob != ''));
																	SELF.rep4_dob_percentage := calcPercentage(SELF.rep4_dob_count);
																	SELF.rep4_address_count := COUNT(biidInputRecords(rep4_addr1 != ''));
																	SELF.rep4_address_percentage := calcPercentage(SELF.rep4_address_count);
																	SELF.rep4_city_count := COUNT(biidInputRecords(rep4_city_name != ''));
																	SELF.rep4_city_percentage := calcPercentage(SELF.rep4_city_count);
																	SELF.rep4_state_count := COUNT(biidInputRecords(rep4_st != ''));
																	SELF.rep4_state_percentage := calcPercentage(SELF.rep4_state_count);
																	SELF.rep4_zip_count := COUNT(biidInputRecords(rep4_z5 != ''));
																	SELF.rep4_zip_percentage := calcPercentage(SELF.rep4_zip_count);
																	SELF.rep4_phone_count := COUNT(biidInputRecords(rep4_phone10 != ''));
																	SELF.rep4_phone_percentage := calcPercentage(SELF.rep4_phone_count);
																	SELF.rep4_dl_number_count := COUNT(biidInputRecords(rep4_dlnumber != ''));
																	SELF.rep4_dl_number_percentage := calcPercentage(SELF.rep4_dl_number_count);
																	SELF.rep4_dl_state_count := COUNT(biidInputRecords(rep4_dlstate != ''));
																	SELF.rep4_dl_state_percentage := calcPercentage(SELF.rep4_dl_state_count);

																	SELF.rep5_ssn_count := COUNT(biidInputRecords(rep5_ssn != ''));
																	SELF.rep5_ssn_percentage := calcPercentage(SELF.rep5_ssn_count);
																	SELF.rep5_first_name_count := COUNT(biidInputRecords(rep5_firstname != ''));
																	SELF.rep5_first_name_percentage := calcPercentage(SELF.rep5_first_name_count);
																	SELF.rep5_middle_name_count := COUNT(biidInputRecords(rep5_middlename != ''));
																	SELF.rep5_middle_name_percentage := calcPercentage(SELF.rep5_middle_name_count);
																	SELF.rep5_last_name_count := COUNT(biidInputRecords(rep5_lastname != ''));
																	SELF.rep5_last_name_percentage := calcPercentage(SELF.rep5_last_name_count);
																	SELF.rep5_dob_count := COUNT(biidInputRecords(rep5_dob != ''));
																	SELF.rep5_dob_percentage := calcPercentage(SELF.rep5_dob_count);
																	SELF.rep5_address_count := COUNT(biidInputRecords(rep5_addr1 != ''));
																	SELF.rep5_address_percentage := calcPercentage(SELF.rep5_address_count);
																	SELF.rep5_city_count := COUNT(biidInputRecords(rep5_city_name != ''));
																	SELF.rep5_city_percentage := calcPercentage(SELF.rep5_city_count);
																	SELF.rep5_state_count := COUNT(biidInputRecords(rep5_st != ''));
																	SELF.rep5_state_percentage := calcPercentage(SELF.rep5_state_count);
																	SELF.rep5_zip_count := COUNT(biidInputRecords(rep5_z5 != ''));
																	SELF.rep5_zip_percentage := calcPercentage(SELF.rep5_zip_count);
																	SELF.rep5_phone_count := COUNT(biidInputRecords(rep5_phone10 != ''));
																	SELF.rep5_phone_percentage := calcPercentage(SELF.rep5_phone_count);
																	SELF.rep5_dl_number_count := COUNT(biidInputRecords(rep5_dlnumber != ''));
																	SELF.rep5_dl_number_percentage := calcPercentage(SELF.rep5_dl_number_count);
																	SELF.rep5_dl_state_count := COUNT(biidInputRecords(rep5_dlstate != ''));
																	SELF.rep5_dl_state_percentage := calcPercentage(SELF.rep5_dl_state_count);
															)]);
																				
		

		Generic_Layout := RECORD
			STRING key;
			REAL field_0;
			REAL field_1;
			REAL field_2;
			REAL field_3;
			REAL field_4;
			REAL field_5;
			REAL field_6;
			REAL field_7;
			REAL field_8;
			REAL field_9;
			REAL field_02;
			REAL field_03;
			REAL field_04;
			REAL field_06;
			REAL field_07;
			REAL field_08;
			REAL field_09;
			REAL field_10;
			REAL field_11;
			REAL field_12;
			REAL field_13;
			REAL field_14;
			REAL field_15;
			REAL field_16;
			REAL field_17;
			REAL field_18;
			REAL field_19;
			REAL field_20;
			REAL field_21;
			REAL field_22;
			REAL field_23;
			REAL field_24;
			REAL field_25;
			REAL field_26;
			REAL field_27;
			REAL field_28;
			REAL field_29;
			REAL field_30;
			REAL field_31;
			REAL field_32;
			REAL field_33;
			REAL field_34;
			REAL field_35;
			REAL field_36;
			REAL field_37;
			REAL field_38;
			REAL field_39;
			REAL field_40;
			REAL field_41;
			REAL field_42;
			REAL field_43;
			REAL field_44;
			REAL field_45;
			REAL field_46;
			REAL field_47;
			REAL field_48;
			REAL field_49;
			REAL field_50;
			REAL field_51;
			REAL field_52;
			REAL field_53;
			REAL field_54;
			REAL field_55;
			REAL field_56;
			REAL field_57;
			REAL field_64;
			REAL field_66;
			REAL field_71;
			REAL field_72;
			REAL field_74;
			REAL field_75;
			REAL field_76;
			REAL field_77;
			REAL field_78;
			REAL field_79;
			REAL field_80;
			REAL field_81;
			REAL field_82;
			REAL field_83;
			REAL field_85;
			REAL field_89;
			REAL field_90;
			REAL field_CA;
			REAL field_CL;
			REAL field_CO;
			REAL field_CZ;
			REAL field_DD;
			REAL field_DF;
			REAL field_DI;
			REAL field_DM;
			REAL field_DV;
			REAL field_IS;
			REAL field_IT;
			REAL field_MI;
			REAL field_MO;
			REAL field_MS;
			REAL field_NB;
			REAL field_NF;
			REAL field_PA;
			REAL field_PO;
			REAL field_RS;
			REAL field_SD;
			REAL field_SR;
			REAL field_VA;
			REAL field_WL;
			REAL field_ZI;
			BOOLEAN include_0;
			BOOLEAN include_1;
			BOOLEAN include_2;
			BOOLEAN include_3;
			BOOLEAN include_4;
			BOOLEAN include_5;
			BOOLEAN include_6;
			BOOLEAN include_7;
			BOOLEAN include_8;
			BOOLEAN include_9;
			BOOLEAN include_02;
			BOOLEAN include_03;
			BOOLEAN include_04;
			BOOLEAN include_06;
			BOOLEAN include_07;
			BOOLEAN include_08;
			BOOLEAN include_09;
			BOOLEAN include_10;
			BOOLEAN include_11;
			BOOLEAN include_12;
			BOOLEAN include_13;
			BOOLEAN include_14;
			BOOLEAN include_15;
			BOOLEAN include_16;
			BOOLEAN include_17;
			BOOLEAN include_18;
			BOOLEAN include_19;
			BOOLEAN include_20;
			BOOLEAN include_21;
			BOOLEAN include_22;
			BOOLEAN include_23;
			BOOLEAN include_24;
			BOOLEAN include_25;
			BOOLEAN include_26;
			BOOLEAN include_27;
			BOOLEAN include_28;
			BOOLEAN include_29;
			BOOLEAN include_30;
			BOOLEAN include_31;
			BOOLEAN include_32;
			BOOLEAN include_33;
			BOOLEAN include_34;
			BOOLEAN include_35;
			BOOLEAN include_36;
			BOOLEAN include_37;
			BOOLEAN include_38;
			BOOLEAN include_39;
			BOOLEAN include_40;
			BOOLEAN include_41;
			BOOLEAN include_42;
			BOOLEAN include_43;
			BOOLEAN include_44;
			BOOLEAN include_45;
			BOOLEAN include_46;
			BOOLEAN include_47;
			BOOLEAN include_48;
			BOOLEAN include_49;
			BOOLEAN include_50;
			BOOLEAN include_51;
			BOOLEAN include_52;
			BOOLEAN include_53;
			BOOLEAN include_54;
			BOOLEAN include_55;
			BOOLEAN include_56;
			BOOLEAN include_57;
			BOOLEAN include_64;
			BOOLEAN include_66;
			BOOLEAN include_71;
			BOOLEAN include_72;
			BOOLEAN include_74;
			BOOLEAN include_75;
			BOOLEAN include_76;
			BOOLEAN include_77;
			BOOLEAN include_78;
			BOOLEAN include_79;
			BOOLEAN include_80;
			BOOLEAN include_81;
			BOOLEAN include_82;
			BOOLEAN include_83;
			BOOLEAN include_85;
			BOOLEAN include_89;
			BOOLEAN include_90;
			BOOLEAN include_CA;
			BOOLEAN include_CL;
			BOOLEAN include_CO;
			BOOLEAN include_CZ;
			BOOLEAN include_DD;
			BOOLEAN include_DF;
			BOOLEAN include_DI;
			BOOLEAN include_DM;
			BOOLEAN include_DV;
			BOOLEAN include_IS;
			BOOLEAN include_IT;
			BOOLEAN include_MI;
			BOOLEAN include_MO;
			BOOLEAN include_MS;
			BOOLEAN include_NB;
			BOOLEAN include_NF;
			BOOLEAN include_PA;
			BOOLEAN include_PO;
			BOOLEAN include_RS;
			BOOLEAN include_SD;
			BOOLEAN include_SR;
			BOOLEAN include_VA;
			BOOLEAN include_WL;
			BOOLEAN include_ZI;
		END;
		
		Final_Layout := RECORD
			STRING code_searched;
			REAL all;
			REAL cvi_00;
			REAL cvi_10;
			REAL cvi_20;
			REAL cvi_30;
			REAL cvi_40;
			REAL cvi_50;
		END;
		
		
		Final_Layout createRecord(STRING Name, REAL fieldValue, STRING key, REAL calcdTotal) := TRANSFORM
			SELF.code_searched := Name;
			SELF.cvi_00 := if(STD.str.StartsWith(key, '0'), fieldValue, 0);
			SELF.cvi_10 := if(STD.str.StartsWith(key, '10'), fieldValue, 0);
			SELF.cvi_20 := if(STD.str.StartsWith(key, '20'), fieldValue, 0);
			SELF.cvi_30 := if(STD.str.StartsWith(key, '30'), fieldValue, 0);
			SELF.cvi_40 := if(STD.str.StartsWith(key, '40'), fieldValue, 0);
			SELF.cvi_50 := if(STD.str.StartsWith(key, '50'), fieldValue, 0);
			SELF.all := calcdTotal;
		END;	
		
		Final_Layout finalRoll(Final_Layout le, Final_Layout ri) := TRANSFORM
			SELF.cvi_00 := le.cvi_00 + ri.cvi_00;
			SELF.cvi_10 := le.cvi_10 + ri.cvi_10;
			SELF.cvi_20 := le.cvi_20 + ri.cvi_20;
			SELF.cvi_30 := le.cvi_30 + ri.cvi_30;
			SELF.cvi_40 := le.cvi_40 + ri.cvi_40;
			SELF.cvi_50 := le.cvi_50 + ri.cvi_50;
			SELF := le;
		END;
				
		calcResults(DATASET(Generic_Layout) ds) := FUNCTION
					
				
				totalCount := SUM(ds, field_0 + field_1 + field_2 + field_3 + field_4 + field_5 + field_6 + field_7 + 
															field_8 + field_9 + field_02 + field_03 + field_04 + field_06 + field_07 + field_08 + 
															field_09 + field_10 + field_11 + field_12 + field_13 + field_14 + field_15 + field_16 + 
															field_17 + field_18 + field_19 + field_20 + field_21 + field_22 + field_23 + field_24 + 
															field_25 + field_26 + field_27 + field_28 + field_29 + field_30 + field_31 + field_32 + 
															field_33 + field_34 + field_35 + field_36 + field_37 + field_38 + field_39 + field_40 + 
															field_41 + field_42 + field_43 + field_44 + field_45 + field_46 + field_47 + field_48 + 
															field_49 + field_50 + field_51 + field_52 + field_53 + field_54 + field_55 + field_56 + 
															field_57 + field_64 + field_66 + field_71 + field_72 + field_74 + field_75 + field_76 + 
															field_77 + field_78 + field_79 + field_80 + field_81 + field_82 + field_83 + field_85 + 
															field_89 + field_90 + field_CA + field_CL + field_CO + field_CZ + field_DD + field_DF + 
															field_DI + field_DM + field_DV + field_IS + field_IT + field_MI + field_MO + field_MS + 
															field_NB + field_NF + field_PA + field_PO + field_RS + field_SD + field_SR + field_VA + 
															field_WL + field_ZI);
				
				
				Temp_Layout := RECORD
					UNSIGNED total;
					REAL total_percent;
					RECORDOF(ds);
				END;
				
				summary := PROJECT(ds, TRANSFORM(Temp_Layout,
																							SELF.total := sum(LEFT.field_0 + LEFT.field_1 + LEFT.field_2 + LEFT.field_3 + LEFT.field_4 + LEFT.field_5 + LEFT.field_6 + LEFT.field_7 + 
																																LEFT.field_8 + LEFT.field_9 + LEFT.field_02 + LEFT.field_03 + LEFT.field_04 + LEFT.field_06 + LEFT.field_07 + LEFT.field_08 + 
																																LEFT.field_09 + LEFT.field_10 + LEFT.field_11 + LEFT.field_12 + LEFT.field_13 + LEFT.field_14 + LEFT.field_15 + LEFT.field_16 + 
																																LEFT.field_17 + LEFT.field_18 + LEFT.field_19 + LEFT.field_20 + LEFT.field_21 + LEFT.field_22 + LEFT.field_23 + LEFT.field_24 + 
																																LEFT.field_25 + LEFT.field_26 + LEFT.field_27 + LEFT.field_28 + LEFT.field_29 + LEFT.field_30 + LEFT.field_31 + LEFT.field_32 + 
																																LEFT.field_33 + LEFT.field_34 + LEFT.field_35 + LEFT.field_36 + LEFT.field_37 + LEFT.field_38 + LEFT.field_39 + LEFT.field_40 + 
																																LEFT.field_41 + LEFT.field_42 + LEFT.field_43 + LEFT.field_44 + LEFT.field_45 + LEFT.field_46 + LEFT.field_47 + LEFT.field_48 + 
																																LEFT.field_49 + LEFT.field_50 + LEFT.field_51 + LEFT.field_52 + LEFT.field_53 + LEFT.field_54 + LEFT.field_55 + LEFT.field_56 + 
																																LEFT.field_57 + LEFT.field_64 + LEFT.field_66 + LEFT.field_71 + LEFT.field_72 + LEFT.field_74 + LEFT.field_75 + LEFT.field_76 + 
																																LEFT.field_77 + LEFT.field_78 + LEFT.field_79 + LEFT.field_80 + LEFT.field_81 + LEFT.field_82 + LEFT.field_83 + LEFT.field_85 + 
																																LEFT.field_89 + LEFT.field_90 + LEFT.field_CA + LEFT.field_CL + LEFT.field_CO + LEFT.field_CZ + LEFT.field_DD + LEFT.field_DF + 
																																LEFT.field_DI + LEFT.field_DM + LEFT.field_DV + LEFT.field_IS + LEFT.field_IT + LEFT.field_MI + LEFT.field_MO + LEFT.field_MS + 
																																LEFT.field_NB + LEFT.field_NF + LEFT.field_PA + LEFT.field_PO + LEFT.field_RS + LEFT.field_SD + LEFT.field_SR + LEFT.field_VA + 
																																LEFT.field_WL + LEFT.field_ZI);
																																
																							SELF.total_percent := (SELF.total / totalCount) * 100;
																							SELF.field_0 := (LEFT.field_0 / SELF.total) * 100; 
																							SELF.field_1 := (LEFT.field_1 / SELF.total) * 100; 
																							SELF.field_2 := (LEFT.field_2 / SELF.total) * 100; 
																							SELF.field_3 := (LEFT.field_3 / SELF.total) * 100; 
																							SELF.field_4 := (LEFT.field_4 / SELF.total) * 100; 
																							SELF.field_5 := (LEFT.field_5 / SELF.total) * 100; 
																							SELF.field_6 := (LEFT.field_6 / SELF.total) * 100; 
																							SELF.field_7 := (LEFT.field_7 / SELF.total) * 100; 
																							SELF.field_8 := (LEFT.field_8 / SELF.total) * 100; 
																							SELF.field_9 := (LEFT.field_9 / SELF.total) * 100; 
																							SELF.field_02 := (LEFT.field_02 / SELF.total) * 100; 
																							SELF.field_03 := (LEFT.field_03 / SELF.total) * 100; 
																							SELF.field_04 := (LEFT.field_04 / SELF.total) * 100; 
																							SELF.field_06 := (LEFT.field_06 / SELF.total) * 100; 
																							SELF.field_07 := (LEFT.field_07 / SELF.total) * 100; 
																							SELF.field_08 := (LEFT.field_08 / SELF.total) * 100; 
																							SELF.field_09 := (LEFT.field_09 / SELF.total) * 100; 
																							SELF.field_10 := (LEFT.field_10 / SELF.total) * 100; 
																							SELF.field_11 := (LEFT.field_11 / SELF.total) * 100; 
																							SELF.field_12 := (LEFT.field_12 / SELF.total) * 100; 
																							SELF.field_13 := (LEFT.field_13 / SELF.total) * 100; 
																							SELF.field_14 := (LEFT.field_14 / SELF.total) * 100; 
																							SELF.field_15 := (LEFT.field_15 / SELF.total) * 100; 
																							SELF.field_16 := (LEFT.field_16 / SELF.total) * 100; 
																							SELF.field_17 := (LEFT.field_17 / SELF.total) * 100; 
																							SELF.field_18 := (LEFT.field_18 / SELF.total) * 100; 
																							SELF.field_19 := (LEFT.field_19 / SELF.total) * 100; 
																							SELF.field_20 := (LEFT.field_20 / SELF.total) * 100; 
																							SELF.field_21 := (LEFT.field_21 / SELF.total) * 100; 
																							SELF.field_22 := (LEFT.field_22 / SELF.total) * 100; 
																							SELF.field_23 := (LEFT.field_23 / SELF.total) * 100; 
																							SELF.field_24 := (LEFT.field_24 / SELF.total) * 100; 
																							SELF.field_25 := (LEFT.field_25 / SELF.total) * 100; 
																							SELF.field_26 := (LEFT.field_26 / SELF.total) * 100; 
																							SELF.field_27 := (LEFT.field_27 / SELF.total) * 100; 
																							SELF.field_28 := (LEFT.field_28 / SELF.total) * 100; 
																							SELF.field_29 := (LEFT.field_29 / SELF.total) * 100; 
																							SELF.field_30 := (LEFT.field_30 / SELF.total) * 100; 
																							SELF.field_31 := (LEFT.field_31 / SELF.total) * 100; 
																							SELF.field_32 := (LEFT.field_32 / SELF.total) * 100; 
																							SELF.field_33 := (LEFT.field_33 / SELF.total) * 100; 
																							SELF.field_34 := (LEFT.field_34 / SELF.total) * 100; 
																							SELF.field_35 := (LEFT.field_35 / SELF.total) * 100; 
																							SELF.field_36 := (LEFT.field_36 / SELF.total) * 100; 
																							SELF.field_37 := (LEFT.field_37 / SELF.total) * 100; 
																							SELF.field_38 := (LEFT.field_38 / SELF.total) * 100; 
																							SELF.field_39 := (LEFT.field_39 / SELF.total) * 100; 
																							SELF.field_40 := (LEFT.field_40 / SELF.total) * 100; 
																							SELF.field_41 := (LEFT.field_41 / SELF.total) * 100; 
																							SELF.field_42 := (LEFT.field_42 / SELF.total) * 100; 
																							SELF.field_43 := (LEFT.field_43 / SELF.total) * 100; 
																							SELF.field_44 := (LEFT.field_44 / SELF.total) * 100; 
																							SELF.field_45 := (LEFT.field_45 / SELF.total) * 100; 
																							SELF.field_46 := (LEFT.field_46 / SELF.total) * 100; 
																							SELF.field_47 := (LEFT.field_47 / SELF.total) * 100; 
																							SELF.field_48 := (LEFT.field_48 / SELF.total) * 100; 
																							SELF.field_49 := (LEFT.field_49 / SELF.total) * 100; 
																							SELF.field_50 := (LEFT.field_50 / SELF.total) * 100; 
																							SELF.field_51 := (LEFT.field_51 / SELF.total) * 100; 
																							SELF.field_52 := (LEFT.field_52 / SELF.total) * 100; 
																							SELF.field_53 := (LEFT.field_53 / SELF.total) * 100; 
																							SELF.field_54 := (LEFT.field_54 / SELF.total) * 100; 
																							SELF.field_55 := (LEFT.field_55 / SELF.total) * 100; 
																							SELF.field_56 := (LEFT.field_56 / SELF.total) * 100; 
																							SELF.field_57 := (LEFT.field_57 / SELF.total) * 100; 
																							SELF.field_64 := (LEFT.field_64 / SELF.total) * 100; 
																							SELF.field_66 := (LEFT.field_66 / SELF.total) * 100; 
																							SELF.field_71 := (LEFT.field_71 / SELF.total) * 100; 
																							SELF.field_72 := (LEFT.field_72 / SELF.total) * 100; 
																							SELF.field_74 := (LEFT.field_74 / SELF.total) * 100; 
																							SELF.field_75 := (LEFT.field_75 / SELF.total) * 100; 
																							SELF.field_76 := (LEFT.field_76 / SELF.total) * 100; 
																							SELF.field_77 := (LEFT.field_77 / SELF.total) * 100; 
																							SELF.field_78 := (LEFT.field_78 / SELF.total) * 100; 
																							SELF.field_79 := (LEFT.field_79 / SELF.total) * 100; 
																							SELF.field_80 := (LEFT.field_80 / SELF.total) * 100; 
																							SELF.field_81 := (LEFT.field_81 / SELF.total) * 100; 
																							SELF.field_82 := (LEFT.field_82 / SELF.total) * 100; 
																							SELF.field_83 := (LEFT.field_83 / SELF.total) * 100; 
																							SELF.field_85 := (LEFT.field_85 / SELF.total) * 100; 
																							SELF.field_89 := (LEFT.field_89 / SELF.total) * 100; 
																							SELF.field_90 := (LEFT.field_90 / SELF.total) * 100; 
																							SELF.field_CA := (LEFT.field_CA / SELF.total) * 100; 
																							SELF.field_CL := (LEFT.field_CL / SELF.total) * 100; 
																							SELF.field_CO := (LEFT.field_CO / SELF.total) * 100; 
																							SELF.field_CZ := (LEFT.field_CZ / SELF.total) * 100; 
																							SELF.field_DD := (LEFT.field_DD / SELF.total) * 100; 
																							SELF.field_DF := (LEFT.field_DF / SELF.total) * 100; 
																							SELF.field_DI := (LEFT.field_DI / SELF.total) * 100; 
																							SELF.field_DM := (LEFT.field_DM / SELF.total) * 100; 
																							SELF.field_DV := (LEFT.field_DV / SELF.total) * 100; 
																							SELF.field_IS := (LEFT.field_IS / SELF.total) * 100; 
																							SELF.field_IT := (LEFT.field_IT / SELF.total) * 100; 
																							SELF.field_MI := (LEFT.field_MI / SELF.total) * 100; 
																							SELF.field_MO := (LEFT.field_MO / SELF.total) * 100; 
																							SELF.field_MS := (LEFT.field_MS / SELF.total) * 100; 
																							SELF.field_NB := (LEFT.field_NB / SELF.total) * 100; 
																							SELF.field_NF := (LEFT.field_NF / SELF.total) * 100; 
																							SELF.field_PA := (LEFT.field_PA / SELF.total) * 100; 
																							SELF.field_PO := (LEFT.field_PO / SELF.total) * 100; 
																							SELF.field_RS := (LEFT.field_RS / SELF.total) * 100; 
																							SELF.field_SD := (LEFT.field_SD / SELF.total) * 100; 
																							SELF.field_SR := (LEFT.field_SR / SELF.total) * 100; 
																							SELF.field_VA := (LEFT.field_VA / SELF.total) * 100; 
																							SELF.field_WL := (LEFT.field_WL / SELF.total) * 100; 
																							SELF.field_ZI := (LEFT.field_ZI / SELF.total) * 100; 
																							SELF := LEFT;));
																							
																						
														
				Final_Layout intoFinalLayout(Temp_Layout le, INTEGER cnt) := TRANSFORM
					SELF := CASE(cnt, 
							1	 => IF(le.include_0, ROW(createRecord('0', le.field_0, le.key, (SUM(ds, field_0) / totalCount) * 100))),
							2	 => IF(le.include_1, ROW(createRecord('1', le.field_1, le.key, (SUM(ds, field_1) / totalCount) * 100))),
							3	 => IF(le.include_2, ROW(createRecord('2', le.field_2, le.key, (SUM(ds, field_2) / totalCount) * 100))),
							4	 => IF(le.include_3, ROW(createRecord('3', le.field_3, le.key, (SUM(ds, field_3) / totalCount) * 100))),
							5	 => IF(le.include_4, ROW(createRecord('4', le.field_4, le.key, (SUM(ds, field_4) / totalCount) * 100))),
							6	 => IF(le.include_5, ROW(createRecord('5', le.field_5, le.key, (SUM(ds, field_5) / totalCount) * 100))),
							7	 => IF(le.include_6, ROW(createRecord('6', le.field_6, le.key, (SUM(ds, field_6) / totalCount) * 100))),
							8	 => IF(le.include_7, ROW(createRecord('7', le.field_7, le.key, (SUM(ds, field_7) / totalCount) * 100))),
							9	 => IF(le.include_8, ROW(createRecord('8', le.field_8, le.key, (SUM(ds, field_8) / totalCount) * 100))),
							10	 => IF(le.include_9, ROW(createRecord('9', le.field_9, le.key, (SUM(ds, field_9) / totalCount) * 100))),
							11	 => IF(le.include_02, ROW(createRecord('02', le.field_02, le.key, (SUM(ds, field_02) / totalCount) * 100))),
							12	 => IF(le.include_03, ROW(createRecord('03', le.field_03, le.key, (SUM(ds, field_03) / totalCount) * 100))),
							13	 => IF(le.include_04, ROW(createRecord('04', le.field_04, le.key, (SUM(ds, field_04) / totalCount) * 100))),
							14	 => IF(le.include_06, ROW(createRecord('06', le.field_06, le.key, (SUM(ds, field_06) / totalCount) * 100))),
							15	 => IF(le.include_07, ROW(createRecord('07', le.field_07, le.key, (SUM(ds, field_07) / totalCount) * 100))),
							16	 => IF(le.include_08, ROW(createRecord('08', le.field_08, le.key, (SUM(ds, field_08) / totalCount) * 100))),
							17	 => IF(le.include_09, ROW(createRecord('09', le.field_09, le.key, (SUM(ds, field_09) / totalCount) * 100))),
							18	 => IF(le.include_10, ROW(createRecord('10', le.field_10, le.key, (SUM(ds, field_10) / totalCount) * 100))),
							19	 => IF(le.include_11, ROW(createRecord('11', le.field_11, le.key, (SUM(ds, field_11) / totalCount) * 100))),
							20	 => IF(le.include_12, ROW(createRecord('12', le.field_12, le.key, (SUM(ds, field_12) / totalCount) * 100))),
							21	 => IF(le.include_13, ROW(createRecord('13', le.field_13, le.key, (SUM(ds, field_13) / totalCount) * 100))),
							22	 => IF(le.include_14, ROW(createRecord('14', le.field_14, le.key, (SUM(ds, field_14) / totalCount) * 100))),
							23	 => IF(le.include_15, ROW(createRecord('15', le.field_15, le.key, (SUM(ds, field_15) / totalCount) * 100))),
							24	 => IF(le.include_16, ROW(createRecord('16', le.field_16, le.key, (SUM(ds, field_16) / totalCount) * 100))),
							25	 => IF(le.include_17, ROW(createRecord('17', le.field_17, le.key, (SUM(ds, field_17) / totalCount) * 100))),
							26	 => IF(le.include_18, ROW(createRecord('18', le.field_18, le.key, (SUM(ds, field_18) / totalCount) * 100))),
							27	 => IF(le.include_19, ROW(createRecord('19', le.field_19, le.key, (SUM(ds, field_19) / totalCount) * 100))),
							28	 => IF(le.include_20, ROW(createRecord('20', le.field_20, le.key, (SUM(ds, field_20) / totalCount) * 100))),
							29	 => IF(le.include_21, ROW(createRecord('21', le.field_21, le.key, (SUM(ds, field_21) / totalCount) * 100))),
							30	 => IF(le.include_22, ROW(createRecord('22', le.field_22, le.key, (SUM(ds, field_22) / totalCount) * 100))),
							31	 => IF(le.include_23, ROW(createRecord('23', le.field_23, le.key, (SUM(ds, field_23) / totalCount) * 100))),
							32	 => IF(le.include_24, ROW(createRecord('24', le.field_24, le.key, (SUM(ds, field_24) / totalCount) * 100))),
							33	 => IF(le.include_25, ROW(createRecord('25', le.field_25, le.key, (SUM(ds, field_25) / totalCount) * 100))),
							34	 => IF(le.include_26, ROW(createRecord('26', le.field_26, le.key, (SUM(ds, field_26) / totalCount) * 100))),
							35	 => IF(le.include_27, ROW(createRecord('27', le.field_27, le.key, (SUM(ds, field_27) / totalCount) * 100))),
							36	 => IF(le.include_28, ROW(createRecord('28', le.field_28, le.key, (SUM(ds, field_28) / totalCount) * 100))),
							37	 => IF(le.include_29, ROW(createRecord('29', le.field_29, le.key, (SUM(ds, field_29) / totalCount) * 100))),
							38	 => IF(le.include_30, ROW(createRecord('30', le.field_30, le.key, (SUM(ds, field_30) / totalCount) * 100))),
							39	 => IF(le.include_31, ROW(createRecord('31', le.field_31, le.key, (SUM(ds, field_31) / totalCount) * 100))),
							40	 => IF(le.include_32, ROW(createRecord('32', le.field_32, le.key, (SUM(ds, field_32) / totalCount) * 100))),
							41	 => IF(le.include_33, ROW(createRecord('33', le.field_33, le.key, (SUM(ds, field_33) / totalCount) * 100))),
							42	 => IF(le.include_34, ROW(createRecord('34', le.field_34, le.key, (SUM(ds, field_34) / totalCount) * 100))),
							43	 => IF(le.include_35, ROW(createRecord('35', le.field_35, le.key, (SUM(ds, field_35) / totalCount) * 100))),
							44	 => IF(le.include_36, ROW(createRecord('36', le.field_36, le.key, (SUM(ds, field_36) / totalCount) * 100))),
							45	 => IF(le.include_37, ROW(createRecord('37', le.field_37, le.key, (SUM(ds, field_37) / totalCount) * 100))),
							46	 => IF(le.include_38, ROW(createRecord('38', le.field_38, le.key, (SUM(ds, field_38) / totalCount) * 100))),
							47	 => IF(le.include_39, ROW(createRecord('39', le.field_39, le.key, (SUM(ds, field_39) / totalCount) * 100))),
							48	 => IF(le.include_40, ROW(createRecord('40', le.field_40, le.key, (SUM(ds, field_40) / totalCount) * 100))),
							49	 => IF(le.include_41, ROW(createRecord('41', le.field_41, le.key, (SUM(ds, field_41) / totalCount) * 100))),
							50	 => IF(le.include_42, ROW(createRecord('42', le.field_42, le.key, (SUM(ds, field_42) / totalCount) * 100))),
							51	 => IF(le.include_43, ROW(createRecord('43', le.field_43, le.key, (SUM(ds, field_43) / totalCount) * 100))),
							52	 => IF(le.include_44, ROW(createRecord('44', le.field_44, le.key, (SUM(ds, field_44) / totalCount) * 100))),
							53	 => IF(le.include_45, ROW(createRecord('45', le.field_45, le.key, (SUM(ds, field_45) / totalCount) * 100))),
							54	 => IF(le.include_46, ROW(createRecord('46', le.field_46, le.key, (SUM(ds, field_46) / totalCount) * 100))),
							55	 => IF(le.include_47, ROW(createRecord('47', le.field_47, le.key, (SUM(ds, field_47) / totalCount) * 100))),
							56	 => IF(le.include_48, ROW(createRecord('48', le.field_48, le.key, (SUM(ds, field_48) / totalCount) * 100))),
							57	 => IF(le.include_49, ROW(createRecord('49', le.field_49, le.key, (SUM(ds, field_49) / totalCount) * 100))),
							58	 => IF(le.include_50, ROW(createRecord('50', le.field_50, le.key, (SUM(ds, field_50) / totalCount) * 100))),
							59	 => IF(le.include_51, ROW(createRecord('51', le.field_51, le.key, (SUM(ds, field_51) / totalCount) * 100))),
							60	 => IF(le.include_52, ROW(createRecord('52', le.field_52, le.key, (SUM(ds, field_52) / totalCount) * 100))),
							61	 => IF(le.include_53, ROW(createRecord('53', le.field_53, le.key, (SUM(ds, field_53) / totalCount) * 100))),
							62	 => IF(le.include_54, ROW(createRecord('54', le.field_54, le.key, (SUM(ds, field_54) / totalCount) * 100))),
							63	 => IF(le.include_55, ROW(createRecord('55', le.field_55, le.key, (SUM(ds, field_55) / totalCount) * 100))),
							64	 => IF(le.include_56, ROW(createRecord('56', le.field_56, le.key, (SUM(ds, field_56) / totalCount) * 100))),
							65	 => IF(le.include_57, ROW(createRecord('57', le.field_57, le.key, (SUM(ds, field_57) / totalCount) * 100))),
							66	 => IF(le.include_64, ROW(createRecord('64', le.field_64, le.key, (SUM(ds, field_64) / totalCount) * 100))),
							67	 => IF(le.include_66, ROW(createRecord('66', le.field_66, le.key, (SUM(ds, field_66) / totalCount) * 100))),
							68	 => IF(le.include_71, ROW(createRecord('71', le.field_71, le.key, (SUM(ds, field_71) / totalCount) * 100))),
							69	 => IF(le.include_72, ROW(createRecord('72', le.field_72, le.key, (SUM(ds, field_72) / totalCount) * 100))),
							70	 => IF(le.include_74, ROW(createRecord('74', le.field_74, le.key, (SUM(ds, field_74) / totalCount) * 100))),
							71	 => IF(le.include_75, ROW(createRecord('75', le.field_75, le.key, (SUM(ds, field_75) / totalCount) * 100))),
							72	 => IF(le.include_76, ROW(createRecord('76', le.field_76, le.key, (SUM(ds, field_76) / totalCount) * 100))),
							73	 => IF(le.include_77, ROW(createRecord('77', le.field_77, le.key, (SUM(ds, field_77) / totalCount) * 100))),
							74	 => IF(le.include_78, ROW(createRecord('78', le.field_78, le.key, (SUM(ds, field_78) / totalCount) * 100))),
							75	 => IF(le.include_79, ROW(createRecord('79', le.field_79, le.key, (SUM(ds, field_79) / totalCount) * 100))),
							76	 => IF(le.include_80, ROW(createRecord('80', le.field_80, le.key, (SUM(ds, field_80) / totalCount) * 100))),
							77	 => IF(le.include_81, ROW(createRecord('81', le.field_81, le.key, (SUM(ds, field_81) / totalCount) * 100))),
							78	 => IF(le.include_82, ROW(createRecord('82', le.field_82, le.key, (SUM(ds, field_82) / totalCount) * 100))),
							79	 => IF(le.include_83, ROW(createRecord('83', le.field_83, le.key, (SUM(ds, field_83) / totalCount) * 100))),
							80	 => IF(le.include_85, ROW(createRecord('85', le.field_85, le.key, (SUM(ds, field_85) / totalCount) * 100))),
							81	 => IF(le.include_89, ROW(createRecord('89', le.field_89, le.key, (SUM(ds, field_89) / totalCount) * 100))),
							82	 => IF(le.include_90, ROW(createRecord('90', le.field_90, le.key, (SUM(ds, field_90) / totalCount) * 100))),
							83	 => IF(le.include_CA, ROW(createRecord('CA', le.field_CA, le.key, (SUM(ds, field_CA) / totalCount) * 100))),
							84	 => IF(le.include_CL, ROW(createRecord('CL', le.field_CL, le.key, (SUM(ds, field_CL) / totalCount) * 100))),
							85	 => IF(le.include_CO, ROW(createRecord('CO', le.field_CO, le.key, (SUM(ds, field_CO) / totalCount) * 100))),
							86	 => IF(le.include_CZ, ROW(createRecord('CZ', le.field_CZ, le.key, (SUM(ds, field_CZ) / totalCount) * 100))),
							87	 => IF(le.include_DD, ROW(createRecord('DD', le.field_DD, le.key, (SUM(ds, field_DD) / totalCount) * 100))),
							88	 => IF(le.include_DF, ROW(createRecord('DF', le.field_DF, le.key, (SUM(ds, field_DF) / totalCount) * 100))),
							89	 => IF(le.include_DI, ROW(createRecord('DI', le.field_DI, le.key, (SUM(ds, field_DI) / totalCount) * 100))),
							90	 => IF(le.include_DM, ROW(createRecord('DM', le.field_DM, le.key, (SUM(ds, field_DM) / totalCount) * 100))),
							91	 => IF(le.include_DV, ROW(createRecord('DV', le.field_DV, le.key, (SUM(ds, field_DV) / totalCount) * 100))),
							92	 => IF(le.include_IS, ROW(createRecord('IS', le.field_IS, le.key, (SUM(ds, field_IS) / totalCount) * 100))),
							93	 => IF(le.include_IT, ROW(createRecord('IT', le.field_IT, le.key, (SUM(ds, field_IT) / totalCount) * 100))),
							94	 => IF(le.include_MI, ROW(createRecord('MI', le.field_MI, le.key, (SUM(ds, field_MI) / totalCount) * 100))),
							95	 => IF(le.include_MO, ROW(createRecord('MO', le.field_MO, le.key, (SUM(ds, field_MO) / totalCount) * 100))),
							96	 => IF(le.include_MS, ROW(createRecord('MS', le.field_MS, le.key, (SUM(ds, field_MS) / totalCount) * 100))),
							97	 => IF(le.include_NB, ROW(createRecord('NB', le.field_NB, le.key, (SUM(ds, field_NB) / totalCount) * 100))),
							98	 => IF(le.include_NF, ROW(createRecord('NF', le.field_NF, le.key, (SUM(ds, field_NF) / totalCount) * 100))),
							99	 => IF(le.include_PA, ROW(createRecord('PA', le.field_PA, le.key, (SUM(ds, field_PA) / totalCount) * 100))),
							100	 => IF(le.include_PO, ROW(createRecord('PO', le.field_PO, le.key, (SUM(ds, field_PO) / totalCount) * 100))),
							101	 => IF(le.include_RS, ROW(createRecord('RS', le.field_RS, le.key, (SUM(ds, field_RS) / totalCount) * 100))),
							102	 => IF(le.include_SD, ROW(createRecord('SD', le.field_SD, le.key, (SUM(ds, field_SD) / totalCount) * 100))),
							103	 => IF(le.include_SR, ROW(createRecord('SR', le.field_SR, le.key, (SUM(ds, field_SR) / totalCount) * 100))),
							104	 => IF(le.include_VA, ROW(createRecord('VA', le.field_VA, le.key, (SUM(ds, field_VA) / totalCount) * 100))),
							105	 => IF(le.include_WL, ROW(createRecord('WL', le.field_WL, le.key, (SUM(ds, field_WL) / totalCount) * 100))),
							106	 => IF(le.include_ZI, ROW(createRecord('ZI', le.field_ZI, le.key, (SUM(ds, field_ZI) / totalCount) * 100))),

							107	=> ROW(createRecord(NUMBER_OF_CASES, le.total, le.key, totalCount)),
							108	=> ROW(createRecord(PERCENT_OF_TOTOAL, le.total_percent, le.key, (totalCount / totalCount) * 100)),
											ROW(createRecord(INVALID,	0, '', 0)));
				END;	
				
				//Add two to the possible search codes to account for number of cases and percent of total - these should always be the last two values
				transformLayout :=  SORT(NORMALIZE(summary, NUM_POSS_SEARCHED_CODES + 2, intoFinalLayout(LEFT, COUNTER)), code_searched);
				rollInfo := ROLLUP(transformLayout, LEFT.code_searched = RIGHT.code_searched, finalRoll(LEFT, RIGHT));
				populatedValues := rollInfo(code_searched <> '');
															
				return populatedValues;
		END;






		
/* **************************************************************
 *      BIID Search Results - Business Verification Index       *
 ****************************************************************/
		BusVerIndex_Counts := SORT(TABLE(biidInputRecords, 
				{bvi, 
					UNSIGNED total := COUNT(GROUP),
					REAL total_Percent := (COUNT(GROUP) / totalNumberOfRecords) * 100	
				}, bvi
			), bvi); 
			
				
				Final_Layout insertRows(BusVerIndex_Counts le, INTEGER cnt) := TRANSFORM
					SELF := CASE(cnt, 
							1	=> ROW(createRecord(NUMBER_OF_CASES, le.total, le.bvi, 0)),
							2	=> ROW(createRecord(PERCENT_OF_TOTOAL, le.total_percent, le.bvi, 0)),
											ROW(createRecord(INVALID,	0, '', 0)));
				END;
				
				Final_Layout addEmUp(Final_Layout le, Final_Layout ri) := TRANSFORM
					SELF.cvi_00 := le.cvi_00 + ri.cvi_00;
					SELF.cvi_10 := le.cvi_10 + ri.cvi_10;
					SELF.cvi_20 := le.cvi_20 + ri.cvi_20;
					SELF.cvi_30 := le.cvi_30 + ri.cvi_30;
					SELF.cvi_40 := le.cvi_40 + ri.cvi_40;
					SELF.cvi_50 := le.cvi_50 + ri.cvi_50;
					SELF.all :=  SUM(SELF.cvi_00 + SELF.cvi_10 + SELF.cvi_20 + SELF.cvi_30 + SELF.cvi_40 + SELF.cvi_50);
					SELF := le;
				END;
				
				sortedInfo := SORT(NORMALIZE(BusVerIndex_Counts, 2, insertRows(LEFT, COUNTER)), code_searched);
				BusVerIndex_Summary := ROLLUP(sortedInfo, LEFT.code_searched = RIGHT.code_searched, addEmUp(LEFT, RIGHT));


		
/* **************************************************************
 *       BIID Search Results - Business to Executive Link        *
 ****************************************************************/
		Bus2Exec_Counts := TABLE(biidInputRecords, 
				{bvi, 
					UNSIGNED total := 0;
					REAL total_percent := 0;
					REAL field_0 := (COUNT(GROUP, bus2exec_index_rep1 = '0')),
					REAL field_10 := (COUNT(GROUP, bus2exec_index_rep1 = '10')),
					REAL field_20 := (COUNT(GROUP, bus2exec_index_rep1 = '20')),
					REAL field_30 := (COUNT(GROUP, bus2exec_index_rep1 = '30')),
					REAL field_40 := (COUNT(GROUP, bus2exec_index_rep1 = '40')),
					REAL field_50 := (COUNT(GROUP, bus2exec_index_rep1 = '50'))
				}, bvi
			);
					
		Trans_Bus2Exec_Counts := PROJECT(Bus2Exec_Counts, TRANSFORM(Generic_Layout,
																																	SELF.key := LEFT.bvi;
																																	SELF.include_0 := TRUE;
																																	SELF.include_10 := TRUE;
																																	SELF.include_20 := TRUE;
																																	SELF.include_30 := TRUE;
																																	SELF.include_40 := TRUE;
																																	SELF.include_50 := TRUE;
																																	SELF := LEFT;
																																	SELF := [];));
		
		Bus2Exec_Detailed_Summary := calcResults(Trans_Bus2Exec_Counts);
		

		
/* **************************************************************
 *     BIID Search Results - Residential Business Indicator     *
 ****************************************************************/			
		ResBus_Indicator_Counts := TABLE(biidInputRecords, 
				{bvi, 	
					UNSIGNED total := 0;
					REAL total_percent := 0;
					REAL field_0 := (COUNT(GROUP, residential_bus_indicator = '0')),
					REAL field_10 := (COUNT(GROUP, residential_bus_indicator = '1')),
					REAL field_20 := (COUNT(GROUP, residential_bus_indicator = '2'))		
				}, bvi
			);
		
		Trans_ResBus_Indicator_Counts := PROJECT(ResBus_Indicator_Counts, TRANSFORM(Generic_Layout,
																																									SELF.key := LEFT.bvi;
																																									SELF.include_0 := TRUE;
																																									SELF.include_10 := TRUE;
																																									SELF.include_20 := TRUE;
																																									SELF := LEFT;
																																									SELF := [];));
		
		ResBus_Indicator_Detailed_Summary := calcResults(Trans_ResBus_Indicator_Counts);
		

		
/* **************************************
 *         BIID Risk Indicators         *
 ****************************************/				
		Risk_Indicators_Counts := TABLE(biidInputRecords, 
				{bvi, 
					UNSIGNED total:= 0;
					REAL total_percent := 0;
					REAL field_10 := (COUNT(GROUP,	bus_ri_1 = '10' OR	bus_ri_2 = '10' OR	bus_ri_3 = '10' OR	bus_ri_4 = '10' OR	bus_ri_5 = '10' OR	bus_ri_6 = '10' OR	bus_ri_7 = '10' OR	bus_ri_8 = '10')),
					REAL field_11 := (COUNT(GROUP,	bus_ri_1 = '11' OR	bus_ri_2 = '11' OR	bus_ri_3 = '11' OR	bus_ri_4 = '11' OR	bus_ri_5 = '11' OR	bus_ri_6 = '11' OR	bus_ri_7 = '11' OR	bus_ri_8 = '11')),
					REAL field_12 := (COUNT(GROUP,	bus_ri_1 = '12' OR	bus_ri_2 = '12' OR	bus_ri_3 = '12' OR	bus_ri_4 = '12' OR	bus_ri_5 = '12' OR	bus_ri_6 = '12' OR	bus_ri_7 = '12' OR	bus_ri_8 = '12')),
					REAL field_13 := (COUNT(GROUP,	bus_ri_1 = '13' OR	bus_ri_2 = '13' OR	bus_ri_3 = '13' OR	bus_ri_4 = '13' OR	bus_ri_5 = '13' OR	bus_ri_6 = '13' OR	bus_ri_7 = '13' OR	bus_ri_8 = '13')),
					REAL field_14 := (COUNT(GROUP,	bus_ri_1 = '14' OR	bus_ri_2 = '14' OR	bus_ri_3 = '14' OR	bus_ri_4 = '14' OR	bus_ri_5 = '14' OR	bus_ri_6 = '14' OR	bus_ri_7 = '14' OR	bus_ri_8 = '14')),
					REAL field_15 := (COUNT(GROUP,	bus_ri_1 = '15' OR	bus_ri_2 = '15' OR	bus_ri_3 = '15' OR	bus_ri_4 = '15' OR	bus_ri_5 = '15' OR	bus_ri_6 = '15' OR	bus_ri_7 = '15' OR	bus_ri_8 = '15')),
					REAL field_16 := (COUNT(GROUP,	bus_ri_1 = '16' OR	bus_ri_2 = '16' OR	bus_ri_3 = '16' OR	bus_ri_4 = '16' OR	bus_ri_5 = '16' OR	bus_ri_6 = '16' OR	bus_ri_7 = '16' OR	bus_ri_8 = '16')),
					REAL field_17 := (COUNT(GROUP,	bus_ri_1 = '17' OR	bus_ri_2 = '17' OR	bus_ri_3 = '17' OR	bus_ri_4 = '17' OR	bus_ri_5 = '17' OR	bus_ri_6 = '17' OR	bus_ri_7 = '17' OR	bus_ri_8 = '17')),
					REAL field_18 := (COUNT(GROUP,	bus_ri_1 = '18' OR	bus_ri_2 = '18' OR	bus_ri_3 = '18' OR	bus_ri_4 = '18' OR	bus_ri_5 = '18' OR	bus_ri_6 = '18' OR	bus_ri_7 = '18' OR	bus_ri_8 = '18')),
					REAL field_19 := (COUNT(GROUP,	bus_ri_1 = '19' OR	bus_ri_2 = '19' OR	bus_ri_3 = '19' OR	bus_ri_4 = '19' OR	bus_ri_5 = '19' OR	bus_ri_6 = '19' OR	bus_ri_7 = '19' OR	bus_ri_8 = '19')),
					REAL field_20 := (COUNT(GROUP,	bus_ri_1 = '20' OR	bus_ri_2 = '20' OR	bus_ri_3 = '20' OR	bus_ri_4 = '20' OR	bus_ri_5 = '20' OR	bus_ri_6 = '20' OR	bus_ri_7 = '20' OR	bus_ri_8 = '20')),
					REAL field_21 := (COUNT(GROUP,	bus_ri_1 = '21' OR	bus_ri_2 = '21' OR	bus_ri_3 = '21' OR	bus_ri_4 = '21' OR	bus_ri_5 = '21' OR	bus_ri_6 = '21' OR	bus_ri_7 = '21' OR	bus_ri_8 = '21')),
					REAL field_22 := (COUNT(GROUP,	bus_ri_1 = '22' OR	bus_ri_2 = '22' OR	bus_ri_3 = '22' OR	bus_ri_4 = '22' OR	bus_ri_5 = '22' OR	bus_ri_6 = '22' OR	bus_ri_7 = '22' OR	bus_ri_8 = '22')),
					REAL field_23 := (COUNT(GROUP,	bus_ri_1 = '23' OR	bus_ri_2 = '23' OR	bus_ri_3 = '23' OR	bus_ri_4 = '23' OR	bus_ri_5 = '23' OR	bus_ri_6 = '23' OR	bus_ri_7 = '23' OR	bus_ri_8 = '23')),
					REAL field_24 := (COUNT(GROUP,	bus_ri_1 = '24' OR	bus_ri_2 = '24' OR	bus_ri_3 = '24' OR	bus_ri_4 = '24' OR	bus_ri_5 = '24' OR	bus_ri_6 = '24' OR	bus_ri_7 = '24' OR	bus_ri_8 = '24')),
					REAL field_25 := (COUNT(GROUP,	bus_ri_1 = '25' OR	bus_ri_2 = '25' OR	bus_ri_3 = '25' OR	bus_ri_4 = '25' OR	bus_ri_5 = '25' OR	bus_ri_6 = '25' OR	bus_ri_7 = '25' OR	bus_ri_8 = '25')),
					REAL field_26 := (COUNT(GROUP,	bus_ri_1 = '26' OR	bus_ri_2 = '26' OR	bus_ri_3 = '26' OR	bus_ri_4 = '26' OR	bus_ri_5 = '26' OR	bus_ri_6 = '26' OR	bus_ri_7 = '26' OR	bus_ri_8 = '26')),
					REAL field_27 := (COUNT(GROUP,	bus_ri_1 = '27' OR	bus_ri_2 = '27' OR	bus_ri_3 = '27' OR	bus_ri_4 = '27' OR	bus_ri_5 = '27' OR	bus_ri_6 = '27' OR	bus_ri_7 = '27' OR	bus_ri_8 = '27')),
					REAL field_28 := (COUNT(GROUP,	bus_ri_1 = '28' OR	bus_ri_2 = '28' OR	bus_ri_3 = '28' OR	bus_ri_4 = '28' OR	bus_ri_5 = '28' OR	bus_ri_6 = '28' OR	bus_ri_7 = '28' OR	bus_ri_8 = '28')),
					REAL field_29 := (COUNT(GROUP,	bus_ri_1 = '29' OR	bus_ri_2 = '29' OR	bus_ri_3 = '29' OR	bus_ri_4 = '29' OR	bus_ri_5 = '29' OR	bus_ri_6 = '29' OR	bus_ri_7 = '29' OR	bus_ri_8 = '29')),
					REAL field_30 := (COUNT(GROUP,	bus_ri_1 = '30' OR	bus_ri_2 = '30' OR	bus_ri_3 = '30' OR	bus_ri_4 = '30' OR	bus_ri_5 = '30' OR	bus_ri_6 = '30' OR	bus_ri_7 = '30' OR	bus_ri_8 = '30')),
					REAL field_31 := (COUNT(GROUP,	bus_ri_1 = '31' OR	bus_ri_2 = '31' OR	bus_ri_3 = '31' OR	bus_ri_4 = '31' OR	bus_ri_5 = '31' OR	bus_ri_6 = '31' OR	bus_ri_7 = '31' OR	bus_ri_8 = '31')),
					REAL field_32 := (COUNT(GROUP,	bus_ri_1 = '32' OR	bus_ri_2 = '32' OR	bus_ri_3 = '32' OR	bus_ri_4 = '32' OR	bus_ri_5 = '32' OR	bus_ri_6 = '32' OR	bus_ri_7 = '32' OR	bus_ri_8 = '32')),
					REAL field_33 := (COUNT(GROUP,	bus_ri_1 = '33' OR	bus_ri_2 = '33' OR	bus_ri_3 = '33' OR	bus_ri_4 = '33' OR	bus_ri_5 = '33' OR	bus_ri_6 = '33' OR	bus_ri_7 = '33' OR	bus_ri_8 = '33')),
					REAL field_34 := (COUNT(GROUP,	bus_ri_1 = '34' OR	bus_ri_2 = '34' OR	bus_ri_3 = '34' OR	bus_ri_4 = '34' OR	bus_ri_5 = '34' OR	bus_ri_6 = '34' OR	bus_ri_7 = '34' OR	bus_ri_8 = '34')),
					REAL field_35 := (COUNT(GROUP,	bus_ri_1 = '35' OR	bus_ri_2 = '35' OR	bus_ri_3 = '35' OR	bus_ri_4 = '35' OR	bus_ri_5 = '35' OR	bus_ri_6 = '35' OR	bus_ri_7 = '35' OR	bus_ri_8 = '35')),
					REAL field_36 := (COUNT(GROUP,	bus_ri_1 = '36' OR	bus_ri_2 = '36' OR	bus_ri_3 = '36' OR	bus_ri_4 = '36' OR	bus_ri_5 = '36' OR	bus_ri_6 = '36' OR	bus_ri_7 = '36' OR	bus_ri_8 = '36')),
					REAL field_37 := (COUNT(GROUP,	bus_ri_1 = '37' OR	bus_ri_2 = '37' OR	bus_ri_3 = '37' OR	bus_ri_4 = '37' OR	bus_ri_5 = '37' OR	bus_ri_6 = '37' OR	bus_ri_7 = '37' OR	bus_ri_8 = '37')),
					REAL field_38 := (COUNT(GROUP,	bus_ri_1 = '38' OR	bus_ri_2 = '38' OR	bus_ri_3 = '38' OR	bus_ri_4 = '38' OR	bus_ri_5 = '38' OR	bus_ri_6 = '38' OR	bus_ri_7 = '38' OR	bus_ri_8 = '38')),
					REAL field_39 := (COUNT(GROUP,	bus_ri_1 = '39' OR	bus_ri_2 = '39' OR	bus_ri_3 = '39' OR	bus_ri_4 = '39' OR	bus_ri_5 = '39' OR	bus_ri_6 = '39' OR	bus_ri_7 = '39' OR	bus_ri_8 = '39')),
					REAL field_40 := (COUNT(GROUP,	bus_ri_1 = '40' OR	bus_ri_2 = '40' OR	bus_ri_3 = '40' OR	bus_ri_4 = '40' OR	bus_ri_5 = '40' OR	bus_ri_6 = '40' OR	bus_ri_7 = '40' OR	bus_ri_8 = '40')),
					REAL field_41 := (COUNT(GROUP,	bus_ri_1 = '41' OR	bus_ri_2 = '41' OR	bus_ri_3 = '41' OR	bus_ri_4 = '41' OR	bus_ri_5 = '41' OR	bus_ri_6 = '41' OR	bus_ri_7 = '41' OR	bus_ri_8 = '41')),
					REAL field_42 := (COUNT(GROUP,	bus_ri_1 = '42' OR	bus_ri_2 = '42' OR	bus_ri_3 = '42' OR	bus_ri_4 = '42' OR	bus_ri_5 = '42' OR	bus_ri_6 = '42' OR	bus_ri_7 = '42' OR	bus_ri_8 = '42')),
					REAL field_43 := (COUNT(GROUP,	bus_ri_1 = '43' OR	bus_ri_2 = '43' OR	bus_ri_3 = '43' OR	bus_ri_4 = '43' OR	bus_ri_5 = '43' OR	bus_ri_6 = '43' OR	bus_ri_7 = '43' OR	bus_ri_8 = '43')),
					REAL field_44 := (COUNT(GROUP,	bus_ri_1 = '44' OR	bus_ri_2 = '44' OR	bus_ri_3 = '44' OR	bus_ri_4 = '44' OR	bus_ri_5 = '44' OR	bus_ri_6 = '44' OR	bus_ri_7 = '44' OR	bus_ri_8 = '44')),
					REAL field_45 := (COUNT(GROUP,	bus_ri_1 = '45' OR	bus_ri_2 = '45' OR	bus_ri_3 = '45' OR	bus_ri_4 = '45' OR	bus_ri_5 = '45' OR	bus_ri_6 = '45' OR	bus_ri_7 = '45' OR	bus_ri_8 = '45')),
					REAL field_46 := (COUNT(GROUP,	bus_ri_1 = '46' OR	bus_ri_2 = '46' OR	bus_ri_3 = '46' OR	bus_ri_4 = '46' OR	bus_ri_5 = '46' OR	bus_ri_6 = '46' OR	bus_ri_7 = '46' OR	bus_ri_8 = '46')),
					REAL field_47 := (COUNT(GROUP,	bus_ri_1 = '47' OR	bus_ri_2 = '47' OR	bus_ri_3 = '47' OR	bus_ri_4 = '47' OR	bus_ri_5 = '47' OR	bus_ri_6 = '47' OR	bus_ri_7 = '47' OR	bus_ri_8 = '47')),
					REAL field_48 := (COUNT(GROUP,	bus_ri_1 = '48' OR	bus_ri_2 = '48' OR	bus_ri_3 = '48' OR	bus_ri_4 = '48' OR	bus_ri_5 = '48' OR	bus_ri_6 = '48' OR	bus_ri_7 = '48' OR	bus_ri_8 = '48')),
					REAL field_49 := (COUNT(GROUP,	bus_ri_1 = '49' OR	bus_ri_2 = '49' OR	bus_ri_3 = '49' OR	bus_ri_4 = '49' OR	bus_ri_5 = '49' OR	bus_ri_6 = '49' OR	bus_ri_7 = '49' OR	bus_ri_8 = '49')),
					REAL field_50 := (COUNT(GROUP,	bus_ri_1 = '50' OR	bus_ri_2 = '50' OR	bus_ri_3 = '50' OR	bus_ri_4 = '50' OR	bus_ri_5 = '50' OR	bus_ri_6 = '50' OR	bus_ri_7 = '50' OR	bus_ri_8 = '50')),
					REAL field_51 := (COUNT(GROUP,	bus_ri_1 = '51' OR	bus_ri_2 = '51' OR	bus_ri_3 = '51' OR	bus_ri_4 = '51' OR	bus_ri_5 = '51' OR	bus_ri_6 = '51' OR	bus_ri_7 = '51' OR	bus_ri_8 = '51')),
					REAL field_52 := (COUNT(GROUP,	bus_ri_1 = '52' OR	bus_ri_2 = '52' OR	bus_ri_3 = '52' OR	bus_ri_4 = '52' OR	bus_ri_5 = '52' OR	bus_ri_6 = '52' OR	bus_ri_7 = '52' OR	bus_ri_8 = '52')),
					REAL field_53 := (COUNT(GROUP,	bus_ri_1 = '53' OR	bus_ri_2 = '53' OR	bus_ri_3 = '53' OR	bus_ri_4 = '53' OR	bus_ri_5 = '53' OR	bus_ri_6 = '53' OR	bus_ri_7 = '53' OR	bus_ri_8 = '53')),
					REAL field_54 := (COUNT(GROUP,	bus_ri_1 = '54' OR	bus_ri_2 = '54' OR	bus_ri_3 = '54' OR	bus_ri_4 = '54' OR	bus_ri_5 = '54' OR	bus_ri_6 = '54' OR	bus_ri_7 = '54' OR	bus_ri_8 = '54')),				
				}, bvi
			);
			
		Trans_Risk_Indicators_Counts := PROJECT(Risk_Indicators_Counts, TRANSFORM(Generic_Layout,
																																								SELF.key := LEFT.bvi;
																																								SELF.include_10 := TRUE;
																																								SELF.include_11 := TRUE;
																																								SELF.include_12 := TRUE;
																																								SELF.include_13 := TRUE;
																																								SELF.include_14 := TRUE;
																																								SELF.include_15 := TRUE;
																																								SELF.include_16 := TRUE;
																																								SELF.include_17 := TRUE;
																																								SELF.include_18 := TRUE;
																																								SELF.include_19 := TRUE;
																																								SELF.include_20 := TRUE;
																																								SELF.include_21 := TRUE;
																																								SELF.include_22 := TRUE;
																																								SELF.include_23 := TRUE;
																																								SELF.include_24 := TRUE;
																																								SELF.include_25 := TRUE;
																																								SELF.include_26 := TRUE;
																																								SELF.include_27 := TRUE;
																																								SELF.include_28 := TRUE;
																																								SELF.include_29 := TRUE;
																																								SELF.include_30 := TRUE;
																																								SELF.include_31 := TRUE;
																																								SELF.include_32 := TRUE;
																																								SELF.include_33 := TRUE;
																																								SELF.include_34 := TRUE;
																																								SELF.include_35 := TRUE;
																																								SELF.include_36 := TRUE;
																																								SELF.include_37 := TRUE;
																																								SELF.include_38 := TRUE;
																																								SELF.include_39 := TRUE;
																																								SELF.include_40 := TRUE;
																																								SELF.include_41 := TRUE;
																																								SELF.include_42 := TRUE;
																																								SELF.include_43 := TRUE;
																																								SELF.include_44 := TRUE;
																																								SELF.include_45 := TRUE;
																																								SELF.include_46 := TRUE;
																																								SELF.include_47 := TRUE;
																																								SELF.include_48 := TRUE;
																																								SELF.include_49 := TRUE;
																																								SELF.include_50 := TRUE;
																																								SELF.include_51 := TRUE;
																																								SELF.include_52 := TRUE;
																																								SELF.include_53 := TRUE;
																																								SELF.include_54 := TRUE;
																																								SELF := LEFT;
																																								SELF := [];));
		
		Risk_Indicators_Detailed_Summary := calcResults(Trans_Risk_Indicators_Counts);

		

		
/* **************************************************************
 *        Auth. Rep. Search Results - Authorized Rep NAS        *
 ****************************************************************/	
		Auth_Rep_NAS_Counts := TABLE(biidInputRecords, 
				{rep1_cvi,
					UNSIGNED total := 0;
					REAL total_percent := 0;
					REAL field_0 := (COUNT(GROUP, rep1_nas_summary = '0')),
					REAL field_1 := (COUNT(GROUP, rep1_nas_summary = '1')),
					REAL field_2 := (COUNT(GROUP, rep1_nas_summary = '2')),
					REAL field_3 := (COUNT(GROUP, rep1_nas_summary = '3')),
					REAL field_4 := (COUNT(GROUP, rep1_nas_summary = '4')),
					REAL field_5 := (COUNT(GROUP, rep1_nas_summary = '5')),
					REAL field_6 := (COUNT(GROUP, rep1_nas_summary = '6')),
					REAL field_7 := (COUNT(GROUP, rep1_nas_summary = '7')),
					REAL field_8 := (COUNT(GROUP, rep1_nas_summary = '8')),
					REAL field_9 := (COUNT(GROUP, rep1_nas_summary = '9')),
					REAL field_10 := (COUNT(GROUP, rep1_nas_summary = '10')),
					REAL field_11 := (COUNT(GROUP, rep1_nas_summary = '11')),
					REAL field_12 := (COUNT(GROUP, rep1_nas_summary = '12'))				
				}, rep1_cvi
			);
			
		Trans_Auth_Rep_NAS_Counts := PROJECT(Auth_Rep_NAS_Counts, TRANSFORM(Generic_Layout,
																																					SELF.key := LEFT.rep1_cvi;
																																					SELF.include_0 := TRUE;
																																					SELF.include_1 := TRUE;
																																					SELF.include_2 := TRUE;
																																					SELF.include_3 := TRUE;
																																					SELF.include_4 := TRUE;
																																					SELF.include_5 := TRUE;
																																					SELF.include_6 := TRUE;
																																					SELF.include_7 := TRUE;
																																					SELF.include_8 := TRUE;
																																					SELF.include_9 := TRUE;
																																					SELF.include_10 := TRUE;
																																					SELF.include_11 := TRUE;
																																					SELF.include_12 := TRUE;
																																					SELF := LEFT;
																																					SELF := [];));
		
		Auth_Rep_NAS_Detailed_Summary := calcResults(Trans_Auth_Rep_NAS_Counts);

		

		
/* **************************************************************
 *        Auth. Rep. Search Results - Authorized Rep NAP        *
 ****************************************************************/				
		Auth_Rep_NAP_Counts := TABLE(biidInputRecords, 
				{rep1_cvi,
					UNSIGNED total := 0;
					REAL total_percent := 0;
					REAL field_0 := (COUNT(GROUP, rep1_nap_summary = '0')), 
					REAL field_1 := (COUNT(GROUP, rep1_nap_summary = '1')),
					REAL field_2 := (COUNT(GROUP, rep1_nap_summary = '2')), 
					REAL field_3 := (COUNT(GROUP, rep1_nap_summary = '3')), 
					REAL field_4 := (COUNT(GROUP, rep1_nap_summary = '4')), 
					REAL field_5 := (COUNT(GROUP, rep1_nap_summary = '5')), 
					REAL field_6 := (COUNT(GROUP, rep1_nap_summary = '6')), 
					REAL field_7 := (COUNT(GROUP, rep1_nap_summary = '7')), 
					REAL field_8 := (COUNT(GROUP, rep1_nap_summary = '8')), 
					REAL field_9 := (COUNT(GROUP, rep1_nap_summary = '9')), 
					REAL field_10 := (COUNT(GROUP, rep1_nap_summary = '10')), 
					REAL field_11 := (COUNT(GROUP, rep1_nap_summary = '11')), 
					REAL field_12 := (COUNT(GROUP, rep1_nap_summary = '12')) 					
				}, rep1_cvi
			);
			
		Trans_Auth_Rep_NAP_Counts := PROJECT(Auth_Rep_NAP_Counts, TRANSFORM(Generic_Layout,
																																					SELF.key := LEFT.rep1_cvi;
																																					SELF.include_0 := TRUE;
																																					SELF.include_1 := TRUE;
																																					SELF.include_2 := TRUE;
																																					SELF.include_3 := TRUE;
																																					SELF.include_4 := TRUE;
																																					SELF.include_5 := TRUE;
																																					SELF.include_6 := TRUE;
																																					SELF.include_7 := TRUE;
																																					SELF.include_8 := TRUE;
																																					SELF.include_9 := TRUE;
																																					SELF.include_10 := TRUE;
																																					SELF.include_11 := TRUE;
																																					SELF.include_12 := TRUE;
																																					SELF := LEFT;
																																					SELF := [];));
		
		Auth_Rep_NAP_Detailed_Summary := calcResults(Trans_Auth_Rep_NAP_Counts);

		

		
/* **************************************************************
 *    Auth. Rep. Search Results - Business to Executive Link    *
 ****************************************************************/						
		Auth_Rep_Bus2Exec_Counts := TABLE(biidInputRecords, 
				{rep1_cvi, 
					UNSIGNED total := COUNT(GROUP),
					REAL total_Percent := (COUNT(GROUP) / totalNumberOfRecords) * 100,							
					REAL field_0 := (COUNT(GROUP, bus2exec_index_rep1 = '0' )),
					REAL field_10 := (COUNT(GROUP, bus2exec_index_rep1 = '10')),
					REAL field_20 := (COUNT(GROUP, bus2exec_index_rep1 = '20')),
					REAL field_30 := (COUNT(GROUP, bus2exec_index_rep1 = '30')),
					REAL field_40 := (COUNT(GROUP, bus2exec_index_rep1 = '40')),
					REAL field_50 := (COUNT(GROUP, bus2exec_index_rep1 = '50'))		
				}, rep1_cvi
			);
			
		Trans_Auth_Rep_Bus2Exec_Counts := PROJECT(Auth_Rep_Bus2Exec_Counts, TRANSFORM(Generic_Layout,
																																										SELF.key := LEFT.rep1_cvi;
																																										SELF.include_0 := TRUE;
																																										SELF.include_10 := TRUE;
																																										SELF.include_20 := TRUE;
																																										SELF.include_30 := TRUE;
																																										SELF.include_40 := TRUE;
																																										SELF.include_50 := TRUE;
																																										SELF := LEFT;
																																										SELF := [];));
		
		Auth_Rep_Bus2Exec_Detailed_Summary := calcResults(Trans_Auth_Rep_Bus2Exec_Counts);

		

		
/* **************************************
 *      Auth. Rep. Risk Indicators      *
 ****************************************/			
		Auth_Rep_Risk_Indicators_Counts := TABLE(biidInputRecords, 
				{rep1_cvi, 
					UNSIGNED total := 0;
					REAL total_percent := 0;
					REAL field_02 := (COUNT(GROUP, rep1_hri_1 = '02' OR rep1_hri_2 = '02' OR rep1_hri_3 = '02' OR rep1_hri_4 = '02' OR rep1_hri_5 = '02' OR rep1_hri_6 = '02' OR rep1_hri_7 = '02' OR rep1_hri_8 = '02')),
					REAL field_03 := (COUNT(GROUP, rep1_hri_1 = '03' OR rep1_hri_2 = '03' OR rep1_hri_3 = '03' OR rep1_hri_4 = '03' OR rep1_hri_5 = '03' OR rep1_hri_6 = '03' OR rep1_hri_7 = '03' OR rep1_hri_8 = '03')),
					REAL field_04 := (COUNT(GROUP, rep1_hri_1 = '04' OR rep1_hri_2 = '04' OR rep1_hri_3 = '04' OR rep1_hri_4 = '04' OR rep1_hri_5 = '04' OR rep1_hri_6 = '04' OR rep1_hri_7 = '04' OR rep1_hri_8 = '04')),
					REAL field_06 := (COUNT(GROUP, rep1_hri_1 = '06' OR rep1_hri_2 = '06' OR rep1_hri_3 = '06' OR rep1_hri_4 = '06' OR rep1_hri_5 = '06' OR rep1_hri_6 = '06' OR rep1_hri_7 = '06' OR rep1_hri_8 = '06')),
					REAL field_07 := (COUNT(GROUP, rep1_hri_1 = '07' OR rep1_hri_2 = '07' OR rep1_hri_3 = '07' OR rep1_hri_4 = '07' OR rep1_hri_5 = '07' OR rep1_hri_6 = '07' OR rep1_hri_7 = '07' OR rep1_hri_8 = '07')),
					REAL field_08 := (COUNT(GROUP, rep1_hri_1 = '08' OR rep1_hri_2 = '08' OR rep1_hri_3 = '08' OR rep1_hri_4 = '08' OR rep1_hri_5 = '08' OR rep1_hri_6 = '08' OR rep1_hri_7 = '08' OR rep1_hri_8 = '08')),
					REAL field_09 := (COUNT(GROUP, rep1_hri_1 = '09' OR rep1_hri_2 = '09' OR rep1_hri_3 = '09' OR rep1_hri_4 = '09' OR rep1_hri_5 = '09' OR rep1_hri_6 = '09' OR rep1_hri_7 = '09' OR rep1_hri_8 = '09')),
					REAL field_10 := (COUNT(GROUP, rep1_hri_1 = '10' OR rep1_hri_2 = '10' OR rep1_hri_3 = '10' OR rep1_hri_4 = '10' OR rep1_hri_5 = '10' OR rep1_hri_6 = '10' OR rep1_hri_7 = '10' OR rep1_hri_8 = '10')),
					REAL field_11 := (COUNT(GROUP, rep1_hri_1 = '11' OR rep1_hri_2 = '11' OR rep1_hri_3 = '11' OR rep1_hri_4 = '11' OR rep1_hri_5 = '11' OR rep1_hri_6 = '11' OR rep1_hri_7 = '11' OR rep1_hri_8 = '11')),
					REAL field_12 := (COUNT(GROUP, rep1_hri_1 = '12' OR rep1_hri_2 = '12' OR rep1_hri_3 = '12' OR rep1_hri_4 = '12' OR rep1_hri_5 = '12' OR rep1_hri_6 = '12' OR rep1_hri_7 = '12' OR rep1_hri_8 = '12')),
					REAL field_14 := (COUNT(GROUP, rep1_hri_1 = '14' OR rep1_hri_2 = '14' OR rep1_hri_3 = '14' OR rep1_hri_4 = '14' OR rep1_hri_5 = '14' OR rep1_hri_6 = '14' OR rep1_hri_7 = '14' OR rep1_hri_8 = '14')),
					REAL field_15 := (COUNT(GROUP, rep1_hri_1 = '15' OR rep1_hri_2 = '15' OR rep1_hri_3 = '15' OR rep1_hri_4 = '15' OR rep1_hri_5 = '15' OR rep1_hri_6 = '15' OR rep1_hri_7 = '15' OR rep1_hri_8 = '15')),
					REAL field_16 := (COUNT(GROUP, rep1_hri_1 = '16' OR rep1_hri_2 = '16' OR rep1_hri_3 = '16' OR rep1_hri_4 = '16' OR rep1_hri_5 = '16' OR rep1_hri_6 = '16' OR rep1_hri_7 = '16' OR rep1_hri_8 = '16')),
					REAL field_19 := (COUNT(GROUP, rep1_hri_1 = '19' OR rep1_hri_2 = '19' OR rep1_hri_3 = '19' OR rep1_hri_4 = '19' OR rep1_hri_5 = '19' OR rep1_hri_6 = '19' OR rep1_hri_7 = '19' OR rep1_hri_8 = '19')),
					REAL field_25 := (COUNT(GROUP, rep1_hri_1 = '25' OR rep1_hri_2 = '25' OR rep1_hri_3 = '25' OR rep1_hri_4 = '25' OR rep1_hri_5 = '25' OR rep1_hri_6 = '25' OR rep1_hri_7 = '25' OR rep1_hri_8 = '25')),
					REAL field_26 := (COUNT(GROUP, rep1_hri_1 = '26' OR rep1_hri_2 = '26' OR rep1_hri_3 = '26' OR rep1_hri_4 = '26' OR rep1_hri_5 = '26' OR rep1_hri_6 = '26' OR rep1_hri_7 = '26' OR rep1_hri_8 = '26')),
					REAL field_27 := (COUNT(GROUP, rep1_hri_1 = '27' OR rep1_hri_2 = '27' OR rep1_hri_3 = '27' OR rep1_hri_4 = '27' OR rep1_hri_5 = '27' OR rep1_hri_6 = '27' OR rep1_hri_7 = '27' OR rep1_hri_8 = '27')),
					REAL field_28 := (COUNT(GROUP, rep1_hri_1 = '28' OR rep1_hri_2 = '28' OR rep1_hri_3 = '28' OR rep1_hri_4 = '28' OR rep1_hri_5 = '28' OR rep1_hri_6 = '28' OR rep1_hri_7 = '28' OR rep1_hri_8 = '28')),
					REAL field_29 := (COUNT(GROUP, rep1_hri_1 = '29' OR rep1_hri_2 = '29' OR rep1_hri_3 = '29' OR rep1_hri_4 = '29' OR rep1_hri_5 = '29' OR rep1_hri_6 = '29' OR rep1_hri_7 = '29' OR rep1_hri_8 = '29')),
					REAL field_30 := (COUNT(GROUP, rep1_hri_1 = '30' OR rep1_hri_2 = '30' OR rep1_hri_3 = '30' OR rep1_hri_4 = '30' OR rep1_hri_5 = '30' OR rep1_hri_6 = '30' OR rep1_hri_7 = '30' OR rep1_hri_8 = '30')),
					REAL field_31 := (COUNT(GROUP, rep1_hri_1 = '31' OR rep1_hri_2 = '31' OR rep1_hri_3 = '31' OR rep1_hri_4 = '31' OR rep1_hri_5 = '31' OR rep1_hri_6 = '31' OR rep1_hri_7 = '31' OR rep1_hri_8 = '31')),
					REAL field_32 := (COUNT(GROUP, rep1_hri_1 = '32' OR rep1_hri_2 = '32' OR rep1_hri_3 = '32' OR rep1_hri_4 = '32' OR rep1_hri_5 = '32' OR rep1_hri_6 = '32' OR rep1_hri_7 = '32' OR rep1_hri_8 = '32')),
					REAL field_37 := (COUNT(GROUP, rep1_hri_1 = '37' OR rep1_hri_2 = '37' OR rep1_hri_3 = '37' OR rep1_hri_4 = '37' OR rep1_hri_5 = '37' OR rep1_hri_6 = '37' OR rep1_hri_7 = '37' OR rep1_hri_8 = '37')),
					REAL field_38 := (COUNT(GROUP, rep1_hri_1 = '38' OR rep1_hri_2 = '38' OR rep1_hri_3 = '38' OR rep1_hri_4 = '38' OR rep1_hri_5 = '38' OR rep1_hri_6 = '38' OR rep1_hri_7 = '38' OR rep1_hri_8 = '38')),
					REAL field_39 := (COUNT(GROUP, rep1_hri_1 = '39' OR rep1_hri_2 = '39' OR rep1_hri_3 = '39' OR rep1_hri_4 = '39' OR rep1_hri_5 = '39' OR rep1_hri_6 = '39' OR rep1_hri_7 = '39' OR rep1_hri_8 = '39')),
					REAL field_41 := (COUNT(GROUP, rep1_hri_1 = '41' OR rep1_hri_2 = '41' OR rep1_hri_3 = '41' OR rep1_hri_4 = '41' OR rep1_hri_5 = '41' OR rep1_hri_6 = '41' OR rep1_hri_7 = '41' OR rep1_hri_8 = '41')),
					REAL field_44 := (COUNT(GROUP, rep1_hri_1 = '44' OR rep1_hri_2 = '44' OR rep1_hri_3 = '44' OR rep1_hri_4 = '44' OR rep1_hri_5 = '44' OR rep1_hri_6 = '44' OR rep1_hri_7 = '44' OR rep1_hri_8 = '44')),
					REAL field_46 := (COUNT(GROUP, rep1_hri_1 = '46' OR rep1_hri_2 = '46' OR rep1_hri_3 = '46' OR rep1_hri_4 = '46' OR rep1_hri_5 = '46' OR rep1_hri_6 = '46' OR rep1_hri_7 = '46' OR rep1_hri_8 = '46')),
					REAL field_48 := (COUNT(GROUP, rep1_hri_1 = '48' OR rep1_hri_2 = '48' OR rep1_hri_3 = '48' OR rep1_hri_4 = '48' OR rep1_hri_5 = '48' OR rep1_hri_6 = '48' OR rep1_hri_7 = '48' OR rep1_hri_8 = '48')),
					REAL field_49 := (COUNT(GROUP, rep1_hri_1 = '49' OR rep1_hri_2 = '49' OR rep1_hri_3 = '49' OR rep1_hri_4 = '49' OR rep1_hri_5 = '49' OR rep1_hri_6 = '49' OR rep1_hri_7 = '49' OR rep1_hri_8 = '49')),
					REAL field_50 := (COUNT(GROUP, rep1_hri_1 = '50' OR rep1_hri_2 = '50' OR rep1_hri_3 = '50' OR rep1_hri_4 = '50' OR rep1_hri_5 = '50' OR rep1_hri_6 = '50' OR rep1_hri_7 = '50' OR rep1_hri_8 = '50')),
					REAL field_51 := (COUNT(GROUP, rep1_hri_1 = '51' OR rep1_hri_2 = '51' OR rep1_hri_3 = '51' OR rep1_hri_4 = '51' OR rep1_hri_5 = '51' OR rep1_hri_6 = '51' OR rep1_hri_7 = '51' OR rep1_hri_8 = '51')),
					REAL field_52 := (COUNT(GROUP, rep1_hri_1 = '52' OR rep1_hri_2 = '52' OR rep1_hri_3 = '52' OR rep1_hri_4 = '52' OR rep1_hri_5 = '52' OR rep1_hri_6 = '52' OR rep1_hri_7 = '52' OR rep1_hri_8 = '52')),
					REAL field_53 := (COUNT(GROUP, rep1_hri_1 = '53' OR rep1_hri_2 = '53' OR rep1_hri_3 = '53' OR rep1_hri_4 = '53' OR rep1_hri_5 = '53' OR rep1_hri_6 = '53' OR rep1_hri_7 = '53' OR rep1_hri_8 = '53')),
					REAL field_55 := (COUNT(GROUP, rep1_hri_1 = '55' OR rep1_hri_2 = '55' OR rep1_hri_3 = '55' OR rep1_hri_4 = '55' OR rep1_hri_5 = '55' OR rep1_hri_6 = '55' OR rep1_hri_7 = '55' OR rep1_hri_8 = '55')),
					REAL field_56 := (COUNT(GROUP, rep1_hri_1 = '56' OR rep1_hri_2 = '56' OR rep1_hri_3 = '56' OR rep1_hri_4 = '56' OR rep1_hri_5 = '56' OR rep1_hri_6 = '56' OR rep1_hri_7 = '56' OR rep1_hri_8 = '56')),
					REAL field_57 := (COUNT(GROUP, rep1_hri_1 = '57' OR rep1_hri_2 = '57' OR rep1_hri_3 = '57' OR rep1_hri_4 = '57' OR rep1_hri_5 = '57' OR rep1_hri_6 = '57' OR rep1_hri_7 = '57' OR rep1_hri_8 = '57')),
					REAL field_64 := (COUNT(GROUP, rep1_hri_1 = '64' OR rep1_hri_2 = '64' OR rep1_hri_3 = '64' OR rep1_hri_4 = '64' OR rep1_hri_5 = '64' OR rep1_hri_6 = '64' OR rep1_hri_7 = '64' OR rep1_hri_8 = '64')),
					REAL field_66 := (COUNT(GROUP, rep1_hri_1 = '66' OR rep1_hri_2 = '66' OR rep1_hri_3 = '66' OR rep1_hri_4 = '66' OR rep1_hri_5 = '66' OR rep1_hri_6 = '66' OR rep1_hri_7 = '66' OR rep1_hri_8 = '66')),
					REAL field_71 := (COUNT(GROUP, rep1_hri_1 = '71' OR rep1_hri_2 = '71' OR rep1_hri_3 = '71' OR rep1_hri_4 = '71' OR rep1_hri_5 = '71' OR rep1_hri_6 = '71' OR rep1_hri_7 = '71' OR rep1_hri_8 = '71')),
					REAL field_72 := (COUNT(GROUP, rep1_hri_1 = '72' OR rep1_hri_2 = '72' OR rep1_hri_3 = '72' OR rep1_hri_4 = '72' OR rep1_hri_5 = '72' OR rep1_hri_6 = '72' OR rep1_hri_7 = '72' OR rep1_hri_8 = '72')),
					REAL field_74 := (COUNT(GROUP, rep1_hri_1 = '74' OR rep1_hri_2 = '74' OR rep1_hri_3 = '74' OR rep1_hri_4 = '74' OR rep1_hri_5 = '74' OR rep1_hri_6 = '74' OR rep1_hri_7 = '74' OR rep1_hri_8 = '74')),
					REAL field_75 := (COUNT(GROUP, rep1_hri_1 = '75' OR rep1_hri_2 = '75' OR rep1_hri_3 = '75' OR rep1_hri_4 = '75' OR rep1_hri_5 = '75' OR rep1_hri_6 = '75' OR rep1_hri_7 = '75' OR rep1_hri_8 = '75')),
					REAL field_76 := (COUNT(GROUP, rep1_hri_1 = '76' OR rep1_hri_2 = '76' OR rep1_hri_3 = '76' OR rep1_hri_4 = '76' OR rep1_hri_5 = '76' OR rep1_hri_6 = '76' OR rep1_hri_7 = '76' OR rep1_hri_8 = '76')),
					REAL field_77 := (COUNT(GROUP, rep1_hri_1 = '77' OR rep1_hri_2 = '77' OR rep1_hri_3 = '77' OR rep1_hri_4 = '77' OR rep1_hri_5 = '77' OR rep1_hri_6 = '77' OR rep1_hri_7 = '77' OR rep1_hri_8 = '77')),
					REAL field_78 := (COUNT(GROUP, rep1_hri_1 = '78' OR rep1_hri_2 = '78' OR rep1_hri_3 = '78' OR rep1_hri_4 = '78' OR rep1_hri_5 = '78' OR rep1_hri_6 = '78' OR rep1_hri_7 = '78' OR rep1_hri_8 = '78')),
					REAL field_79 := (COUNT(GROUP, rep1_hri_1 = '79' OR rep1_hri_2 = '79' OR rep1_hri_3 = '79' OR rep1_hri_4 = '79' OR rep1_hri_5 = '79' OR rep1_hri_6 = '79' OR rep1_hri_7 = '79' OR rep1_hri_8 = '79')),
					REAL field_80 := (COUNT(GROUP, rep1_hri_1 = '80' OR rep1_hri_2 = '80' OR rep1_hri_3 = '80' OR rep1_hri_4 = '80' OR rep1_hri_5 = '80' OR rep1_hri_6 = '80' OR rep1_hri_7 = '80' OR rep1_hri_8 = '80')),
					REAL field_81 := (COUNT(GROUP, rep1_hri_1 = '81' OR rep1_hri_2 = '81' OR rep1_hri_3 = '81' OR rep1_hri_4 = '81' OR rep1_hri_5 = '81' OR rep1_hri_6 = '81' OR rep1_hri_7 = '81' OR rep1_hri_8 = '81')),
					REAL field_82 := (COUNT(GROUP, rep1_hri_1 = '82' OR rep1_hri_2 = '82' OR rep1_hri_3 = '82' OR rep1_hri_4 = '82' OR rep1_hri_5 = '82' OR rep1_hri_6 = '82' OR rep1_hri_7 = '82' OR rep1_hri_8 = '82')),
					REAL field_83 := (COUNT(GROUP, rep1_hri_1 = '83' OR rep1_hri_2 = '83' OR rep1_hri_3 = '83' OR rep1_hri_4 = '83' OR rep1_hri_5 = '83' OR rep1_hri_6 = '83' OR rep1_hri_7 = '83' OR rep1_hri_8 = '83')),
					REAL field_85 := (COUNT(GROUP, rep1_hri_1 = '85' OR rep1_hri_2 = '85' OR rep1_hri_3 = '85' OR rep1_hri_4 = '85' OR rep1_hri_5 = '85' OR rep1_hri_6 = '85' OR rep1_hri_7 = '85' OR rep1_hri_8 = '85')),
					REAL field_89 := (COUNT(GROUP, rep1_hri_1 = '89' OR rep1_hri_2 = '89' OR rep1_hri_3 = '89' OR rep1_hri_4 = '89' OR rep1_hri_5 = '89' OR rep1_hri_6 = '89' OR rep1_hri_7 = '89' OR rep1_hri_8 = '89')),
					REAL field_90 := (COUNT(GROUP, rep1_hri_1 = '90' OR rep1_hri_2 = '90' OR rep1_hri_3 = '90' OR rep1_hri_4 = '90' OR rep1_hri_5 = '90' OR rep1_hri_6 = '90' OR rep1_hri_7 = '90' OR rep1_hri_8 = '90')),
					REAL field_CA := (COUNT(GROUP, rep1_hri_1 = 'CA' OR rep1_hri_2 = 'CA' OR rep1_hri_3 = 'CA' OR rep1_hri_4 = 'CA' OR rep1_hri_5 = 'CA' OR rep1_hri_6 = 'CA' OR rep1_hri_7 = 'CA' OR rep1_hri_8 = 'CA')),
					REAL field_CL := (COUNT(GROUP, rep1_hri_1 = 'CL' OR rep1_hri_2 = 'CL' OR rep1_hri_3 = 'CL' OR rep1_hri_4 = 'CL' OR rep1_hri_5 = 'CL' OR rep1_hri_6 = 'CL' OR rep1_hri_7 = 'CL' OR rep1_hri_8 = 'CL')),
					REAL field_CO := (COUNT(GROUP, rep1_hri_1 = 'CO' OR rep1_hri_2 = 'CO' OR rep1_hri_3 = 'CO' OR rep1_hri_4 = 'CO' OR rep1_hri_5 = 'CO' OR rep1_hri_6 = 'CO' OR rep1_hri_7 = 'CO' OR rep1_hri_8 = 'CO')),
					REAL field_CZ := (COUNT(GROUP, rep1_hri_1 = 'CZ' OR rep1_hri_2 = 'CZ' OR rep1_hri_3 = 'CZ' OR rep1_hri_4 = 'CZ' OR rep1_hri_5 = 'CZ' OR rep1_hri_6 = 'CZ' OR rep1_hri_7 = 'CZ' OR rep1_hri_8 = 'CZ')),
					REAL field_DD := (COUNT(GROUP, rep1_hri_1 = 'DD' OR rep1_hri_2 = 'DD' OR rep1_hri_3 = 'DD' OR rep1_hri_4 = 'DD' OR rep1_hri_5 = 'DD' OR rep1_hri_6 = 'DD' OR rep1_hri_7 = 'DD' OR rep1_hri_8 = 'DD')),
					REAL field_DF := (COUNT(GROUP, rep1_hri_1 = 'DF' OR rep1_hri_2 = 'DF' OR rep1_hri_3 = 'DF' OR rep1_hri_4 = 'DF' OR rep1_hri_5 = 'DF' OR rep1_hri_6 = 'DF' OR rep1_hri_7 = 'DF' OR rep1_hri_8 = 'DF')),
					REAL field_DI := (COUNT(GROUP, rep1_hri_1 = 'DI' OR rep1_hri_2 = 'DI' OR rep1_hri_3 = 'DI' OR rep1_hri_4 = 'DI' OR rep1_hri_5 = 'DI' OR rep1_hri_6 = 'DI' OR rep1_hri_7 = 'DI' OR rep1_hri_8 = 'DI')),
					REAL field_DM := (COUNT(GROUP, rep1_hri_1 = 'DM' OR rep1_hri_2 = 'DM' OR rep1_hri_3 = 'DM' OR rep1_hri_4 = 'DM' OR rep1_hri_5 = 'DM' OR rep1_hri_6 = 'DM' OR rep1_hri_7 = 'DM' OR rep1_hri_8 = 'DM')),
					REAL field_DV := (COUNT(GROUP, rep1_hri_1 = 'DV' OR rep1_hri_2 = 'DV' OR rep1_hri_3 = 'DV' OR rep1_hri_4 = 'DV' OR rep1_hri_5 = 'DV' OR rep1_hri_6 = 'DV' OR rep1_hri_7 = 'DV' OR rep1_hri_8 = 'DV')),
					REAL field_IS := (COUNT(GROUP, rep1_hri_1 = 'IS' OR rep1_hri_2 = 'IS' OR rep1_hri_3 = 'IS' OR rep1_hri_4 = 'IS' OR rep1_hri_5 = 'IS' OR rep1_hri_6 = 'IS' OR rep1_hri_7 = 'IS' OR rep1_hri_8 = 'IS')),
					REAL field_IT := (COUNT(GROUP, rep1_hri_1 = 'IT' OR rep1_hri_2 = 'IT' OR rep1_hri_3 = 'IT' OR rep1_hri_4 = 'IT' OR rep1_hri_5 = 'IT' OR rep1_hri_6 = 'IT' OR rep1_hri_7 = 'IT' OR rep1_hri_8 = 'IT')),
					REAL field_MI := (COUNT(GROUP, rep1_hri_1 = 'MI' OR rep1_hri_2 = 'MI' OR rep1_hri_3 = 'MI' OR rep1_hri_4 = 'MI' OR rep1_hri_5 = 'MI' OR rep1_hri_6 = 'MI' OR rep1_hri_7 = 'MI' OR rep1_hri_8 = 'MI')),
					REAL field_MO := (COUNT(GROUP, rep1_hri_1 = 'MO' OR rep1_hri_2 = 'MO' OR rep1_hri_3 = 'MO' OR rep1_hri_4 = 'MO' OR rep1_hri_5 = 'MO' OR rep1_hri_6 = 'MO' OR rep1_hri_7 = 'MO' OR rep1_hri_8 = 'MO')),
					REAL field_MS := (COUNT(GROUP, rep1_hri_1 = 'MS' OR rep1_hri_2 = 'MS' OR rep1_hri_3 = 'MS' OR rep1_hri_4 = 'MS' OR rep1_hri_5 = 'MS' OR rep1_hri_6 = 'MS' OR rep1_hri_7 = 'MS' OR rep1_hri_8 = 'MS')),
					REAL field_NB := (COUNT(GROUP, rep1_hri_1 = 'NB' OR rep1_hri_2 = 'NB' OR rep1_hri_3 = 'NB' OR rep1_hri_4 = 'NB' OR rep1_hri_5 = 'NB' OR rep1_hri_6 = 'NB' OR rep1_hri_7 = 'NB' OR rep1_hri_8 = 'NB')),
					REAL field_NF := (COUNT(GROUP, rep1_hri_1 = 'NF' OR rep1_hri_2 = 'NF' OR rep1_hri_3 = 'NF' OR rep1_hri_4 = 'NF' OR rep1_hri_5 = 'NF' OR rep1_hri_6 = 'NF' OR rep1_hri_7 = 'NF' OR rep1_hri_8 = 'NF')),
					REAL field_PA := (COUNT(GROUP, rep1_hri_1 = 'PA' OR rep1_hri_2 = 'PA' OR rep1_hri_3 = 'PA' OR rep1_hri_4 = 'PA' OR rep1_hri_5 = 'PA' OR rep1_hri_6 = 'PA' OR rep1_hri_7 = 'PA' OR rep1_hri_8 = 'PA')),
					REAL field_PO := (COUNT(GROUP, rep1_hri_1 = 'PO' OR rep1_hri_2 = 'PO' OR rep1_hri_3 = 'PO' OR rep1_hri_4 = 'PO' OR rep1_hri_5 = 'PO' OR rep1_hri_6 = 'PO' OR rep1_hri_7 = 'PO' OR rep1_hri_8 = 'PO')),
					REAL field_RS := (COUNT(GROUP, rep1_hri_1 = 'RS' OR rep1_hri_2 = 'RS' OR rep1_hri_3 = 'RS' OR rep1_hri_4 = 'RS' OR rep1_hri_5 = 'RS' OR rep1_hri_6 = 'RS' OR rep1_hri_7 = 'RS' OR rep1_hri_8 = 'RS')),
					REAL field_SD := (COUNT(GROUP, rep1_hri_1 = 'SD' OR rep1_hri_2 = 'SD' OR rep1_hri_3 = 'SD' OR rep1_hri_4 = 'SD' OR rep1_hri_5 = 'SD' OR rep1_hri_6 = 'SD' OR rep1_hri_7 = 'SD' OR rep1_hri_8 = 'SD')),
					REAL field_SR := (COUNT(GROUP, rep1_hri_1 = 'SR' OR rep1_hri_2 = 'SR' OR rep1_hri_3 = 'SR' OR rep1_hri_4 = 'SR' OR rep1_hri_5 = 'SR' OR rep1_hri_6 = 'SR' OR rep1_hri_7 = 'SR' OR rep1_hri_8 = 'SR')),
					REAL field_VA := (COUNT(GROUP, rep1_hri_1 = 'VA' OR rep1_hri_2 = 'VA' OR rep1_hri_3 = 'VA' OR rep1_hri_4 = 'VA' OR rep1_hri_5 = 'VA' OR rep1_hri_6 = 'VA' OR rep1_hri_7 = 'VA' OR rep1_hri_8 = 'VA')),
					REAL field_WL := (COUNT(GROUP, rep1_hri_1 = 'WL' OR rep1_hri_2 = 'WL' OR rep1_hri_3 = 'WL' OR rep1_hri_4 = 'WL' OR rep1_hri_5 = 'WL' OR rep1_hri_6 = 'WL' OR rep1_hri_7 = 'WL' OR rep1_hri_8 = 'WL')),
					REAL field_ZI := (COUNT(GROUP, rep1_hri_1 = 'ZI' OR rep1_hri_2 = 'ZI' OR rep1_hri_3 = 'ZI' OR rep1_hri_4 = 'ZI' OR rep1_hri_5 = 'ZI' OR rep1_hri_6 = 'ZI' OR rep1_hri_7 = 'ZI' OR rep1_hri_8 = 'ZI'))
				}, rep1_cvi
			);
		
		Trans_Auth_Rep_Risk_Indicators_Counts := PROJECT(Auth_Rep_Risk_Indicators_Counts, TRANSFORM(Generic_Layout,
																																																	SELF.key := LEFT.rep1_cvi;
																																																	SELF.include_02	:= TRUE;
																																																	SELF.include_03	:= TRUE;
																																																	SELF.include_04	:= TRUE;
																																																	SELF.include_06	:= TRUE;
																																																	SELF.include_07	:= TRUE;
																																																	SELF.include_08	:= TRUE;
																																																	SELF.include_09	:= TRUE;
																																																	SELF.include_10	:= TRUE;
																																																	SELF.include_11	:= TRUE;
																																																	SELF.include_12	:= TRUE;
																																																	SELF.include_14	:= TRUE;
																																																	SELF.include_15	:= TRUE;
																																																	SELF.include_16	:= TRUE;
																																																	SELF.include_19	:= TRUE;
																																																	SELF.include_25	:= TRUE;
																																																	SELF.include_26	:= TRUE;
																																																	SELF.include_27	:= TRUE;
																																																	SELF.include_28	:= TRUE;
																																																	SELF.include_29	:= TRUE;
																																																	SELF.include_30	:= TRUE;
																																																	SELF.include_31	:= TRUE;
																																																	SELF.include_32	:= TRUE;
																																																	SELF.include_37	:= TRUE;
																																																	SELF.include_38	:= TRUE;
																																																	SELF.include_39	:= TRUE;
																																																	SELF.include_41	:= TRUE;
																																																	SELF.include_44	:= TRUE;
																																																	SELF.include_46	:= TRUE;
																																																	SELF.include_48	:= TRUE;
																																																	SELF.include_49	:= TRUE;
																																																	SELF.include_50	:= TRUE;
																																																	SELF.include_51	:= TRUE;
																																																	SELF.include_52	:= TRUE;
																																																	SELF.include_53	:= TRUE;
																																																	SELF.include_55	:= TRUE;
																																																	SELF.include_56	:= TRUE;
																																																	SELF.include_57	:= TRUE;
																																																	SELF.include_64	:= TRUE;
																																																	SELF.include_66	:= TRUE;
																																																	SELF.include_71	:= TRUE;
																																																	SELF.include_72	:= TRUE;
																																																	SELF.include_74	:= TRUE;
																																																	SELF.include_75	:= TRUE;
																																																	SELF.include_76	:= TRUE;
																																																	SELF.include_77	:= TRUE;
																																																	SELF.include_78	:= TRUE;
																																																	SELF.include_79	:= TRUE;
																																																	SELF.include_80	:= TRUE;
																																																	SELF.include_81	:= TRUE;
																																																	SELF.include_82	:= TRUE;
																																																	SELF.include_83	:= TRUE;
																																																	SELF.include_85	:= TRUE;
																																																	SELF.include_89	:= TRUE;
																																																	SELF.include_90	:= TRUE;
																																																	SELF.include_CA	:= TRUE;
																																																	SELF.include_CL	:= TRUE;
																																																	SELF.include_CO	:= TRUE;
																																																	SELF.include_CZ	:= TRUE;
																																																	SELF.include_DD	:= TRUE;
																																																	SELF.include_DF	:= TRUE;
																																																	SELF.include_DI	:= TRUE;
																																																	SELF.include_DM	:= TRUE;
																																																	SELF.include_DV	:= TRUE;
																																																	SELF.include_IS	:= TRUE;
																																																	SELF.include_IT	:= TRUE;
																																																	SELF.include_MI	:= TRUE;
																																																	SELF.include_MO	:= TRUE;
																																																	SELF.include_MS	:= TRUE;
																																																	SELF.include_NB	:= TRUE;
																																																	SELF.include_NF	:= TRUE;
																																																	SELF.include_PA	:= TRUE;
																																																	SELF.include_PO	:= TRUE;
																																																	SELF.include_RS	:= TRUE;
																																																	SELF.include_SD	:= TRUE;
																																																	SELF.include_SR	:= TRUE;
																																																	SELF.include_VA	:= TRUE;
																																																	SELF.include_WL	:= TRUE;
																																																	SELF.include_ZI	:= TRUE;
																																																	SELF := LEFT;
																																																	SELF := [];));
		
		Auth_Rep_Risk_Indicators_Detailed_Summary := calcResults(Trans_Auth_Rep_Risk_Indicators_Counts);

		

		
/* **************************************
 *              Outputs                 *
 ****************************************/	
		OUTPUT(Input_Detailed_Summary,, output_base_location + 'Overview_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(BusVerIndex_Summary,, output_base_location + 'BIID_SearchResults_BusVerIndex_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Bus2Exec_Detailed_Summary,, output_base_location + 'BIID_SearchResults_Bus2ExecLink_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(ResBus_Indicator_Detailed_Summary,, output_base_location + 'BIID_SearchResults_ResBusIndicator_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Risk_Indicators_Detailed_Summary,, output_base_location + 'Risk_Indicators_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Auth_Rep_NAS_Detailed_Summary,, output_base_location + 'Auth_Rep_NAS_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Auth_Rep_NAP_Detailed_Summary,, output_base_location + 'Auth_Rep_NAP_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Auth_Rep_Bus2Exec_Detailed_Summary,, output_base_location + 'Auth_Rep_Bus2Exec_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		OUTPUT(Auth_Rep_Risk_Indicators_Detailed_Summary,, output_base_location + 'Auth_Rep_Risk_Indicators_Detailed_Summary_' + jobid, csv(quote('"'), heading(single)), overwrite, expire(30));		
		
 
 


		//DEBUG
		// output(choosen(biidInputRecords, eyeball),  named('biidInputRecords_sample'));
		// output(totalNumberOfRecords,  named('totalNumberOfRecords'));
		// output(BusVerIndex_Counts,  named('BusVerIndex_Counts'));
		// output(Trans_BusVerIndex_Counts,  named('Trans_BusVerIndex_Counts'));
		// output(BusVerIndex_Counts,  named('BusVerIndex_Counts'));
		// output(Input_Detailed_Summary, named('Input_Detailed_Summary'));
		// output(BusVerIndex_Summary, named('BusVerIndex_Summary'));
		// output(Bus2Exec_Counts, named('Bus2Exec_Counts'));
		// output(Bus2Exec_Detailed_Summary, named('Bus2Exec_Detailed_Summary'));
		// output(ResBus_Indicator_Counts, named('ResBus_Indicator_Counts'));
		// output(ResBus_Indicator_Detailed_Summary, named('ResBus_Indicator_Detailed_Summary'));
		// output(Risk_Indicators_Counts, named('Risk_Indicators_Counts'));
		// output(Risk_Indicators_Detailed_Summary, named('Risk_Indicators_Detailed_Summary'));
		// output(Auth_Rep_NAS_Detailed_Summary, named('Auth_Rep_NAS_Detailed_Summary'));
		// output(Auth_Rep_NAP_Detailed_Summary, named('Auth_Rep_NAP_Detailed_Summary'));
		// output(Auth_Rep_Bus2Exec_Detailed_Summary, named('Auth_Rep_Bus2Exec_Detailed_Summary'));
		// output(Auth_Rep_Risk_Indicators_Counts, named('Auth_Rep_Risk_Indicators_Counts'));
		// output(Auth_Rep_Risk_Indicators_Detailed_Summary, named('Auth_Rep_Risk_Indicators_Detailed_Summary'));

		
		RETURN 'done';
	END;
END;