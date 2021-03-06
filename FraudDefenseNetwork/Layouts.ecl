import Address , bipv2, Inquiry_Acclogs, corrections;
EXPORT Layouts := 
module

	export Input := 
  module
		export AFI   := 
		  record ,maxLength(10000)
  string source_file;
  string source_input;
  string person_orig_ip_address1;
  string orig_ip_address2;
  string orig_company_name1;
  string1 cnametype;
  string clean_cname1;
  string orig_company_name2;
  string clean_cname2;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string orig_full_name1;
  string1 nametype;
  string orig_full_name2;
  string orig_fname;
  string orig_mname;
  string orig_lname;
  string orig_namesuffix;
  string clean_name;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 addr_rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string orig_addr1;
  string orig_lastline1;
  string orig_city1;
  string orig_state1;
  string orig_zip1;
  string clean_addr1;
  string orig_addr2;
  string orig_lastline2;
  string orig_city2;
  string orig_state2;
  string orig_zip2;
  string clean_addr2;
  string personal_phone;
  string work_phone;
  string company_phone;
  string email_address;
  string ssn;
  string dob;
  string dl;
  string dl_state;
  string domain_name;
  string ein;
  string charter_number;
  string ucc_number;
  string linkid;
  unsigned6 appendadl;
  unsigned6 appendbdid;
  string appendtaxid;
  string appendssn;
  string orig_company_id;
  string orig_global_company_id;
  string billing_id;
  string pid;
  string company_id;
  string global_company_id;
  string primary_market_code;
  string secondary_market_code;
  string industry_1_code;
  string industry_2_code;
  string sub_market;
  string vertical;
  string use;
  string industry;
  string glb_purpose;
  string dppa_purpose;
  string fcra_purpose;
  unsigned8 allowflags;
  string datetime;
  string start_monitor;
  string stop_monitor;
  string login_history_id;
  string transaction_id;
  string sequence_number;
  string method;
  string product_code;
  string transaction_type;
  string function_description;
  string ipaddr;
  string orig_function_name;
  string description;
  string repflag;
  string job_id;
  string50 orig_reference_code;
  string orig_transaction_code;
  string orig_source_code;
  string3 fraudpoint_score;
 END;
 
 export SuspectIP  := record
  string  orig_date;
  string  orig_ip;
  string  orig_country;
  string  orig_state;
  string  orig_city;
  string  orig_isp;
 end;
 
  Export Glb5  := 
	record, maxlength(250000)
  string source_file;
  string source_input;
  string person_orig_ip_address1;
  string orig_ip_address2;
  string orig_company_name1;
  string1 cnametype;
  string clean_cname1;
  string orig_company_name2;
  string clean_cname2;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string orig_full_name1;
  string1 nametype;
  string orig_full_name2;
  string orig_fname;
  string orig_mname;
  string orig_lname;
  string orig_namesuffix;
  string clean_name;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 addr_rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string orig_addr1;
  string orig_lastline1;
  string orig_city1;
  string orig_state1;
  string orig_zip1;
  string clean_addr1;
  string orig_addr2;
  string orig_lastline2;
  string orig_city2;
  string orig_state2;
  string orig_zip2;
  string clean_addr2;
  string personal_phone;
  string work_phone;
  string company_phone;
  string email_address;
  string ssn;
  string dob;
  string dl;
  string dl_state;
  string domain_name;
  string ein;
  string charter_number;
  string ucc_number;
  string linkid;
  unsigned6 appendadl;
  unsigned6 appendbdid;
  string appendtaxid;
  string appendssn;
  string orig_company_id;
  string orig_global_company_id;
  string billing_id;
  string pid;
  string company_id;
  string global_company_id;
  string primary_market_code;
  string secondary_market_code;
  string industry_1_code;
  string industry_2_code;
  string sub_market;
  string vertical;
  string use;
  string industry;
  string glb_purpose;
  string dppa_purpose;
  string fcra_purpose;
  unsigned8 allowflags;
  string datetime;
  string start_monitor;
  string stop_monitor;
  string login_history_id;
  string transaction_id;
  string sequence_number;
  string method;
  string product_code;
  string transaction_type;
  string function_description;
  string ipaddr;
  string orig_function_name;
  string description;
  string repflag;
  string job_id;
  string50 orig_reference_code;
  string orig_transaction_code;
  string orig_source_code;
  string3 fraudpoint_score;
end;	
// Tiger 
	Export Tiger := 
	  record

		string App_Number;
		string Loan_Number;
		string Primary_Fraud_Code;
		string Location_Identifier;
		string FIRST_NAME;
		string MID_NAME;
		string LAST_NAME;
		string HOME_PHONE;
		string CELL_PHONE;
		string SSN;
		string EMAIL;
		string OWN_RENT_OTHER;
		string CUST_ID_TYPE;
		string CUST_ID_NUM;
		string CUST_ID_SOURCE;
		string DOB;
		string App_Source;
		string app_date;
		string IP_ADDRESS;
		string ADDRESS1;
		string CITY;
		string STATE;
		string ZIPCODE;
		string NET_INCOME;
		string FP1_Score;
		string FP2_Score;

	end;
// CFNA
 Export CFNA := 
   record
		string customer_ID;
		string vendor_ID;
		unsigned6 appended_LexID;
		string Date_Fraud_Reported_LN;
		string first_name;
		string middle_name;
		string Last_name;
		string suffix;
		string street_address;
		string city;
		string state;
		string zip_code;
		string10 Phone_Number;
		string9 SSN;
		string8 DOB;
		string Driver_License_Number;
		string Driver_License_State;
		string50 IP_Address;
		string50 Email_Address;
		string Device_Identification;
		string Device_identification_Provider;
		string Origination_Channel;
		string Income;
		string Own_or_Rent;
		string Location_Identifier;
		string Other_Application_Identifier;
		string Other_Application_Identifier2;
		string Other_Application_Identifier3;
		string Date_Application;
		string Time_Application;
		string Application_ID;
		string FraudPoint_Score;
		string Date_Fraud_Detected;
		string Financial_Loss;
		string Gross_Fraud_Dollar_Loss;
		string Application_Fraud;
		string Primary_Fraud_Code;
		string Secondary_Fraud_Code;
		string Source_Identifier;
		string LN_Product_ID;
		string LN_Sub_Product_ID;
		string Industry;
		string Fraud_Index_Type;
end;

Export  AInspection     := 

	RECORD,maxlength(8192)
  string8 dt_first_reported;
  string8 dt_last_reported;
  string address;
  string suffix;
  string city;
  string state;
  string zip_code;
  string comments;
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
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned8 raw_aid;
  unsigned8 ace_aid;
 END; 
 
Export TextMinedCrim := RECORD
	corrections.layout_offender;
  string150 off_desc;
  string75 off_desc_1;
  string50 off_desc_2;
  string8 off_date;
  string8 convict_dt;
  string8 ct_disp_dt;
  string8 stc_dt;
  string8 inc_adm_dt;
  string8 st_start_dt;
  string8 event_date;
  string150 charge;
  string50 fraud_type;
	END;

Export OIG := record
  string20 lastname;
  string15 firstname;
  string15 midname;
  string30 busname;
  string20 general;
  string20 specialty;
  string6 upin1;
  string10 npi;
  string8 dob;
  string30 address1;
  string20 city;
  string2 state;
  string5 zip5;
  string9 sanctype;
  string8 sancdate;
  string8 reindate;
  string8 waiverdate;
  string2 wvrstate;
  string100 append_prep_address1;
  string50 append_prep_addresslast;
  unsigned8 append_rawaid;
  unsigned8 ace_aid;
  string2 addr_type;
  string8 dt_vendor_first_reported;
  string8 dt_vendor_last_reported;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string250 sancdesc;
  unsigned6 did;
  unsigned6 bdid;
  string9 ssn;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
End;

End;
export Base         := 
    module 

export AFI          := 
      record 

	input.AFI ; 
	unsigned8         source_rec_id;
	string4	          Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
end;
 
 export SuspectIP  := record 
  input.SuspectIP ; 
  string8           reported_date;  
  string10          reported_time;
	unsigned8         source_rec_id;
	string20		      Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
 end;

export Glb5          := 
  record 

	input.Glb5 ;
	string            Sybase_company_id;
	string 	          Sybase_app_type;
	string            Sybase_market;
	string            Sybase_sub_market;
	string            Sybase_vertical ;
	string            Sybase_main_country_code;
	string            Sybase_bill_country_code;
	string            Industry_segment ;
	unsigned8         source_rec_id;
	string4	          Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
end; 

export Tiger          := 
  record 

	input.Tiger ;
	string5           namesuffix; // needed for the macro. 
	unsigned8         source_rec_id;
	string4		        Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
	end; 
export CFNA          := 
  record 
	Input.CFNA ;
	unsigned8         source_rec_id;
	string4		        Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
	end; 
export AInspection          := 
  record 
	Input.AInspection ;
	unsigned8         source_rec_id;
	string4		        Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
	end; 

Export TextMinedCrim := 
  record 
	Input.TextMinedCrim -[ process_date , NID ];
	unsigned8         source_rec_id;
	string4		        Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ; 
	Address.Layout_Clean_Name						cleaned_name;         
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;   
End;
 
 export OIG  := record 
  input.OIG  - [dt_first_seen, dt_last_seen, dt_vendor_last_reported, dt_vendor_first_reported];
  unsigned8         lnpid; 
	string5           suffix_name;
	unsigned8         source_rec_id;
	string20		      Source; 
	unsigned4         process_date ; 
  unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	string            current ; 
	unsigned8         Unique_Id ;  
  string100       	clean_business_name;	
	Address.Layout_Clean_Name           cleaned_name;	     
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	string100         address_1 ;   
	string50          address_2 ;  
	unsigned8         RawAID := 0;     //address id 
 end;	
		
end; 

export temp := module 

		export oig := record
			string20 fname			;
	    string20 mname			;
	    string20 lname			;
	    string5 name_suffix;
	    string10 prim_range	;
	    string28 prim_name	;
	    string8 sec_range	;
	    string25 v_city_name	;
	    string2 state		  ;
	    string5 zip5		 		;
			Base.oig			;

		end; 
 end; 

end;