EXPORT Layouts := MODULE
  //Best Static key
	SHARED source := RECORD
		string2 source;
		unsigned8 source_record_id;
		string34 vl_id;
	END;

	SHARED company_name_case_layout := RECORD
		string120 company_name;
		unsigned2 company_name_data_permits;
		unsigned1 company_name_method;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		DATASET(source) sources;
  END;

	SHARED company_address_case_layout := RECORD
		string10 company_prim_range;
		string2 company_predir;
		string28 company_prim_name;
		string4 company_addr_suffix;
		string2 company_postdir;
		string10 company_unit_desig;
		string8 company_sec_range;
		string25 company_p_city_name;
		string25 address_v_city_name;
		string2 company_st;
		string5 company_zip5;
		string4 company_zip4;
		string18 county_name;
		unsigned2 company_address_data_permits;
		unsigned1 company_address_method;
  END;

	SHARED company_phone_case_layout := RECORD
		string10 company_phone;
		unsigned2 company_phone_data_permits;
		unsigned1 company_phone_method;
  END;

	SHARED company_fein_case_layout := RECORD
		string9 company_fein;
		unsigned2 company_fein_data_permits;
		unsigned1 company_fein_method;
		DATASET(source) sources;
  END;

	SHARED company_url_case_layout := RECORD
		string80 company_url;
		unsigned2 company_url_data_permits;
		unsigned1 company_url_method;
  END;

	SHARED company_incorporation_date_layout := RECORD
		unsigned4 company_incorporation_date;
		unsigned2 company_incorporation_date_permits;
		unsigned1 company_incorporation_date_method;
		DATASET(source) sources;
	END;

	SHARED duns_number_case_layout := RECORD
		string9 duns_number;
		unsigned2 duns_number_data_permits;
		unsigned1 duns_number_method;
	END;

	SHARED company_sic_code1_case_layout := RECORD
		string8 company_sic_code1;
		unsigned2 company_sic_code1_data_permits;
		unsigned1 company_sic_code1_method;
  END;

	SHARED company_naics_code1_case_layout := RECORD
		string6 company_naics_code1;
		unsigned2 company_naics_code1_data_permits;
		unsigned1 company_naics_code1_method;
  END;

	EXPORT key_static := RECORD
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		unsigned2 ultscore;
		unsigned2 orgscore;
		unsigned2 selescore;
		unsigned2 proxscore;
		unsigned2 powscore;
		unsigned2 empscore;
		unsigned2 dotscore;
		unsigned2 ultweight;
		unsigned2 orgweight;
		unsigned2 seleweight;
		unsigned2 proxweight;
		unsigned2 powweight;
		unsigned2 empweight;
		unsigned2 dotweight;
    boolean isActive ; //seleid level
    boolean isDefunct; //seleid level   
		unsigned6 company_bdid;
		DATASET(company_name_case_layout) company_name;
		DATASET(company_address_case_layout) company_address;
		DATASET(company_phone_case_layout) company_phone;
		DATASET(company_fein_case_layout) company_fein;
		DATASET(company_url_case_layout) company_url;
		DATASET(company_incorporation_date_layout) company_incorporation_date;
		DATASET(duns_number_case_layout) duns_number;
		DATASET(company_sic_code1_case_layout) sic_code;
		DATASET(company_naics_code1_case_layout) naics_code;
		integer1 fp;
	END;
  
  //Contacts Key
  SHARED layout_clean182_fips := RECORD
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip;
    string4 zip4;
    string4 cart;
    string1 cr_sort_sz;
    string4 lot;
    string1 lot_order;
    string2 dbpc;
    string1 chk_digit;
    string2 rec_type;
    string2 fips_state;
    string3 fips_county;
    string10 geo_lat;
    string11 geo_long;
    string4 msa;
    string7 geo_blk;
    string1 geo_match;
    string4 err_stat;
  END;

  SHARED layout_clean_name := RECORD
    string5 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5 name_suffix;
    string3 name_score;
  END;

  EXPORT key_contacts := RECORD
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 seleid;
    unsigned6 proxid;
    unsigned6 powid;
    unsigned6 empid;
    unsigned6 dotid;
    unsigned2 ultscore;
    unsigned2 orgscore;
    unsigned2 selescore;
    unsigned2 proxscore;
    unsigned2 powscore;
    unsigned2 empscore;
    unsigned2 dotscore;
    unsigned2 ultweight;
    unsigned2 orgweight;
    unsigned2 seleweight;
    unsigned2 proxweight;
    unsigned2 powweight;
    unsigned2 empweight;
    unsigned2 dotweight;
    string2 source;
    unsigned4 dt_first_seen;
    unsigned4 dt_last_seen;
    unsigned4 dt_vendor_first_reported;
    unsigned4 dt_vendor_last_reported;
    unsigned6 rcid;
    unsigned6 company_bdid;
    string120 company_name;
    string50 company_name_type_raw;
    unsigned8 company_rawaid;
    layout_clean182_fips company_address;
    string50 company_address_type_raw;
    string1 company_address_category;
    string3 company_address_country_code;
    string9 company_fein;
    string1 best_fein_indicator;
    string10 company_phone;
    string1 phone_type;
    string60 company_org_structure_raw;
    unsigned4 company_incorporation_date;
    string8 company_sic_code1;
    string8 company_sic_code2;
    string8 company_sic_code3;
    string8 company_sic_code4;
    string8 company_sic_code5;
    string6 company_naics_code1;
    string6 company_naics_code2;
    string6 company_naics_code3;
    string6 company_naics_code4;
    string6 company_naics_code5;
    string6 company_ticker;
    string6 company_ticker_exchange;
    string1 company_foreign_domestic;
    string80 company_url;
    string2 company_inc_state;
    string32 company_charter_number;
    unsigned4 company_filing_date;
    unsigned4 company_status_date;
    unsigned4 company_foreign_date;
    unsigned4 event_filing_date;
    string50 company_name_status_raw;
    string50 company_status_raw;
    unsigned4 dt_first_seen_company_name;
    unsigned4 dt_last_seen_company_name;
    unsigned4 dt_first_seen_company_address;
    unsigned4 dt_last_seen_company_address;
    string34 vl_id;
    boolean current;
    unsigned8 source_record_id;
    boolean glb;
    boolean dppa;
    unsigned2 phone_score;
    string81 match_company_name;
    string20 match_branch_city;
    string25 match_geo_city;
    string9 duns_number;
    string100 source_docid;
    boolean is_contact;
    unsigned4 dt_first_seen_contact;
    unsigned4 dt_last_seen_contact;
    unsigned6 contact_did;
    layout_clean_name contact_name;
    string50 contact_type_raw;
    string50 contact_job_title_raw;
    string9 contact_ssn;
    unsigned4 contact_dob;
    string30 contact_status_raw;
    string60 contact_email;
    string30 contact_email_username;
    string30 contact_email_domain;
    string10 contact_phone;
    unsigned8 cid;
    unsigned1 contact_score;
    string1 from_hdr;
    string35 company_department;
    unsigned8 company_aceaid;
    string50 company_name_type_derived;
    string50 company_address_type_derived;
    string60 company_org_structure_derived;
    string50 company_name_status_derived;
    string50 company_status_derived;
    string1 proxid_status_private;
    string1 powid_status_private;
    string1 seleid_status_private;
    string1 orgid_status_private;
    string1 ultid_status_private;
    string1 proxid_status_public;
    string1 powid_status_public;
    string1 seleid_status_public;
    string1 orgid_status_public;
    string1 ultid_status_public;
    string50 contact_type_derived;
    string50 contact_job_title_derived;
    string30 contact_status_derived;
    string1 address_type_derived;
    boolean is_vanity_name_derived;
    boolean executive_ind;
    integer8 executive_ind_order;
    integer1 fp;
  END;

  
END;