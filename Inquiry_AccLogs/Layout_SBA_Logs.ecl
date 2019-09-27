﻿EXPORT Layout_SBA_logs := module
 
export input_raw := record

string16 transaction_id;           
integer8 company_id;             
integer6 product_id;               
integer8 gc_id;                  
string20 login_id;                 
string30 vertical;               
string30 use;                     
string30 industry;                 
string20 function_name;           
string100 function_description;    
string1 transaction_type;         
string10 glb_purpose;            
string10 dppa_purpose;             
string22 date_added;              
string2 primary_market_code;      
string2 secondary_market_code;    
string2 industry_1_code;         
string2 industry_2_code;          
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
string15 ipaddr;                   
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
string30 sub_market;              
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
string100 cmp_name;                
string100 cmp_alt_name;             
string60 cmp_address;            
string50 cmp_city;                
string2 cmp_state;               
string9 cmp_zip;                  
string20 cmp_phone;               
string20 cmp_fax_phone;         
string8 cmp_bus_start_date;       
string3 cmp_years_in_business; 
string9 cmp_fein;                
string8 cmp_sic_code;            
string8 cmp_naic_code;            
string32 cmp_business_structure;   
string12 cmp_yearly_revenue;      
integer8 cmp_response_dotid;       
integer8 cmp_response_empid;       
integer8 cmp_response_powid;     
integer8 cmp_response_proxid;     
integer8 cmp_response_seleid;      
integer8 cmp_response_orgid;       
integer8 cmp_response_ultid;   

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

export common := record

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

end;