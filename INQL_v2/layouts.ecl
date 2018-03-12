IMPORT address, AID, standard, Risk_Indicators;

EXPORT layouts := MODULE

	export FIDO_extract_in := RECORD
  integer4 customer_account_sk;
  string30 hist_subaccount_id;
  string30 current_subaccount_id;
  string255 hh_name;
  integer4 mbs_gc_id;
  integer4 mbs_company_id;
  integer4 mbs_product_id;
  integer4 mbs_sub_product_id;
  integer4 hh_id;
  string2 primary_market_cd;
  string2 secondary_market_cd;
  string2 industry_code_1;
  string2 industry_code_2;
  string100 sub_market;
  integer4 cy_vertical_sk;
  string15 vc_id;
  boolean internal_flag;
  string50 vertical_market;
  string50 abstracted_vertical_market;
  string100 subaccount_name;
  integer8 bip_prox_id;
  string50 inquiry_tracking_industry;
  string4 ranked_sic_code;
  string100 industry;
  string30 use;
  integer1 opt_out;
  integer1 disable_observation;
  string16 content;
  integer1 exclude_from_access;
  string allow_flag;
  string mask;
  string market;
	unsigned4 first_seen_dt;
  unsigned4 last_seen_dt;
  string100 country;
  string100 country_gen1;
  string100 country_gen2;
  string100 country_gen3;
	END;

	export FIDO_extract_out := record  
 string30 hist_subaccount_id;
  string30 current_subaccount_id;
  integer4 mbs_gc_id;
  integer4 mbs_company_id;
  integer4 mbs_product_id;
  integer4 mbs_sub_product_id;
 string2 primary_market_cd;
  string2 secondary_market_cd;
  string2 industry_code_1;
  string2 industry_code_2;
  string100 sub_market;
  integer4 cy_vertical_sk;
  string15 vc_id;
  boolean internal_flag;
  string50 vertical_market;
  string50 abstracted_vertical_market;
  string100 subaccount_name;
  string50 inquiry_tracking_industry;
  string4 ranked_sic_code;
	string industry;
  string use;
  string opt_out;
  string disable_observation;
  string content;
	integer1 exclude_from_access;
  string mask;
  string market;
  unsigned4 first_seen_dt;
  unsigned4 last_seen_dt;
  string100 country;
  string100 country_gen1;
  string100 country_gen2;
  string100 country_gen3;
	END;
 
	export FIDO_new_MBS := record
		string product_id;
		string sub_product_id;
		string gc_id;
		string company_id;
		string sub_acct_id;
		string vertical;
		string market;
		string sub_market;
		string industry;
		string use;
		string primary_market_code;
		string secondary_market_code;
		string industry_code_1;
		string industry_code_2;
		string disable_observation;
		string opt_out;
		string content;
		unsigned8 allowflags;
		string translation;
		string internal_flag;
		string mbs_company_name;
		string4 ranked_sic_code;
		integer1 exclude_from_access;
		string mask;
		integer1 priority_flag;
		string100 country;
 END;
 
 export MBS_Finance_update_ := record
		string			HHID;
		string			HouseholdName;
		string			VCID;
		string			subaccount_id;
		string			gc_id;
		string			acct_name;
		string			platform;
		string			Banko_MN;
		string			vertical;
		string			market;
		string			sub_market;
		string			industry;
		string			use;
		string			primary_market_code;
		string			secondary_market_code;
		string			industry_code_1;
		string			industry_code_2;
		string			create_date;
		string			NB_status;
		string			Region;
		string			Team2;
		string			mgr_name;
		string			Team;
		string			pri_rep_name;
		string			pri_territory;
		string			sec_rep_name;
		string			cust_id;
		string			cust_name;
		string			city_name;
		string			state_cd;
		string			postal_cd;
	end;
	
	export MBS_Finance_old_ := record
		string			HHID;
		string			HouseholdName;
		string			sub_acct_id;
		string			gc_id;
		string			acct_name;
		string			attention_line;
		string			platform;
		string			Banko_MN;
		string			vertical;
		string			market;
		string			sub_market;
		string			industry;
		string			use;
		string			primary_market_code;
		string			secondary_market_code;
		string			industry_code_1;
		string			industry_code_2;
		string			create_date;
		string			NB_status;
		string			Region;
		string			Team2;
		string			mgr_name;
		string			Team;
		string			pri_rep_name;
		string			pri_territory;
		string			sec_rep_name;
		string			cust_id;
		string			cust_name;
		string			city_name;
		string			state_cd;
		string			postal_cd;
	end;

	export MBS_Finance_common := record
		MBS_Finance_old_;
		string company_id_finance;
		string co_cd;
		string hash_company_id_finance;
		string product_id;
		string billing_id_finance;
	end;
 
	export rTransaction_In := record
		string field1;
	end;
	
	export rTransaction_Base := record
		unsigned1 src_id;
		unsigned4 filedate;
		rTransaction_In;
	end;
	
	export rDeconfliction_In := record
		string field1;
	end;
	
	export rDeconfliction_Base := record
		unsigned1 src_id;
		unsigned4 filedate;
		rDeconfliction_In;
	end;
    
  export rAccurint_In := RECORD,maxlength(250000)
		string	orig_END_USER_ID;
		string	orig_LOGINID;
		string	orig_BILLING_CODE;
		string	orig_TRANSACTION_ID;
		string	orig_TRANSACTION_TYPE;
		string	orig_NEIGHBORS;
		string	orig_RELATIVES;
		string	orig_ASSOCIATES;
		string	orig_PROPERTY;
		string	orig_COMPANY_ID;
		string	orig_REFERENCE_CODE;
		string	orig_FNAME;
		string	orig_MNAME;
		string	orig_LNAME;
		string	orig_ADDRESS;
		string	orig_CITY;
		string	orig_STATE;
		string	orig_ZIP;
		string	orig_ZIP4;
		string	orig_PHONE;
		string	orig_SSN;
		string	orig_FREE;
		string	orig_RECORD_COUNT;
		string	orig_PRICE;
		string	orig_BANKRUPTCY;
		string	orig_TRANSACTION_CODE;
		string	orig_DATEADDED;
		string	orig_FULL_NAME;
		string	orig_BILLINGDATE;
		string	orig_business_name;
		string	orig_pricing_error_code;
		string	orig_dl_purpose;
		string	orig_result_format;
		string	orig_dob;
		string	orig_unique_id;
		string	orig_dls;
		string	orig_mvs;
		string	orig_FUNCTION_NAME;
		string	orig_response_time;
		string	orig_data_source;
		string	orig_glb_purpose;
		string	orig_REPORT_OPTIONS;
		string	orig_UNUSED;
		string	orig_login_history_id;
		string	orig_ASEID;
		string	orig_years;
		string	orig_IP_ADDRESS;
		string	orig_SOURCE_CODE;
		string	orig_RETAIL_PRICE;
	end;
	
  export rAccurint_In_Ext := RECORD
    unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rAccurint_In;
	end;
	
	export rCustom_In := rAccurint_In;
	
	export rCustom_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rCustom_In;
	end;
	
	export rBanko_In := record, maxlength(10000)
		string	orig_transaction_id;
		string	orig_function_name;
		string	orig_company_id;
		string	orig_login_id;
		string	orig_billing_code;
		string	orig_record_count;
		string	orig_fcra_purpose;
		string	orig_glb_purpose;
		string	orig_dppa_purpose;
		string	orig_ip_address;
		string	orig_reference_code;
		string	orig_login_history_id;
		string	orig_date_added;
		string	orig_price;
		string	orig_pricing_error_code;
		string	orig_free;
		string	orig_business_name;
		string	orig_name_first;
		string	orig_name_last;
		string	orig_ssn;
		string	orig_case_number;
		string	orig_address;
		string	orig_city;
		string	orig_state;
		string	orig_zip;
		string	orig_dob;
		string	orig_phone;
		string	orig_tmsid;
		string	orig_unique_id;
		string	orig_out_tmsid;
		string	orig_out_business_name;
		string	orig_out_first_name;
		string	orig_out_last_name;
		string	orig_out_ssn;
		string	orig_out_address;
		string	orig_out_city;
		string	orig_out_state;
		string	orig_out_zip;
		string	orig_out_case_number;
		string	orig_transaction_type := '';
	end;
	
	export rBanko_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rBanko_In;
	end;
	
  export rBatch_In_PIIs := record	
		string orig_suffix_name;
		string orig_former_last_name;
		string orig_business_title;
		string orig_company_addressline1;
		string orig_company_addressline2;
		string orig_company_address_prim_range;
		string orig_company_address_predir;
		string orig_company_address_prim_name;
		string orig_company_address_suffix;
		string orig_company_address_postdir;
		string orig_company_address_unit_desig;
		string orig_company_address_sec_range;
		string orig_company_address_city;
		string orig_company_address_st;
		string orig_company_address_zip5;
		string orig_company_address_zip4;
		string orig_company_fax_number;
		string orig_company_start_date;
		string orig_company_years_in_business;
		string orig_company_sic_code;
		string orig_company_naic_code;
		string orig_company_structure;
		string orig_company_yearly_revenue;
		string orig_subj2_first_name;
		string orig_subj2_middle_name;
		string orig_subj2_last_name;
		string orig_subj2_suffix_name;
		string orig_subj2_full_name;
		string orig_subj2_ssn;
		string orig_subj2_dob;
		string orig_subj2_dl_num;
		string orig_subj2_dl_state;
		string orig_subj2_former_last_name;
		string orig_subj2_address_addressline1;
		string orig_subj2_address_addressline2;
		string orig_subj2_address_prim_range;
		string orig_subj2_address_predir;
		string orig_subj2_address_prim_name;
		string orig_subj2_address_suffix;
		string orig_subj2_address_postdir;
		string orig_subj2_address_unit_desig;
		string orig_subj2_address_sec_range;
		string orig_subj2_address_city;
		string orig_subj2_address_st;
		string orig_subj2_address_z5;
		string orig_subj2_address_z4;
		string orig_subj2_phone;
		string orig_subj2_work_phone;
		string orig_subj2_business_title;
		string orig_subj3_first_name;
		string orig_subj3_middle_name;
		string orig_subj3_last_name;
		string orig_subj3_suffix_name;
		string orig_subj3_full_name;
		string orig_subj3_ssn;
		string orig_subj3_dob;
		string orig_subj3_dl_num;
		string orig_subj3_dl_state;
		string orig_subj3_former_last_name;
		string orig_subj3_address_addressline1;
		string orig_subj3_address_addressline2;
		string orig_subj3_address_prim_range;
		string orig_subj3_address_predir;
		string orig_subj3_address_prim_name;
		string orig_subj3_address_suffix;
		string orig_subj3_address_postdir;
		string orig_subj3_address_unit_desig;
		string orig_subj3_address_sec_range;
		string orig_subj3_address_city;
		string orig_subj3_address_st;
		string orig_subj3_address_z5;
		string orig_subj3_address_z4;
		string orig_subj3_phone;
		string orig_subj3_work_phone;
		string orig_subj3_business_title;
		string orig_email;
		string orig_subj2_email;
		string orig_subj2_company_name;
		string orig_subj2_fein;
		string orig_subj3_email;
		string orig_subj3_company_name;
		string orig_subj3_fein;
		string orig_subj4_first_name;
		string orig_subj4_middle_name;
		string orig_subj4_last_name;
		string orig_subj4_suffix_name;
		string orig_subj4_full_name;
		string orig_subj4_ssn;
		string orig_subj4_dob;
		string orig_subj4_dl_num;
		string orig_subj4_dl_state;
		string orig_subj4_former_last_name;
		string orig_subj4_address_addressline1;
		string orig_subj4_address_addressline2;
		string orig_subj4_address_prim_range;
		string orig_subj4_address_predir;
		string orig_subj4_address_prim_name;
		string orig_subj4_address_suffix;
		string orig_subj4_address_postdir;
		string orig_subj4_address_unit_desig;
		string orig_subj4_address_sec_range;
		string orig_subj4_address_city;
		string orig_subj4_address_st;
		string orig_subj4_address_z5;
		string orig_subj4_address_z4;
		string orig_subj4_phone;
		string orig_subj4_work_phone;
		string orig_subj4_business_title;
		string orig_subj4_email;
		string orig_subj4_company_name;
		string orig_subj4_fein;
		string orig_subj5_first_name;
		string orig_subj5_middle_name;
		string orig_subj5_last_name;
		string orig_subj5_suffix_name;
		string orig_subj5_full_name;
		string orig_subj5_ssn;
		string orig_subj5_dob;
		string orig_subj5_dl_num;
		string orig_subj5_dl_state;
		string orig_subj5_former_last_name;
		string orig_subj5_address_addressline1;
		string orig_subj5_address_addressline2;
		string orig_subj5_address_prim_range;
		string orig_subj5_address_predir;
		string orig_subj5_address_prim_name;
		string orig_subj5_address_suffix;
		string orig_subj5_address_postdir;
		string orig_subj5_address_unit_desig;
		string orig_subj5_address_sec_range;
		string orig_subj5_address_city;
		string orig_subj5_address_st;
		string orig_subj5_address_z5;
		string orig_subj5_address_z4;
		string orig_subj5_phone;
		string orig_subj5_work_phone;
		string orig_subj5_business_title;
		string orig_subj5_email;
		string orig_subj5_company_name;
		string orig_subj5_fein;
		string orig_subj6_first_name;
		string orig_subj6_middle_name;
		string orig_subj6_last_name;
		string orig_subj6_suffix_name;
		string orig_subj6_full_name;
		string orig_subj6_ssn;
		string orig_subj6_dob;
		string orig_subj6_dl_num;
		string orig_subj6_dl_state;
		string orig_subj6_former_last_name;
		string orig_subj6_address_addressline1;
		string orig_subj6_address_addressline2;
		string orig_subj6_address_prim_range;
		string orig_subj6_address_predir;
		string orig_subj6_address_prim_name;
		string orig_subj6_address_suffix;
		string orig_subj6_address_postdir;
		string orig_subj6_address_unit_desig;
		string orig_subj6_address_sec_range;
		string orig_subj6_address_city;
		string orig_subj6_address_st;
		string orig_subj6_address_z5;
		string orig_subj6_address_z4;
		string orig_subj6_phone;
		string orig_subj6_work_phone;
		string orig_subj6_business_title;
		string orig_subj6_email;
		string orig_subj6_company_name;
		string orig_subj6_fein;
		string orig_subj7_first_name;
		string orig_subj7_middle_name;
		string orig_subj7_last_name;
		string orig_subj7_suffix_name;
		string orig_subj7_full_name;
		string orig_subj7_ssn;
		string orig_subj7_dob;
		string orig_subj7_dl_num;
		string orig_subj7_dl_state;
		string orig_subj7_former_last_name;
		string orig_subj7_address_addressline1;
		string orig_subj7_address_addressline2;
		string orig_subj7_address_prim_range;
		string orig_subj7_address_predir;
		string orig_subj7_address_prim_name;
		string orig_subj7_address_suffix;
		string orig_subj7_address_postdir;
		string orig_subj7_address_unit_desig;
		string orig_subj7_address_sec_range;
		string orig_subj7_address_city;
		string orig_subj7_address_st;
		string orig_subj7_address_z5;
		string orig_subj7_address_z4;
		string orig_subj7_phone;
		string orig_subj7_work_phone;
		string orig_subj7_business_title;
		string orig_subj7_email;
		string orig_subj7_company_name;
		string orig_subj7_fein;
		string orig_subj8_first_name;
		string orig_subj8_middle_name;
		string orig_subj8_last_name;
		string orig_subj8_suffix_name;
		string orig_subj8_full_name;
		string orig_subj8_ssn;
		string orig_subj8_dob;
		string orig_subj8_dl_num;
		string orig_subj8_dl_state;
		string orig_subj8_former_last_name;
		string orig_subj8_address_addressline1;
		string orig_subj8_address_addressline2;
		string orig_subj8_address_prim_range;
		string orig_subj8_address_predir;
		string orig_subj8_address_prim_name;
		string orig_subj8_address_suffix;
		string orig_subj8_address_postdir;
		string orig_subj8_address_unit_desig;
		string orig_subj8_address_sec_range;
		string orig_subj8_address_city;
		string orig_subj8_address_st;
		string orig_subj8_address_z5;
		string orig_subj8_address_z4;
		string orig_subj8_phone;
		string orig_subj8_work_phone;
		string orig_subj8_business_title;
		string orig_subj8_email;
		string orig_subj8_company_name;
		string orig_subj8_fein;
		string orig_company_alternate_name;
	
	end; 
	
	export rBatch_In := record, maxlength(10000)
		string orig_datetime_stamp;
		string orig_global_company_id;
		string orig_company_id;
		string orig_product_cd;
		string orig_method;
		string orig_vertical;
		string orig_function_name;
		string orig_transaction_type;
		string orig_login_history_id;
		string20 orig_job_id;
		string orig_sequence_number;
		string orig_first_name;
		string orig_middle_name;
		string orig_last_name;
		string orig_ssn;
		string orig_dob;
		string orig_dl_num;
		string orig_dl_state;
		string orig_address1_addressline1;
		string orig_address1_addressline2;
		string orig_address1_prim_range;
		string orig_address1_predir;
		string orig_address1_prim_name;
		string orig_address1_suffix;
		string orig_address1_postdir;
		string orig_address1_unit_desig;
		string orig_address1_sec_range;
		string orig_address1_city;
		string orig_address1_st;
		string orig_address1_z5;
		string orig_address1_z4;
		string orig_address2_addressline1;
		string orig_address2_addressline2;
		string orig_address2_prim_range;
		string orig_address2_predir;
		string orig_address2_prim_name;
		string orig_address2_suffix;
		string orig_address2_postdir;
		string orig_address2_unit_desig;
		string orig_address2_sec_range;
		string orig_address2_city;
		string orig_address2_st;
		string orig_address2_z5;
		string orig_address2_z4;
		string orig_bdid;
		string orig_bdl;
		string orig_did;
		string orig_company_name;
		string orig_fein;
		string orig_phone;
		string orig_work_phone;
		string orig_company_phone;
		string orig_reference_code;
		string orig_ip_address_initiated;
		string orig_ip_address_executed;
		string orig_charter_number;
		string orig_ucc_original_filing_number;
		string orig_email_address;
		string orig_domain_name;
		string orig_full_name;
		string orig_dl_purpose;
		string orig_glb_purpose;
		string orig_fcra_purpose;
		string orig_process_id;
		rBatch_In_PIIs;
		
	end;
    
  export rBatch_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rBatch_In;
	end;

	export	rBatch_PIIs_Base := record
		string datetime;
		string20 transaction_id;
		string sequence_number;   
		string process_id;                    

		string20 cmp_fax_number;         
		string9 	cmp_fein;                
		string8 	cmp_sic_code;            
		string8 	cmp_naic_code;            
		string32 cmp_business_structure;   
		string3 	cmp_years_in_business; 
		string8 	cmp_bus_start_date;       
		string12 cmp_yearly_revenue; 
		string100 cmp_alt_name;

		string30 	pii2_first_name;          
		string30 	pii2_middle_name;         
		string30 	pii2_last_name;         
		string10 	pii2_suffix_name;        
		string30 	pii2_former_last_name;   
		string60 	pii2_address;            
		string50 	pii2_city;                
		string2 	  pii2_state;              
		string9 	  pii2_zip;                 
		string20 	pii2_phone;              
		string20 	pii2_work_phone;         
		string8 	  pii2_dob;                
		string30 	pii2_dl;                  
		string2 	  pii2_dl_state;            
		string30 	pii2_email;              
		string9 	  pii2_ssn;                 
		string64 	pii2_business_title;      
		integer8 	pii2_response_lexid; 
		string30 	pii2_clean_first_name;          
		string30 	pii2_clean_middle_name;         
		string30 	pii2_clean_last_name;         
		string10 	pii2_clean_suffix_name;       
		string10 	pii2_clean_prim_range;    
		string40 	pii2_clean_prim_name;     
		string10 	pii2_clean_addr_suffix;   
		string10 	pii2_clean_postdir;       
		string15 	pii2_clean_unit_desig;    
		string10 	pii2_clean_sec_range;     
		string50 	pii2_clean_v_city_name;   
		string2 	  pii2_clean_st;            
		string9 	  pii2_clean_zip5;        
		string4 	  pii2_clean_zip4;          
		string2 	  pii2_clean_addr_rec_type; 
		string2 	  pii2_clean_fips_state;   
		string3 	  pii2_clean_fips_county;   
		string15 	pii2_clean_geo_lat;       
		string15 	pii2_clean_geo_long;     
		string4 	  pii2_clean_cbsa;          
		string10 	pii2_clean_geo_blk;      
		string2 	  pii2_clean_geo_match;    
		string5 	  pii2_clean_err_stat;      
		string2 	  pii2_clean_predir;  
		string100  pii2_cmp_name;                
		string9    pii2_cmp_fein;   
				 
		string30 	pii3_first_name;          
		string30 	pii3_middle_name;         
		string30 	pii3_last_name;         
		string10 	pii3_suffix_name;         
		string30 	pii3_former_last_name;    
		string60 	pii3_address;            
		string50 	pii3_city;              
		string2 	  pii3_state;              
		string9 	  pii3_zip;                 
		string20 	pii3_phone;              
		string20 	pii3_work_phone;         
		string8 	  pii3_dob;                 
		string30 	pii3_dl;                 
		string2 	  pii3_dl_state;            
		string30 	pii3_email;               
		string9 	  pii3_ssn;                 
		string64 	pii3_business_title;     
		integer8 	pii3_response_lexid; 
		string30 	pii3_clean_first_name;          
		string30 	pii3_clean_middle_name;         
		string30 	pii3_clean_last_name;         
		string10 	pii3_clean_suffix_name;       
		string10 	pii3_clean_prim_range;    
		string40 	pii3_clean_prim_name;     
		string10 	pii3_clean_addr_suffix;   
		string10 	pii3_clean_postdir;       
		string15 	pii3_clean_unit_desig;    
		string10 	pii3_clean_sec_range;    
		string50 	pii3_clean_v_city_name;   
		string2 	pii3_clean_st;            
		string9 	pii3_clean_zip5;          
		string4 	pii3_clean_zip4;          
		string2 	pii3_clean_addr_rec_type; 
		string2 	pii3_clean_fips_state;   
		string3 	pii3_clean_fips_county;   
		string15 	pii3_clean_geo_lat;      
		string15 	pii3_clean_geo_long;      
		string4 	pii3_clean_cbsa;         
		string10 	pii3_clean_geo_blk;      
		string2 	pii3_clean_geo_match;   
		string5 	pii3_clean_err_stat;     
		string2 	pii3_clean_predir;        
		string100 pii3_cmp_name;                
		string9   pii3_cmp_fein;  

		string30 	pii4_first_name;          
		string30 	pii4_middle_name;         
		string30 	pii4_last_name;         
		string10 	pii4_suffix_name;         
		string30 	pii4_former_last_name;    
		string60 	pii4_address;            
		string50 	pii4_city;              
		string2 	pii4_state;              
		string9 	pii4_zip;                 
		string20 	pii4_phone;              
		string20 	pii4_work_phone;         
		string8 	pii4_dob;                 
		string30 	pii4_dl;                 
		string2 	pii4_dl_state;            
		string30 	pii4_email;               
		string9 	pii4_ssn;                 
		string64 	pii4_business_title;     
		integer8 	pii4_response_lexid; 
		string30 	pii4_clean_first_name;          
		string30 	pii4_clean_middle_name;         
		string30 	pii4_clean_last_name;         
		string10 	pii4_clean_suffix_name;       
		string10 	pii4_clean_prim_range;    
		string40 	pii4_clean_prim_name;     
		string10 	pii4_clean_addr_suffix;   
		string10 	pii4_clean_postdir;       
		string15 	pii4_clean_unit_desig;    
		string10 	pii4_clean_sec_range;    
		string50 	pii4_clean_v_city_name;   
		string2 	pii4_clean_st;            
		string9 	pii4_clean_zip5;          
		string4 	pii4_clean_zip4;          
		string2 	pii4_clean_addr_rec_type; 
		string2 	pii4_clean_fips_state;   
		string3 	pii4_clean_fips_county;   
		string15 	pii4_clean_geo_lat;      
		string15 	pii4_clean_geo_long;      
		string4 	pii4_clean_cbsa;         
		string10 	pii4_clean_geo_blk;      
		string2 	pii4_clean_geo_match;   
		string5 	pii4_clean_err_stat;     
		string2 	pii4_clean_predir;
		string100 pii4_cmp_name;                
		string9   pii4_cmp_fein;  

		string30 	pii5_first_name;          
		string30 	pii5_middle_name;         
		string30 	pii5_last_name;         
		string10 	pii5_suffix_name;         
		string30 	pii5_former_last_name;    
		string60 	pii5_address;            
		string50 	pii5_city;              
		string2 	pii5_state;              
		string9 	pii5_zip;                 
		string20 	pii5_phone;              
		string20 	pii5_work_phone;         
		string8 	pii5_dob;                 
		string30 	pii5_dl;                 
		string2 	pii5_dl_state;            
		string30 	pii5_email;               
		string9 	pii5_ssn;                 
		string64 	pii5_business_title;     
		integer8 	pii5_response_lexid; 
		string30 	pii5_clean_first_name;          
		string30 	pii5_clean_middle_name;         
		string30 	pii5_clean_last_name;         
		string10 	pii5_clean_suffix_name;       
		string10 	pii5_clean_prim_range;    
		string40 	pii5_clean_prim_name;     
		string10 	pii5_clean_addr_suffix;   
		string10 	pii5_clean_postdir;       
		string15 	pii5_clean_unit_desig;    
		string10 	pii5_clean_sec_range;    
		string50 	pii5_clean_v_city_name;   
		string2 	pii5_clean_st;            
		string9 	pii5_clean_zip5;          
		string4 	pii5_clean_zip4;          
		string2 	pii5_clean_addr_rec_type; 
		string2 	pii5_clean_fips_state;   
		string3 	pii5_clean_fips_county;   
		string15 	pii5_clean_geo_lat;      
		string15 	pii5_clean_geo_long;      
		string4 	pii5_clean_cbsa;         
		string10 	pii5_clean_geo_blk;      
		string2 	pii5_clean_geo_match;   
		string5 	pii5_clean_err_stat;     
		string2 	pii5_clean_predir;
		string100 pii5_cmp_name;                
		string9   pii5_cmp_fein;  

		string30 	pii6_first_name;          
		string30 	pii6_middle_name;         
		string30 	pii6_last_name;         
		string10 	pii6_suffix_name;         
		string30 	pii6_former_last_name;    
		string60 	pii6_address;            
		string50 	pii6_city;              
		string2 	pii6_state;              
		string9 	pii6_zip;                 
		string20 	pii6_phone;              
		string20 	pii6_work_phone;         
		string8 	pii6_dob;                 
		string30 	pii6_dl;                 
		string2 	pii6_dl_state;            
		string30 	pii6_email;               
		string9 	pii6_ssn;                 
		string64 	pii6_business_title;     
		integer8 	pii6_response_lexid; 
		string30 	pii6_clean_first_name;          
		string30 	pii6_clean_middle_name;         
		string30 	pii6_clean_last_name;         
		string10 	pii6_clean_suffix_name;       
		string10 	pii6_clean_prim_range;    
		string40 	pii6_clean_prim_name;     
		string10 	pii6_clean_addr_suffix;   
		string10 	pii6_clean_postdir;       
		string15 	pii6_clean_unit_desig;    
		string10 	pii6_clean_sec_range;    
		string50 	pii6_clean_v_city_name;   
		string2 	pii6_clean_st;            
		string9 	pii6_clean_zip5;          
		string4 	pii6_clean_zip4;          
		string2 	pii6_clean_addr_rec_type; 
		string2 	pii6_clean_fips_state;   
		string3 	pii6_clean_fips_county;   
		string15 	pii6_clean_geo_lat;      
		string15 	pii6_clean_geo_long;      
		string4 	pii6_clean_cbsa;         
		string10 	pii6_clean_geo_blk;      
		string2 	pii6_clean_geo_match;   
		string5 	pii6_clean_err_stat;     
		string2 	pii6_clean_predir;
		string100 pii6_cmp_name;                
		string9   pii6_cmp_fein;  

		string30 	pii7_first_name;          
		string30 	pii7_middle_name;         
		string30 	pii7_last_name;         
		string10 	pii7_suffix_name;         
		string30 	pii7_former_last_name;    
		string60 	pii7_address;            
		string50 	pii7_city;              
		string2 	pii7_state;              
		string9 	pii7_zip;                 
		string20 	pii7_phone;              
		string20 	pii7_work_phone;         
		string8 	pii7_dob;                 
		string30 	pii7_dl;                 
		string2 	pii7_dl_state;            
		string30 	pii7_email;               
		string9 	pii7_ssn;                 
		string64 	pii7_business_title;     
		integer8 	pii7_response_lexid; 
		string30 	pii7_clean_first_name;          
		string30 	pii7_clean_middle_name;         
		string30 	pii7_clean_last_name;         
		string10 	pii7_clean_suffix_name;       
		string10 	pii7_clean_prim_range;    
		string40 	pii7_clean_prim_name;     
		string10 	pii7_clean_addr_suffix;   
		string10 	pii7_clean_postdir;       
		string15 	pii7_clean_unit_desig;    
		string10 	pii7_clean_sec_range;    
		string50 	pii7_clean_v_city_name;   
		string2 	pii7_clean_st;            
		string9 	pii7_clean_zip5;          
		string4 	pii7_clean_zip4;          
		string2 	pii7_clean_addr_rec_type; 
		string2 	pii7_clean_fips_state;   
		string3 	pii7_clean_fips_county;   
		string15 	pii7_clean_geo_lat;      
		string15 	pii7_clean_geo_long;      
		string4 	pii7_clean_cbsa;         
		string10 	pii7_clean_geo_blk;      
		string2 	pii7_clean_geo_match;   
		string5 	pii7_clean_err_stat;     
		string2 	pii7_clean_predir;
		string100 pii7_cmp_name;                
		string9   pii7_cmp_fein;  

		string30 	pii8_first_name;          
		string30 	pii8_middle_name;         
		string30 	pii8_last_name;         
		string10 	pii8_suffix_name;         
		string30 	pii8_former_last_name;    
		string60 	pii8_address;            
		string50 	pii8_city;              
		string2 	pii8_state;              
		string9 	pii8_zip;                 
		string20 	pii8_phone;              
		string20 	pii8_work_phone;         
		string8 	pii8_dob;                 
		string30 	pii8_dl;                 
		string2 	pii8_dl_state;            
		string30 	pii8_email;               
		string9 	pii8_ssn;                 
		string64 	pii8_business_title;     
		integer8 	pii8_response_lexid; 
		string30 	pii8_clean_first_name;          
		string30 	pii8_clean_middle_name;         
		string30 	pii8_clean_last_name;         
		string10 	pii8_clean_suffix_name;       
		string10 	pii8_clean_prim_range;    
		string40 	pii8_clean_prim_name;     
		string10 	pii8_clean_addr_suffix;   
		string10 	pii8_clean_postdir;       
		string15 	pii8_clean_unit_desig;    
		string10 	pii8_clean_sec_range;    
		string50 	pii8_clean_v_city_name;   
		string2 	pii8_clean_st;            
		string9 	pii8_clean_zip5;          
		string4 	pii8_clean_zip4;          
		string2 	pii8_clean_addr_rec_type; 
		string2 	pii8_clean_fips_state;   
		string3 	pii8_clean_fips_county;   
		string15 	pii8_clean_geo_lat;      
		string15 	pii8_clean_geo_long;      
		string4 	pii8_clean_cbsa;         
		string10 	pii8_clean_geo_blk;      
		string2 	pii8_clean_geo_match;   
		string5 	pii8_clean_err_stat;     
		string2 	pii8_clean_predir;
		string100 pii8_cmp_name;                
		string9   pii8_cmp_fein;  
	end;

	export rBatchR3_In := record
		string orig_pid,
		string orig_company_id,
		string orig_product_id,
		string orig_global_company_id,
		string orig_full_name,
		string orig_personal_phone,
		string orig_work_phone,
		string orig_dob,
		string orig_dl,
		string orig_dl_state,
		string orig_email,
		string orig_ssn,
		string orig_linkid,
		string orig_ipaddr,										
		string orig_addr1_1,
		string orig_addr2_1,
		string orig_city_1,
		string orig_st_1,
		string orig_zip_1,
		string orig_cname,
		string orig_company_phone,
		string orig_ein,
		string orig_charter_number,
		string orig_ucc_number,
		string orig_domain_name,
		string orig_addr1_2,
		string orig_addr2_2,
		string orig_city_2,
		string orig_st_2,
		string orig_zip_2,
		string orig_datetime,
		string orig_start_monitor,
		string orig_stop_monitor,
		string orig_login_history_id,
		string orig_transaction_id,
		string orig_sequence_number,
		string orig_job_id := '';
		string orig_method,
		string orig_transaction_type := '',
		string orig_function_name := '',
		string orig_fcra_purpose;
		string orig_glb_purpose;
		string orig_dppa_purpose;
		boolean isFCRA;
		string null := '';
		string source;
	end;
	
	export rBatchR3_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rBatchR3_In;
	end;
	
	export rBridger_In := record
		string datetime;
		string customer_id;
		string search_function_name;
		string entity_type;
		string id;
		string field1 := '';
		string field2 := '';
		string field3 := '';
		string field4 := '';
		string field5 := '';
		string field6 := '';
		string field7 := '';
		string field8 := '';
		string field9 := '';
		string field10 := '';
		string field11 := '';
		string field12 := '';
		string field13 := '';
		string field14 := '';
		string field15 := '';
		string field16 := '';
	end;
	
	export rBridger_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rBridger_In;
	end;
	
	export rRiskwise_In := record
		string20	orig_login_id;
		string20	orig_billing_code;
		string16	orig_transaction_id;
		string20	orig_function_name;
		string10	orig_company_id;
		string50	orig_reference_code;
		string30	orig_fname;
		string30	orig_mname;
		string30	orig_lname;
		string10	orig_name_suffix;
		string30	orig_fname_2;
		string30	orig_mname_2;
		string30	orig_lname_2;
		string10	orig_name_suffix_2;
		string60	orig_address;
		string50	orig_city;
		string2		orig_state;
		string9		orig_zip;
		string4		orig_zip4;
		string60	orig_address_2;
		string50	orig_city_2;
		string2		orig_state_2;
		string9		orig_zip_2;
		string4		orig_zip4_2;
		string60	orig_clean_address;
		string50	orig_clean_city;
		string2		orig_clean_state;
		string5		orig_clean_zip;
		string4		orig_clean_zip4;
		string20	orig_phone;
		string20	orig_homephone;
		string20	orig_homephone_2;
		string20	orig_workphone;
		string20	orig_workphone_2;
		string9		orig_ssn;
		string9		orig_ssn_2;
		string20	orig_free;
		string20	orig_record_count;
		string20	orig_price;
		string20	orig_revenue;
		string60	orig_full_name;
		string50	orig_business_name;
		string50	orig_business_name_2;
		string20	orig_years;
		string20	orig_pricing_error_code;
		string20	orig_fcra_purpose;
		string3		orig_result_format;
		string8		orig_dob;
		string8		orig_dob_2;
		string32	orig_unique_id;
		string20	orig_response_time;
		string8		orig_data_source;
		string255	orig_report_options;
		string80	orig_end_user_name;
		string80	orig_end_user_address_1;
		string80	orig_end_user_address_2;
		string60	orig_end_user_city;
		string2		orig_end_user_state;
		string9		orig_end_user_zip;
		string20	orig_login_history_id;
		string2 	orig_employment_state; 
		string20	orig_end_user_industry_class;
		string32	orig_function_specific_data;
		string20	orig_date_added;
		string20	orig_retail_price;
		string4		orig_country_code;
		string30	orig_email;
		string30	orig_email_2;
		string30	orig_dl_number;
		string30	orig_dl_number_2;
		string30	orig_sub_id;
		string20	orig_neighbors;
		string20	orig_relatives;
		string20	orig_associates;
		string20	orig_property;
		string1		orig_bankruptcy;
		string20	orig_dls;
		string20	orig_mvs;
		string15	orig_ip_address;
	end;
    
  export rRiskwise_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rRiskwise_In;
	end;
	
	export rIDM_In := record
		string orig_transaction_id;
		string orig_dateadded;
		string orig_billingid;
		string orig_function_name;
		string orig_adl;
		string orig_fname;
		string orig_lname;
		string orig_mname;
		string orig_ssn;
		string orig_address;
		string orig_city;
		string orig_state;
		string orig_zip;
		string orig_phone;
		string orig_dob;
		string orig_dln;
		string orig_dln_st;
		string orig_glb;
		string orig_dppa;
		string orig_fcra;
	end;
	
	export rIDM_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rIDM_In;
	end;
	
	export rSBA_In := record
		string16 	transaction_id;           
		integer8 	company_id;             
		integer6 	product_id;               
		integer8 	gc_id;                  
		string20 	login_id;                 
		string30 	vertical;               
		string30 	use;                     
		string30 	industry;                 
		string20 	function_name;           
		string100 function_description;    
		string1 	transaction_type;         
		string10 	glb_purpose;            
		string10 	dppa_purpose;             
		string22 	date_added;              
		string2 	primary_market_code;      
		string2 	secondary_market_code;    
		string2 	industry_1_code;         
		string2 	industry_2_code;          
		string30 	first_name;               
		string30 	middle_name;             
		string30 	last_name;                
		string10 	suffix_name;              
		string30 	former_last_name;        
		string60 	address;                 
		string50 	city;                    
		string2 	state;                   
		string9 	zip;                      
		string20 	phone;                  
		string20 	work_phone;             
		string8 	dob;                      
		string30 	dl;                      
		string2 	dl_state;                 
		string30 	email;                   
		string9 	ssn;                     
		string64 	business_title;           
		integer8 	response_lexid;           
		string15 	ipaddr;                   
		string10 	clean_prim_range;         
		string40 	clean_prim_name;          
		string10 	clean_addr_suffix;        
		string10 	clean_postdir;            
		string15 	clean_unit_desig;        
		string10 	clean_sec_range;          
		string50 	clean_v_city_name;       
		string2 	clean_st;                
		string9 	clean_zip5;             
		string4 	clean_zip4;               
		string2 	clean_addr_rec_type;     
		string2 	clean_fips_state;        
		string3 	clean_fips_county;       
		string15 	clean_geo_lat;          
		string15 	clean_geo_long;           
		string4 	clean_cbsa;               
		string10 	clean_geo_blk;           
		string2 	clean_geo_match;         
		string5 	clean_err_stat;           
		string30 	sub_market;              
		string2 	clean_predir;            
		string30 	pii2_first_name;          
		string30 	pii2_middle_name;         
		string30 	pii2_last_name;         
		string10 	pii2_suffix_name;        
		string30 	pii2_former_last_name;   
		string60 	pii2_address;            
		string50 	pii2_city;                
		string2 	pii2_state;              
		string9 	pii2_zip;                 
		string20 	pii2_phone;              
		string20 	pii2_work_phone;         
		string8 	pii2_dob;                
		string30 	pii2_dl;                  
		string2 	pii2_dl_state;            
		string30 	pii2_email;              
		string9 	pii2_ssn;                 
		string64 	pii2_business_title;      
		integer8 	pii2_response_lexid;      
		string10 	pii2_clean_prim_range;    
		string40 	pii2_clean_prim_name;     
		string10 	pii2_clean_addr_suffix;   
		string10 	pii2_clean_postdir;       
		string15 	pii2_clean_unit_desig;    
		string10 	pii2_clean_sec_range;     
		string50 	pii2_clean_v_city_name;   
		string2 	pii2_clean_st;            
		string9 	pii2_clean_zip5;        
		string4 	pii2_clean_zip4;          
		string2 	pii2_clean_addr_rec_type; 
		string2 	pii2_clean_fips_state;   
		string3 	pii2_clean_fips_county;   
		string15 	pii2_clean_geo_lat;       
		string15 	pii2_clean_geo_long;     
		string4 	pii2_clean_cbsa;          
		string10 	pii2_clean_geo_blk;      
		string2 	pii2_clean_geo_match;    
		string5 	pii2_clean_err_stat;      
		string2 	pii2_clean_predir;        
		string30 	pii3_first_name;          
		string30 	pii3_middle_name;         
		string30 	pii3_last_name;         
		string10 	pii3_suffix_name;         
		string30 	pii3_former_last_name;    
		string60 	pii3_address;            
		string50 	pii3_city;              
		string2 	pii3_state;              
		string9 	pii3_zip;                 
		string20 	pii3_phone;              
		string20 	pii3_work_phone;         
		string8 	pii3_dob;                 
		string30 	pii3_dl;                 
		string2 	pii3_dl_state;            
		string30 	pii3_email;               
		string9 	pii3_ssn;                 
		string64 	pii3_business_title;     
		integer8 	pii3_response_lexid;      
		string10 	pii3_clean_prim_range;    
		string40 	pii3_clean_prim_name;     
		string10 	pii3_clean_addr_suffix;   
		string10 	pii3_clean_postdir;       
		string15 	pii3_clean_unit_desig;    
		string10 	pii3_clean_sec_range;    
		string50 	pii3_clean_v_city_name;   
		string2 	pii3_clean_st;            
		string9 	pii3_clean_zip5;          
		string4 	pii3_clean_zip4;          
		string2 	pii3_clean_addr_rec_type; 
		string2 	pii3_clean_fips_state;   
		string3 	pii3_clean_fips_county;   
		string15 	pii3_clean_geo_lat;      
		string15 	pii3_clean_geo_long;      
		string4 	pii3_clean_cbsa;         
		string10 	pii3_clean_geo_blk;      
		string2 	pii3_clean_geo_match;   
		string5 	pii3_clean_err_stat;     
		string2 	pii3_clean_predir;        
		string100 cmp_name;                
		string100 cmp_alt_name;             
		string60 	cmp_address;            
		string50 	cmp_city;                
		string2 	cmp_state;               
		string9 	cmp_zip;                  
		string20 	cmp_phone;               
		string20 	cmp_fax_phone;         
		string8 	cmp_bus_start_date;       
		string3 	cmp_years_in_business; 
		string9 	cmp_fein;                
		string8 	cmp_sic_code;            
		string8 	cmp_naic_code;            
		string32 	cmp_business_structure;   
		string12 	cmp_yearly_revenue;      
		integer8 	cmp_response_dotid;       
		integer8 	cmp_response_empid;       
		integer8 	cmp_response_powid;     
		integer8 	cmp_response_proxid;     
		integer8 	cmp_response_seleid;      
		integer8 	cmp_response_orgid;       
		integer8 	cmp_response_ultid;   

		string30 	pii4_first_name;    
		string30 	pii4_middle_name;         
		string30 	pii4_last_name;         
		string10 	pii4_suffix_name;         
		string30 	pii4_former_last_name;    
		string60 	pii4_address;            
		string50 	pii4_city;              
		string2 	pii4_state;              
		string9 	pii4_zip;                 
		string20 	pii4_phone;              
		string20 	pii4_work_phone;         
		string8 	pii4_dob;                 
		string30 	pii4_dl;                 
		string2 	pii4_dl_state;            
		string30 	pii4_email;               
		string9 	pii4_ssn;                 
		string64 	pii4_business_title;     
		integer8 	pii4_response_lexid;      
		string10 	pii4_clean_prim_range;    
		string40 	pii4_clean_prim_name;     
		string10 	pii4_clean_addr_suffix;   
		string10 	pii4_clean_postdir;       
		string15 	pii4_clean_unit_desig;    
		string10 	pii4_clean_sec_range;    
		string50 	pii4_clean_v_city_name;   
		string2 	pii4_clean_st;            
		string9 	pii4_clean_zip5;          
		string4 	pii4_clean_zip4;          
		string2 	pii4_clean_addr_rec_type; 
		string2 	pii4_clean_fips_state;   
		string3 	pii4_clean_fips_county;   
		string15 	pii4_clean_geo_lat;      
		string15 	pii4_clean_geo_long;      
		string4 	pii4_clean_cbsa;         
		string10 	pii4_clean_geo_blk;      
		string2 	pii4_clean_geo_match;   
		string5 	pii4_clean_err_stat;     
		string2 	pii4_clean_predir;

		string30 	pii5_first_name;          
		string30 	pii5_middle_name;         
		string30 	pii5_last_name;         
		string10 	pii5_suffix_name;         
		string30 	pii5_former_last_name;    
		string60 	pii5_address;            
		string50 	pii5_city;              
		string2 	pii5_state;              
		string9 	pii5_zip;                 
		string20 	pii5_phone;              
		string20 	pii5_work_phone;         
		string8 	pii5_dob;                 
		string30 	pii5_dl;                 
		string2 	pii5_dl_state;            
		string30 	pii5_email;               
		string9 	pii5_ssn;                 
		string64 	pii5_business_title;     
		integer8 	pii5_response_lexid;      
		string10 	pii5_clean_prim_range;    
		string40 	pii5_clean_prim_name;     
		string10 	pii5_clean_addr_suffix;   
		string10 	pii5_clean_postdir;       
		string15 	pii5_clean_unit_desig;    
		string10 	pii5_clean_sec_range;    
		string50 	pii5_clean_v_city_name;   
		string2 	pii5_clean_st;            
		string9 	pii5_clean_zip5;          
		string4 	pii5_clean_zip4;          
		string2 	pii5_clean_addr_rec_type; 
		string2 	pii5_clean_fips_state;   
		string3 	pii5_clean_fips_county;   
		string15 	pii5_clean_geo_lat;      
		string15 	pii5_clean_geo_long;      
		string4 	pii5_clean_cbsa;         
		string10 	pii5_clean_geo_blk;      
		string2 	pii5_clean_geo_match;   
		string5 	pii5_clean_err_stat;     
		string2 	pii5_clean_predir;  

		string30 	pii6_first_name;          
		string30 	pii6_middle_name;         
		string30 	pii6_last_name;         
		string10 	pii6_suffix_name;         
		string30 	pii6_former_last_name;    
		string60 	pii6_address;            
		string50 	pii6_city;              
		string2 	pii6_state;              
		string9 	pii6_zip;                 
		string20 	pii6_phone;              
		string20 	pii6_work_phone;         
		string8 	pii6_dob;                 
		string30 	pii6_dl;                 
		string2 	pii6_dl_state;            
		string30 	pii6_email;               
		string9 	pii6_ssn;                 
		string64 	pii6_business_title;     
		integer8 	pii6_response_lexid;      
		string10 	pii6_clean_prim_range;    
		string40 	pii6_clean_prim_name;     
		string10 	pii6_clean_addr_suffix;   
		string10 	pii6_clean_postdir;       
		string15 	pii6_clean_unit_desig;    
		string10 	pii6_clean_sec_range;    
		string50 	pii6_clean_v_city_name;   
		string2 	pii6_clean_st;            
		string9 	pii6_clean_zip5;          
		string4 	pii6_clean_zip4;          
		string2 	pii6_clean_addr_rec_type; 
		string2 	pii6_clean_fips_state;   
		string3 	pii6_clean_fips_county;   
		string15 	pii6_clean_geo_lat;      
		string15 	pii6_clean_geo_long;      
		string4 	pii6_clean_cbsa;         
		string10 	pii6_clean_geo_blk;      
		string2 	pii6_clean_geo_match;   
		string5 	pii6_clean_err_stat;     
		string2 	pii6_clean_predir; 

		string30 	pii7_first_name;          
		string30 	pii7_middle_name;         
		string30 	pii7_last_name;         
		string10 	pii7_suffix_name;         
		string30 	pii7_former_last_name;    
		string60 	pii7_address;            
		string50 	pii7_city;              
		string2 	pii7_state;              
		string9 	pii7_zip;                 
		string20 	pii7_phone;              
		string20 	pii7_work_phone;         
		string8 	pii7_dob;                 
		string30 	pii7_dl;                 
		string2 	pii7_dl_state;            
		string30 	pii7_email;               
		string9 	pii7_ssn;                 
		string64 	pii7_business_title;     
		integer8 	pii7_response_lexid;      
		string10 	pii7_clean_prim_range;    
		string40 	pii7_clean_prim_name;     
		string10 	pii7_clean_addr_suffix;   
		string10 	pii7_clean_postdir;       
		string15 	pii7_clean_unit_desig;    
		string10 	pii7_clean_sec_range;    
		string50 	pii7_clean_v_city_name;   
		string2 	pii7_clean_st;            
		string9 	pii7_clean_zip5;          
		string4 	pii7_clean_zip4;          
		string2 	pii7_clean_addr_rec_type; 
		string2 	pii7_clean_fips_state;   
		string3 	pii7_clean_fips_county;   
		string15 	pii7_clean_geo_lat;      
		string15 	pii7_clean_geo_long;      
		string4 	pii7_clean_cbsa;         
		string10 	pii7_clean_geo_blk;      
		string2 	pii7_clean_geo_match;   
		string5 	pii7_clean_err_stat;     
		string2 	pii7_clean_predir;

		string30 	pii8_first_name;          
		string30 	pii8_middle_name;         
		string30 	pii8_last_name;         
		string10 	pii8_suffix_name;         
		string30 	pii8_former_last_name;    
		string60 	pii8_address;            
		string50 	pii8_city;              
		string2 	pii8_state;              
		string9 	pii8_zip;                 
		string20 	pii8_phone;              
		string20 	pii8_work_phone;         
		string8 	pii8_dob;                 
		string30 	pii8_dl;                 
		string2 	pii8_dl_state;            
		string30 	pii8_email;               
		string9 	pii8_ssn;                 
		string64 	pii8_business_title;     
		integer8 	pii8_response_lexid;      
		string10 	pii8_clean_prim_range;    
		string40 	pii8_clean_prim_name;     
		string10 	pii8_clean_addr_suffix;   
		string10 	pii8_clean_postdir;       
		string15 	pii8_clean_unit_desig;    
		string10 	pii8_clean_sec_range;    
		string50 	pii8_clean_v_city_name;   
		string2 	pii8_clean_st;            
		string9 	pii8_clean_zip5;          
		string4 	pii8_clean_zip4;          
		string2 	pii8_clean_addr_rec_type; 
		string2 	pii8_clean_fips_state;   
		string3 	pii8_clean_fips_county;   
		string15 	pii8_clean_geo_lat;      
		string15 	pii8_clean_geo_long;      
		string4 	pii8_clean_cbsa;         
		string10 	pii8_clean_geo_blk;      
		string2 	pii8_clean_geo_match;   
		string5 	pii8_clean_err_stat;     
		string2 	pii8_clean_predir;
	end;
	
  export rSBA_In_Ext := record
		unsigned1 src_id;
    unsigned4 filedate;
    unsigned4 vendor_f_rpt_date;
    unsigned4 vendor_l_rpt_date;
    rSBA_In;
	end;
    
	export rSBA_Base := record
  unsigned1 src_id;
  unsigned4 filedate;
  
  string16 transaction_id; 
  string22 datetime;   

  string100 cmp_name;                
  string60 cmp_address;            
  string50 cmp_city;                
  string2 cmp_state;               
  string9 cmp_zip;                  
  string20 cmp_phone;      

  string20 	cmp_fax_number;         
  string9 	cmp_fein;                
  string8 	cmp_sic_code;            
  string8 	cmp_naic_code;            
  string32 	cmp_business_structure;   
  string3 	cmp_years_in_business; 
  string8 	cmp_bus_start_date;       
  string12 	cmp_yearly_revenue;
  string100 cmp_alt_name;

  string30 first_name;          
  string30 middle_name;         
  string30 last_name;         
  string10 suffix_name;         
  string30 former_last_name;    
  string60 address;            
  string50 city;              
  string2 state;              
  string9 zip;                 
  string20 phone;              
  string20 work_phone;         
  string8 dob;                 
  string30 dl;                 
  string2 dl_state;            
  string30 email;               
  string9 ssn;                 
  string64 business_title;     
  integer8 response_lexid; 
  string30 clean_first_name;          
  string30 clean_middle_name;         
  string30 clean_last_name;         
  string10 clean_suffix_name;       
  string10 clean_prim_range;    
  string40 clean_prim_name;     
  string10 clean_addr_suffix;   
  string10 clean_postdir;       
  string15 clean_unit_desig;    
  string10 clean_sec_range;    
  string50 clean_v_city_name;   
  string2 clean_st;            
  string9 clean_zip5;          
  string4 clean_zip4;          
  string2 clean_addr_rec_type; 
  string2 clean_fips_state;   
  string3 clean_fips_county;   
  string15 clean_geo_lat;      
  string15 clean_geo_long;      
  string4 clean_cbsa;         
  string10 clean_geo_blk;      
  string2 clean_geo_match;   
  string5 clean_err_stat;     
  string2 clean_predir;

  string30 pii2_first_name;          
  string30 pii2_middle_name;         
  string30 pii2_last_name;         
  string10 pii2_suffix_name;        
  string30 pii2_former_last_name;   
  string60 pii2_address;            
  string50 pii2_city;                
  string2 pii2_state;              
  string9 pii2_zip;                 
  string20 pii2_phone;              
  string20 pii2_work_phone;         
  string8 pii2_dob;                
  string30 pii2_dl;                  
  string2 pii2_dl_state;            
  string30 pii2_email;              
  string9 pii2_ssn;                 
  string64 pii2_business_title;      
  integer8 pii2_response_lexid; 
  string30 pii2_clean_first_name;          
  string30 pii2_clean_middle_name;         
  string30 pii2_clean_last_name;         
  string10 pii2_clean_suffix_name;       
  string10 pii2_clean_prim_range;    
  string40 pii2_clean_prim_name;     
  string10 pii2_clean_addr_suffix;   
  string10 pii2_clean_postdir;       
  string15 pii2_clean_unit_desig;    
  string10 pii2_clean_sec_range;     
  string50 pii2_clean_v_city_name;   
  string2 pii2_clean_st;            
  string9 pii2_clean_zip5;        
  string4 pii2_clean_zip4;          
  string2 pii2_clean_addr_rec_type; 
  string2 pii2_clean_fips_state;   
  string3 pii2_clean_fips_county;   
  string15 pii2_clean_geo_lat;       
  string15 pii2_clean_geo_long;     
  string4 pii2_clean_cbsa;          
  string10 pii2_clean_geo_blk;      
  string2 pii2_clean_geo_match;    
  string5 pii2_clean_err_stat;      
  string2 pii2_clean_predir;        
  string30 pii3_first_name;          
  string30 pii3_middle_name;         
  string30 pii3_last_name;         
  string10 pii3_suffix_name;         
  string30 pii3_former_last_name;    
  string60 pii3_address;            
  string50 pii3_city;              
  string2 pii3_state;              
  string9 pii3_zip;                 
  string20 pii3_phone;              
  string20 pii3_work_phone;         
  string8 pii3_dob;                 
  string30 pii3_dl;                 
  string2 pii3_dl_state;            
  string30 pii3_email;               
  string9 pii3_ssn;                 
  string64 pii3_business_title;     
  integer8 pii3_response_lexid; 
  string30 pii3_clean_first_name;          
  string30 pii3_clean_middle_name;         
  string30 pii3_clean_last_name;         
  string10 pii3_clean_suffix_name;       
  string10 pii3_clean_prim_range;    
  string40 pii3_clean_prim_name;     
  string10 pii3_clean_addr_suffix;   
  string10 pii3_clean_postdir;       
  string15 pii3_clean_unit_desig;    
  string10 pii3_clean_sec_range;    
  string50 pii3_clean_v_city_name;   
  string2 pii3_clean_st;            
  string9 pii3_clean_zip5;          
  string4 pii3_clean_zip4;          
  string2 pii3_clean_addr_rec_type; 
  string2 pii3_clean_fips_state;   
  string3 pii3_clean_fips_county;   
  string15 pii3_clean_geo_lat;      
  string15 pii3_clean_geo_long;      
  string4 pii3_clean_cbsa;         
  string10 pii3_clean_geo_blk;      
  string2 pii3_clean_geo_match;   
  string5 pii3_clean_err_stat;     
  string2 pii3_clean_predir;   

  string30 pii4_first_name;          
  string30 pii4_middle_name;         
  string30 pii4_last_name;         
  string10 pii4_suffix_name;         
  string30 pii4_former_last_name;    
  string60 pii4_address;            
  string50 pii4_city;              
  string2 pii4_state;              
  string9 pii4_zip;                 
  string20 pii4_phone;              
  string20 pii4_work_phone;         
  string8 pii4_dob;                 
  string30 pii4_dl;                 
  string2 pii4_dl_state;            
  string30 pii4_email;               
  string9 pii4_ssn;                 
  string64 pii4_business_title;     
  integer8 pii4_response_lexid; 
  string30 pii4_clean_first_name;          
  string30 pii4_clean_middle_name;         
  string30 pii4_clean_last_name;         
  string10 pii4_clean_suffix_name;       
  string10 pii4_clean_prim_range;    
  string40 pii4_clean_prim_name;     
  string10 pii4_clean_addr_suffix;   
  string10 pii4_clean_postdir;       
  string15 pii4_clean_unit_desig;    
  string10 pii4_clean_sec_range;    
  string50 pii4_clean_v_city_name;   
  string2 pii4_clean_st;            
  string9 pii4_clean_zip5;          
  string4 pii4_clean_zip4;          
  string2 pii4_clean_addr_rec_type; 
  string2 pii4_clean_fips_state;   
  string3 pii4_clean_fips_county;   
  string15 pii4_clean_geo_lat;      
  string15 pii4_clean_geo_long;      
  string4 pii4_clean_cbsa;         
  string10 pii4_clean_geo_blk;      
  string2 pii4_clean_geo_match;   
  string5 pii4_clean_err_stat;     
  string2 pii4_clean_predir;

  string30 pii5_first_name;          
  string30 pii5_middle_name;         
  string30 pii5_last_name;         
  string10 pii5_suffix_name;         
  string30 pii5_former_last_name;    
  string60 pii5_address;            
  string50 pii5_city;              
  string2 pii5_state;              
  string9 pii5_zip;                 
  string20 pii5_phone;              
  string20 pii5_work_phone;         
  string8 pii5_dob;                 
  string30 pii5_dl;                 
  string2 pii5_dl_state;            
  string30 pii5_email;               
  string9 pii5_ssn;                 
  string64 pii5_business_title;     
  integer8 pii5_response_lexid; 
  string30 pii5_clean_first_name;          
  string30 pii5_clean_middle_name;         
  string30 pii5_clean_last_name;         
  string10 pii5_clean_suffix_name;       
  string10 pii5_clean_prim_range;    
  string40 pii5_clean_prim_name;     
  string10 pii5_clean_addr_suffix;   
  string10 pii5_clean_postdir;       
  string15 pii5_clean_unit_desig;    
  string10 pii5_clean_sec_range;    
  string50 pii5_clean_v_city_name;   
  string2 pii5_clean_st;            
  string9 pii5_clean_zip5;          
  string4 pii5_clean_zip4;          
  string2 pii5_clean_addr_rec_type; 
  string2 pii5_clean_fips_state;   
  string3 pii5_clean_fips_county;   
  string15 pii5_clean_geo_lat;      
  string15 pii5_clean_geo_long;      
  string4 pii5_clean_cbsa;         
  string10 pii5_clean_geo_blk;      
  string2 pii5_clean_geo_match;   
  string5 pii5_clean_err_stat;     
  string2 pii5_clean_predir;

  string30 pii6_first_name;          
  string30 pii6_middle_name;         
  string30 pii6_last_name;         
  string10 pii6_suffix_name;         
  string30 pii6_former_last_name;    
  string60 pii6_address;            
  string50 pii6_city;              
  string2 pii6_state;              
  string9 pii6_zip;                 
  string20 pii6_phone;              
  string20 pii6_work_phone;         
  string8 pii6_dob;                 
  string30 pii6_dl;                 
  string2 pii6_dl_state;            
  string30 pii6_email;               
  string9 pii6_ssn;                 
  string64 pii6_business_title;     
  integer8 pii6_response_lexid; 
  string30 pii6_clean_first_name;          
  string30 pii6_clean_middle_name;         
  string30 pii6_clean_last_name;         
  string10 pii6_clean_suffix_name;       
  string10 pii6_clean_prim_range;    
  string40 pii6_clean_prim_name;     
  string10 pii6_clean_addr_suffix;   
  string10 pii6_clean_postdir;       
  string15 pii6_clean_unit_desig;    
  string10 pii6_clean_sec_range;    
  string50 pii6_clean_v_city_name;   
  string2 pii6_clean_st;            
  string9 pii6_clean_zip5;          
  string4 pii6_clean_zip4;          
  string2 pii6_clean_addr_rec_type; 
  string2 pii6_clean_fips_state;   
  string3 pii6_clean_fips_county;   
  string15 pii6_clean_geo_lat;      
  string15 pii6_clean_geo_long;      
  string4 pii6_clean_cbsa;         
  string10 pii6_clean_geo_blk;      
  string2 pii6_clean_geo_match;   
  string5 pii6_clean_err_stat;     
  string2 pii6_clean_predir;  

  string30 pii7_first_name;          
  string30 pii7_middle_name;         
  string30 pii7_last_name;         
  string10 pii7_suffix_name;         
  string30 pii7_former_last_name;    
  string60 pii7_address;            
  string50 pii7_city;              
  string2 pii7_state;              
  string9 pii7_zip;                 
  string20 pii7_phone;              
  string20 pii7_work_phone;         
  string8 pii7_dob;                 
  string30 pii7_dl;                 
  string2 pii7_dl_state;            
  string30 pii7_email;               
  string9 pii7_ssn;                 
  string64 pii7_business_title;     
  integer8 pii7_response_lexid; 
  string30 pii7_clean_first_name;          
  string30 pii7_clean_middle_name;         
  string30 pii7_clean_last_name;         
  string10 pii7_clean_suffix_name;       
  string10 pii7_clean_prim_range;    
  string40 pii7_clean_prim_name;     
  string10 pii7_clean_addr_suffix;   
  string10 pii7_clean_postdir;       
  string15 pii7_clean_unit_desig;    
  string10 pii7_clean_sec_range;    
  string50 pii7_clean_v_city_name;   
  string2 pii7_clean_st;            
  string9 pii7_clean_zip5;          
  string4 pii7_clean_zip4;          
  string2 pii7_clean_addr_rec_type; 
  string2 pii7_clean_fips_state;   
  string3 pii7_clean_fips_county;   
  string15 pii7_clean_geo_lat;      
  string15 pii7_clean_geo_long;      
  string4 pii7_clean_cbsa;         
  string10 pii7_clean_geo_blk;      
  string2 pii7_clean_geo_match;   
  string5 pii7_clean_err_stat;     
  string2 pii7_clean_predir;  

  string30 pii8_first_name;          
  string30 pii8_middle_name;         
  string30 pii8_last_name;         
  string10 pii8_suffix_name;         
  string30 pii8_former_last_name;    
  string60 pii8_address;            
  string50 pii8_city;              
  string2 pii8_state;              
  string9 pii8_zip;                 
  string20 pii8_phone;              
  string20 pii8_work_phone;         
  string8 pii8_dob;                 
  string30 pii8_dl;                 
  string2 pii8_dl_state;            
  string30 pii8_email;               
  string9 pii8_ssn;                 
  string64 pii8_business_title;     
  integer8 pii8_response_lexid; 
  string30 pii8_clean_first_name;          
  string30 pii8_clean_middle_name;         
  string30 pii8_clean_last_name;         
  string10 pii8_clean_suffix_name;       
  string10 pii8_clean_prim_range;    
  string40 pii8_clean_prim_name;     
  string10 pii8_clean_addr_suffix;   
  string10 pii8_clean_postdir;       
  string15 pii8_clean_unit_desig;    
  string10 pii8_clean_sec_range;    
  string50 pii8_clean_v_city_name;   
  string2 pii8_clean_st;            
  string9 pii8_clean_zip5;          
  string4 pii8_clean_zip4;          
  string2 pii8_clean_addr_rec_type; 
  string2 pii8_clean_fips_state;   
  string3 pii8_clean_fips_county;   
  string15 pii8_clean_geo_lat;      
  string15 pii8_clean_geo_long;      
  string4 pii8_clean_cbsa;         
  string10 pii8_clean_geo_blk;      
  string2 pii8_clean_geo_match;   
  string5 pii8_clean_err_stat;     
  string2 pii8_clean_predir; 
	end;
	
	export mbslayout := record
		string	Company_ID := '';
		string	Global_Company_ID := '';
	end;

	export allowlayout := record
		unsigned8	AllowFlags := 0;
	end;

	export businfolayout := record
		string	Primary_Market_Code;
		string	Secondary_Market_Code;
		string	Industry_1_Code;
		string	Industry_2_Code;
		string	Sub_market;
		string	Vertical;
		string	Use := ''; // banko only - additional vertical information
		string	Industry; 
	end;

	export InputPersonDataLayout := record
		string	Full_Name := '';
		string	First_Name := '';
		string	Middle_Name := '';
		string	Last_Name := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Personal_Phone := '';
		string	Work_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := ''; // unique id
		string	Email_Address := '';
		string	SSN := '';
		string	LinkID := '';
		string	IPAddr := '';
	end;

	export CleanPersonDataLayout := record
		standard.Name - name_score;
		standard.Addr;
		string	Personal_Phone := '';
		string	Work_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := ''; // unique id
		string	Email_Address := '';
		string	SSN := '';
		string	LinkID := '';
		string	IPAddr := '';
		string		Appended_SSN := '';
		unsigned6	Appended_ADL := 0;
	end;

	export PersonDataLayout := record
		string	Full_Name := '';
		string	First_Name := '';
		string	Middle_Name := '';
		string	Last_Name := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Personal_Phone := '';
		string	Work_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := ''; // unique id
		string	Email_Address := '';
		string	SSN := '';
		string	LinkID := '';
		string	IPAddr := '';
		standard.Name - name_score;
		standard.Addr;
		string	Appended_SSN := '';
		unsigned6	Appended_ADL := 0;
	end;

	export InputBusDataLayout := record
		string	CName := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Company_Phone := '';
		string	EIN := ''; // unique id
		string	Charter_Number := ''; // unique id
		string	UCC_Number := '';  // unique id - doc number
		string	Domain_Name := ''; // unique id
	end;

	export CleanBusDataLayout := record
		string CName := '';
		standard.Addr;
		string	Company_Phone := '';
		string	EIN := ''; // unique id
		string	Charter_Number := ''; // unique id
		string	UCC_Number := '';  // unique id - doc number
		string	Domain_Name := ''; // unique id
		unsigned6	Appended_BDID := 0;
		string		Appended_EIN := '';
	end;

	export BusDataLayout := record
		string	CName := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Company_Phone := '';
		string	EIN := ''; // unique id
		string	Charter_Number := ''; // unique id
		string	UCC_Number := '';  // unique id - doc number
		string	Domain_Name := ''; // unique id
		standard.Addr;
		unsigned6	Appended_BDID := 0;
		string	Appended_EIN := '';
	end;

	export InputBusUserDataLayout := record
		string	First_Name := '';
		string	Middle_Name := '';
		string	Last_Name := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Personal_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := '';
		string	SSN := '';
	end;

	export CleanBusUserDataLayout := record
		standard.Name - name_score;
		standard.Addr;
		string	Personal_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := '';
		string	SSN := '';
		string		Appended_SSN := '';
		unsigned6	Appended_ADL := 0;
	end;

	export BusUserDataLayout := record
		string	First_Name := '';
		string	Middle_Name := '';
		string	Last_Name := '';
		string	Address := '';
		string	City := '';
		string	State := '';
		string	Zip := '';
		string	Personal_Phone := '';
		string	DOB := '';
		string	DL := ''; // unique id
		string	DL_St := '';
		string	SSN := '';
		standard.Name - name_score;
		standard.Addr;
		string		Appended_SSN := '';
		unsigned6	Appended_ADL := 0;
		
	end;

	export PermissableLayout := record
		string	GLB_purpose := '';
		string	DPPA_purpose := '';
		string	FCRA_purpose := '';
	end;

	export searchlayout := record
		string	DateTime := '';
		string	Start_Monitor := '';
		string	Stop_Monitor := '';
		string	Login_History_ID := '';
		string	Transaction_ID := '';
		string	Sequence_Number := '';
		string	Method := '';
		string	Product_Code := '';
		string	Transaction_Type := '';
		string	Function_Description := '';
		string	IPAddr := '';
	end;

	// BIID2.0 - SBFE Implementation
	export BusDataLayoutPlus := record
		BusDataLayout;
		string20 	fax_phone;         
		string8 	sic_code;            
		string8 	naic_code;            
		string32 	business_structure;   
		string3 	years_in_business; 
		string8 	bus_start_date;       
		string12 	yearly_revenue; 
	end;

	export BusUserDataLayoutPlus := record
		BusUserDataLayout;
		string100 cmp_name;                
		string9   cmp_fein;   	
	end;

	export Common := record
		mbslayout 				MBS;
		allowlayout 			Allow_Flags;
		businfolayout 		Bus_Intel;
		PersonDataLayout  Person_Q;
		BusDataLayout 		Bus_Q;
		BusUserDataLayout BusUser_Q;
		PermissableLayout Permissions;
		SearchLayout 		 	Search_Info;
	end;

	export Common_ThorAdditions := record
		Common;
		string  source               :='';
		string3 fraudpoint_score     :='';
		string  orig_RECORD_COUNT    :='';
		string	orig_PRICE 				   :='';
		string	orig_REPORT_OPTIONS  :='';
		string  orig_function_name	 :='';
    string100 country        		 := '';
    string9 version              := '';
		unsigned4 filedate   ;
	end;

	export Common_ThorAdditions_non_FCRA:=record
		Common;
		string  source               :='';
		string3 fraudpoint_score     :='';
	end;

	export Common_ThorAdditions_FCRA := record
		Common;
		string    source               :='';
		unsigned8 persistent_record_id := 0;
	end;

	export Common_indexes := record
		{Common_ThorAdditions_non_FCRA}-source-bus_q-bususer_q;
	end;

	export Common_indexes_DID_SBA := record
		mbslayout 				 			MBS;
		allowlayout 			 			Allow_Flags;
		businfolayout 		 			Bus_Intel;
		PersonDataLayout  			Person_Q;
		BusUserDataLayoutPlus	BusUser_Q2;
		BusUserDataLayoutPlus	BusUser_Q3;
		BusUserDataLayoutPlus	BusUser_Q4;
		BusUserDataLayoutPlus	BusUser_Q5;
		BusUserDataLayoutPlus	BusUser_Q6;
		BusUserDataLayoutPlus	BusUser_Q7;
		BusUserDataLayoutPlus	BusUser_Q8;
		PermissableLayout 			Permissions;
		SearchLayout 		 			Search_Info;
		string3   							fraudpoint_score :='';
	end;

	export Common_indexes_FCRA := record
		{Common};
	end;

	export Common_Indexes_FCRA_DID_SBA := record	 
		mbslayout 				 		MBS;
		allowlayout 			 		Allow_Flags;
		businfolayout 		 		Bus_Intel;
		PersonDataLayout  		Person_Q;
		BusDataLayout 		 		Bus_Q;
		BusUserDataLayoutPlus	BusUser_Q;
		BusUserDataLayoutPlus	BusUser_Q2;
		BusUserDataLayoutPlus	BusUser_Q3;
		BusUserDataLayoutPlus	BusUser_Q4;
		BusUserDataLayoutPlus	BusUser_Q5;
		BusUserDataLayoutPlus	BusUser_Q6;
		BusUserDataLayoutPlus	BusUser_Q7;
		BusUserDataLayoutPlus	BusUser_Q8;
		PermissableLayout 		Permissions;
		SearchLayout 		 			Search_Info;
	end;
	
	
	export Common_layout := record, maxlength(10000)
		STRING	SOURCE_FILE;
		STRING	SOURCE_INPUT := '';
		STRING	PERSON_ORIG_IP_ADDRESS1 ;
		STRING	ORIG_IP_ADDRESS2;

		STRING	ORIG_COMPANY_NAME1;
		STRING1 CNAMETYPE := '';
		STRING	CLEAN_CNAME1;
		STRING	ORIG_COMPANY_NAME2;
		STRING	CLEAN_CNAME2;

		STANDARD.NAME;				
		STRING	ORIG_FULL_NAME1;
		STRING1	NAMETYPE := '';
		STRING	ORIG_FULL_NAME2;
		STRING	ORIG_FNAME;
		STRING	ORIG_MNAME;
		STRING	ORIG_LNAME;
		STRING	ORIG_NAMESUFFIX;
		STRING	CLEAN_NAME;
			
		STANDARD.ADDR;
		STRING	ORIG_ADDR1;
		STRING	ORIG_LASTLINE1;
		STRING	ORIG_CITY1;
		STRING	ORIG_STATE1;
		STRING	ORIG_ZIP1;
		STRING	CLEAN_ADDR1;
		STRING	ORIG_ADDR2;
		STRING	ORIG_LASTLINE2;
		STRING	ORIG_CITY2;
		STRING	ORIG_STATE2;
		STRING	ORIG_ZIP2;
		STRING	CLEAN_ADDR2 := '';
		
		STRING	PERSONAL_PHONE,
		STRING	WORK_PHONE,
		STRING	COMPANY_PHONE,			
		STRING	EMAIL_ADDRESS;
		STRING	SSN,
		STRING	DOB,
		STRING	DL,
		STRING	DL_STATE,
		STRING	DOMAIN_NAME,
		STRING	EIN,
		STRING	CHARTER_NUMBER,
		STRING	UCC_NUMBER,
		STRING	LINKID,
		
		UNSIGNED6	APPENDADL := 0;
		UNSIGNED6	APPENDBDID := 0;
		STRING	APPENDTAXID := '';
		STRING	APPENDSSN := '';

		STRING	ORIG_COMPANY_ID;
		STRING	ORIG_GLOBAL_COMPANY_ID;
		STRING	BILLING_ID;
		STRING	PID;
		MBSLAYOUT;
		BUSINFOLAYOUT;
		PERMISSABLELAYOUT;
		ALLOWLAYOUT;
		SEARCHLAYOUT;
		string orig_function_name;
		string description;
		
		STRING	REPFLAG, 
		STRING	JOB_ID;
		
		STRING50	ORIG_REFERENCE_CODE;
		STRING		ORIG_TRANSACTION_CODE; /* Transaction Type */

		STRING	ORIG_SOURCE_CODE := '';
		STRING3 fraudpoint_score  :='';
		
		string  orig_RECORD_COUNT   :='';
		string	orig_PRICE					:='';
		string	orig_REPORT_OPTIONS :='';
    
    string100 country;
    unsigned4 filedate;		
		
	end;
    
  export Common_SBA := record
   mbslayout 				 			MBS;
   allowlayout 			 			Allow_Flags;
   businfolayout 		 			Bus_Intel;
   PersonDataLayout  			Person_Q;
   BusDataLayoutPlus 			Bus_Q;
   BusUserDataLayoutPlus	BusUser_Q;
   BusUserDataLayoutPlus	BusUser_Q2;
   BusUserDataLayoutPlus	BusUser_Q3;
   BusUserDataLayoutPlus	BusUser_Q4;
   BusUserDataLayoutPlus	BusUser_Q5;
   BusUserDataLayoutPlus	BusUser_Q6;
   BusUserDataLayoutPlus	BusUser_Q7;
   BusUserDataLayoutPlus	BusUser_Q8;
   PermissableLayout			Permissions;
   SearchLayout 		 			Search_Info;
 end;
    
 export Common_ThorAdditions_SBA := record
   Common_SBA;
   string    source               :='';
   string3   fraudpoint_score     :='';
 end;

END;

