IMPORT address,AID;

EXPORT layouts := MODULE
	
	export Accurint_In := RECORD,maxlength(250000)
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
	
	export Custom_In := Accurint_In;
	
	export Banko_In := record, maxlength(10000)
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
	
	export Batch_In := record, maxlength(10000)
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
	end;
	
	export Bridger_In := record
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
	
	export IDM_In := record
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
	
	export SBA_In := record
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
	
	export Riskwise_In := record
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
	
	export BatchR3_In := record
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
		string null := '',
	end;
	
	export Accurint_Base := record
		string t;
	end;
	
	export Custom_Base := record
		string t;
	end;
	
	export Banko_Base := record
		string t;
	end;
	
	export Batch_Base := record
		string t;
	end;
	
	export BatchR3_Base := record
		string t;
	end;
	
	export Bridger_Base := record
		string t;
	end;
	
	export Riskwise_Base := record
		string t;
	end;
	
	export IDM_Base := record
		string t;
	end;
	
	export SBA_Base := record
		string t;
	end;	
	
END;

