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

// DD1 +DD2 
// MBS primary 
 export mbs := record
	unsigned6   fdn_file_info_id; // primary key from MBS 
	string100   fdn_file_code; 
	unsigned6   gc_id ; // global company id 
	unsigned3   file_type ; // '1=Event Outcomes (Contributed), 2=Applicable Public Records, 3=Transactions, 4=Rel. Analytics'
	string256   description; 
	unsigned3   primary_source_entity; 
	unsigned6   ind_type; 
	unsigned3   update_freq;
	unsigned6   expiration_days ;
	unsigned6   post_contract_expiration_days ; 
	unsigned3   status ; 
	unsigned3   product_include ;
	unsigned2   expectation_of_victim_entities;
	unsigned2   suspected_discrepancy;
	unsigned2   confidence_that_activity_was_deceitful;
	unsigned2   workflow_stage_committed;
	unsigned2   workflow_stage_detected;
	unsigned2   channels;
	unsigned2   threat;
	unsigned2   alert_level;
	unsigned2   entity_type;
	unsigned2   entity_sub_type;
	unsigned2   role;
	unsigned2   evidence; 
	string20    date_added ; 
	string30    user_added; 
	string20    date_changed ; 
	string30    user_changed; 
end; 

Export MbsGcIdExclusion := record 
	unsigned6  fdn_file_gc_exclusion_id ; 
	unsigned6  fdn_file_info_id; 
	unsigned6  gc_id; 
	unsigned3   status; // 1=Active, 2=Expired/not-active',
	string20    date_added; 
	string30    user_added; 
	string20    date_changed; 
	string30    user_changed; 	
End; 

Export MbsNewGcIdExclusion := record 
	unsigned6  fdn_file_gc_exclusion_id ; 
	unsigned6  fdn_file_info_id; 
	unsigned6  exclusion_id; 
	string20   exclusion_id_type; 
	unsigned3   status; // 1=Active, 2=Expired/not-active',
	string20    date_added; 
	string30    user_added; 
	string20    date_changed; 
	string30    user_changed; 	
End; 

Export MbsIndTypeExclusion := record 

	unsigned6  fdn_file_ind_type_exclusion_id ; 
	unsigned6  fdn_file_info_id ;
	unsigned6  Ind_type; 
	unsigned3  status; // 1=Active, 2=Expired/not-active',
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
End; 

Export  MbsProductInclude := Record 
  unsigned6  fdn_file_product_include_id; 
	unsigned6  fdn_file_info_id;
	unsigned6  product_id ; 
	unsigned3  status ; 	
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 

End; 

Export   MBSSourceGcExclusion := record 
  unsigned6  gc_id ; 
	unsigned6  product_id ; 
	unsigned6  company_id ; 
	unsigned3  status ; 
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
End; 

Export   MBSFdnIndType         := record 
  unsigned6  ind_type ; 
	string255  description ;
	unsigned3  status ; 
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 

End; 

Export   MBSFdnCCID         := record 
  unsigned6  cc_id; 
	unsigned6  gc_id;
	string30   account_id; 
End; 

Export   MBSFdnHHID         := record 
  unsigned6  gc_id; 
	string30   sub_account_id;
	unsigned6  hh_id;
End;

Export MbsFdnMasterIdExcl := record 
	unsigned6  fdn_file_gc_exclusion_id ; 
	unsigned6  fdn_file_info_id; 
	unsigned6  exclusion_id; 
	string20   exclusion_id_type; 
	data16     FdnMasterId;    
	unsigned3  status; // 1=Active, 2=Expired/not-active',
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
End; 

Export FDNMasterID := record 
  unsigned6  gc_id; 
  unsigned6  hh_id; 
  unsigned6  cc_id; 
	unsigned6  GC_CC_HH_ID;
  string10   id_type;
  string10   FDNMasterID_Type;
	data16     FdnMasterId;    
End; 	
	
Export MBSTableCol := record 
  unsigned3  table_column_id; 
  qstring255 table_name; 
  qstring255 column_name; 
	unsigned2  is_column_value;
End;	
	
Export MBSColValDesc := record 
  unsigned3  column_value_desc_id; 
  unsigned3  table_column_id; 
  qstring255 desc_value;
	unsigned2  status;
  qstring300 description;
End; 		
	
Export   MBSmarketAppend       := record 
	string    company_id;
	string 	  app_type;
	string    market;
	string    sub_market;
	string    vertical ;
	string    main_country_code;
	string    bill_country_code;
END;


Export Conviction_Lookup := record
	string	court_disp_desc;
	string	conviction_flag;
END;
END; 

export clean_phones :=
	record
	string10            phone_number ; 
	string10            cell_phone   ; 
	string10            Work_phone   ; 
	end;
	
export Classification := module 

export Source := record

	unsigned2 Source_type_id ;
	string25  Source_type ;
	unsigned2 Primary_source_Entity_id ;
	string10  Primary_source_Entity ;
	unsigned2 Expectation_of_Victim_Entities_id;
	string10  Expectation_of_Victim_Entities;
	string100 Industry_segment ;
end; 

export Activity := record 

	unsigned2 Suspected_Discrepancy_id ;
	String25  Suspected_Discrepancy ;
	unsigned2 Confidence_that_activity_was_deceitful_id;
	string10  Confidence_that_activity_was_deceitful;
	unsigned2 workflow_stage_committed_id;
	String15  workflow_stage_committed;
	unsigned2 workflow_stage_detected_id ;
	string15  workflow_stage_detected ;
	unsigned2 Channels_id ;
	string10  Channels ;
	string50  category_or_fraudtype;
	string250 description ;
	unsigned2 Threat_id ;
	string50  Threat ;
	string12  Exposure;
	string12  write_off_loss ;
	string12  Mitigated ;
	unsigned2 Alert_level_id ;
	String10  Alert_level ;
end ; 

export Entity := record 
	unsigned2 Entity_type_id ;
	string25  Entity_type ;
	unsigned2 Entity_sub_type_id ;
	string25  Entity_sub_type ;
	unsigned2 role_id ;
	string25  role ;
	unsigned2 Evidence_id ;
	string10  Evidence ;
	string10  investigated_count ;
end; 

export Permissible_use_access := 
	record 
  unsigned6   fdn_file_info_id; // primary key from MBS 
	string100   fdn_file_code; 
	unsigned6   gc_id ; // global company id 
	unsigned3   file_type ; // '1=Event Outcomes (Contributed), 2=Applicable Public Records, 3=Transactions, 4=Rel. Analytics'
	string256   description; 
	unsigned3   primary_source_entity; 
	unsigned6   Ind_type; 
	string256   Ind_type_description; 
	unsigned3   update_freq;
	unsigned6   Expiration_days ;
	unsigned6   post_contract_expiration_days ; 
	unsigned3   status ; 
	unsigned3   product_include ; 
	string20    date_added ; 
	string30    user_added; 
	string20    date_changed ; 
	string30    user_changed;  
	string100   p_industry_segment ;
	string20    usage_term ;
	//string1     GLBA; 
end; 

end; 

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
		
export Main         :=  
   record ,maxLength(60000)
// primary record 
	unsigned8 	 			Record_ID;
	string12 				  Customer_ID; // global company id
	string12 				  Sub_Customer_ID ;// company id 
	string60          Vendor_ID ;
  string60          offender_key; 
	string12    		  Sub_Sub_Customer_ID;
	string20    			Customer_Event_ID;
	string12     			Sub_Customer_Event_ID;
	string12    			Sub_Sub_Customer_Event_ID;
	string12 					LN_Product_ID;
	string12 					LN_Sub_Product_ID;
	string12 					LN_Sub_Sub_Product_ID;
	string12 					LN_Product_Key;// (ID)
	string8 					LN_Report_Date;
	string10 					LN_Report_Time;
	string8						Reported_Date;
	string10  				Reported_Time;
	string8 					Event_Date;
	string10  				Event_End_Date;
	string75  				Event_Location;
	string75 					Event_Type_1; 
	string75  				Event_Type_2;
	string75  				Event_Type_3;
//ENTITY CHARACTERISTICS
	unsigned8 				Household_ID;
	string250    			Reason_Description;
	string25					Investigation_Referral_Case_ID;
	string8						Investigation_Referral_Date_Opened;
	string8						Investigation_Referral_Date_Closed;
	string20					Customer_Fraud_Code_1;
	string20					Customer_Fraud_Code_2;
	string25					Type_of_Referral;
	string50					Referral_Reason;
	string25					Disposition; 
	string3						Mitigated;
	string10					Mitigated_Amount;
	string20					External_Referral_or_CaseNumber;
	string5						Fraud_Point_Score;
// Entity 
// Person 
	unsigned6					  Customer_Person_ID;
	string50						raw_title;
	string100						raw_First_Name;
	string60						raw_Middle_Name;
	string100						raw_Last_Name;
	string10 						raw_Orig_Suffix;
	string100           raw_Full_name; 
	string10						SSN;
	string10						DOB;
	string25						Drivers_License;
	string2 						Drivers_License_State;
	string8						  Person_Date;
	string10						Name_Type;
	string10            income; 
	string5             own_or_rent; 
	unsigned8           Rawlinkid;  
// Address 
	string100						Street_1;
	string50						Street_2;
	string100						City;
	string10						State;
	string10						Zip;
	string20						GPS_coordinates;
	string10						Address_Date;
	string10						Address_Type;
	unsigned6 				  Appended_Provider_ID ;
  unsigned8           lnpid; 
	string100    				Business_Name;
	string10						TIN;
	string10						FEIN;
	string10						NPI;
	string25						Business_Type_1;
	string25						Business_Type_2;
	string10						Business_Date;
	// CONTACT NUMBER
	//string						Contact_Number;
	string12           phone_number ; 
	string12           cell_phone; 
	string12           Work_phone ; 
	string10					 Contact_Type;
	string8						 Contact_Date;
	string25					 Carrier;
	string25					 Contact_Location;
	string25					 Contact;   // Individual or business associated with number
	string25					 Call_records;
	string1 					 In_service;
// EMAIL ADDRESS
	string50					Email_Address ;
	string10					Email_Address_Type ;
	string8						Email_Date ;
	string15					Host ;
	string25					Alias ;
	string25					Location ;
// IP ADDRESS
	string25					IP_Address;
	string8						IP_Address_Date;
	string10					Version;
	string10					Class;
	string10					Subnet_mask;
	string2						Reserved;
	string75					ISP;
// DEVICE
	string50					Device_ID;
	string8 					Device_Date;
	string20					Unique_number;// (IMEI, MEID, ESN, IMSI)   
	string10					MAC_Address;
	string20					Serial_Number;
	string25					Device_Type ; 
	string25          Device_identification_Provider; 
// TRANSACTION (case, claim, policy,...)
	string20					Transaction_ID;
	string10					Transaction_Type;
	string12					Amount_of_Loss;
// LICENSED PROFESSIONAL (LP)
	string12					Professional_ID; //(NPI, EIN, PTIN, state bar number)
	string50					Profession_Type;
	string12					Corresponding_Professional_IDs;
	string2						Licensed_PR_State;
	// Classification // per source mapped at record level
  Classification.source                  classification_source; 
	Classification.Activity                classification_Activity;
	Classification.Entity                  classification_Entity;
	Classification.Permissible_use_access  classification_Permissible_use_access;
  unsigned8         UID ; 
	string50		      Source;
	unsigned4         process_date ; 
	unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	unsigned6         source_rec_id;
	//clean person
	Address.Layout_Clean_Name						cleaned_name;     
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	//Clean address 
	Address.Layout_Clean182_fips				clean_address						;
	string100         address_1 ;   
	string50          address_2 ; 
	unsigned8         RawAID := 0;     //address id 
	unsigned8         AceAID := 0; 
	unsigned2         Address_ind:=0;  // address indicator bitmap
	unsigned6 				did ; 
	unsigned1					did_score;	
// Business 
  string100       	clean_business_name;
	unsigned6 				Bdid ; 
	unsigned1					bdid_score ; 
	bipv2.IDlayouts.l_xlink_ids;
	clean_phones      clean_phones ; 
	
end; 

end; 

export keybuild  
:= 
   record ,maxLength(60000)
// primary record 
	unsigned8 	 			Record_ID;
	string12 				  Customer_ID; // global company id
	string12 				  Sub_Customer_ID ;// company id 
	string60          Vendor_ID ;
  string60          offender_key; 
	string12    		  Sub_Sub_Customer_ID;
	string20    			Customer_Event_ID;
	string12     			Sub_Customer_Event_ID;
	string12    			Sub_Sub_Customer_Event_ID;
	string12 					LN_Product_ID;
	string12 					LN_Sub_Product_ID;
	string12 					LN_Sub_Sub_Product_ID;
	string12 					LN_Product_Key;// (ID)
	string8 					LN_Report_Date;
	string10 					LN_Report_Time;
	string8						Reported_Date;
	string10  				Reported_Time;
	string8 					Event_Date;
	string10  				Event_End_Date;
	string75  				Event_Location;
	string75 					Event_Type_1;
	string75  				Event_Type_2;
	string75  				Event_Type_3;
//ENTITY CHARACTERISTICS
	unsigned8 				Household_ID;
	string250    			Reason_Description;
	string25					Investigation_Referral_Case_ID;
	string8						Investigation_Referral_Date_Opened;
	string8						Investigation_Referral_Date_Closed;
	string20					Customer_Fraud_Code_1;
	string20					Customer_Fraud_Code_2;
	string25					Type_of_Referral;
	string50					Referral_Reason;
	string25					Disposition;
	string3						Mitigated;
	string10					Mitigated_Amount;
	string20					External_Referral_or_CaseNumber;
	string5						Fraud_Point_Score;
// Entity 
// Person 
	unsigned6					  Customer_Person_ID;
	string50						raw_title;
	string100						raw_First_Name;
	string60						raw_Middle_Name;
	string100						raw_Last_Name;
	string10 						raw_Orig_Suffix;
	string100           raw_Full_name; 
	string10						SSN;
	string10						DOB;
	string25						Drivers_License;
	string2 						Drivers_License_State;
	string8						  Person_Date;
	string10						Name_Type;
	string10            income; 
	string5             own_or_rent; 
	unsigned8           Rawlinkid;  
// Address 
	string100						Street_1;
	string50						Street_2;
	string100						City;
	string10						State;
	string10						Zip;
	string20						GPS_coordinates;
	string10						Address_Date;
	string10						Address_Type;
	unsigned6 				  Appended_Provider_ID ;
  unsigned8           lnpid; 
	string100    				Business_Name;
	string10						TIN;
	string10						FEIN;
	string10						NPI;
	string25						Business_Type_1;
	string25						Business_Type_2;
	string10						Business_Date;
	// CONTACT NUMBER
	//string						Contact_Number;
	string12           phone_number ; 
	string12           cell_phone; 
	string12           Work_phone ; 
	string10					 Contact_Type;
	string8						 Contact_Date;
	string25					 Carrier;
	string25					 Contact_Location;
	string25					 Contact;   // Individual or business associated with number
	string25					 Call_records;
	string1 					 In_service;
// EMAIL ADDRESS
	string50					Email_Address ;
	string10					Email_Address_Type ;
	string8						Email_Date ;
	string15					Host ;
	string25					Alias ;
	string25					Location ;
// IP ADDRESS
	string25					IP_Address;
	string8						IP_Address_Date;
	string10					Version;
	string10					Class;
	string10					Subnet_mask;
	string2						Reserved;
	string75					ISP;
// DEVICE
	string50					Device_ID;
	string8 					Device_Date;
	string20					Unique_number;// (IMEI, MEID, ESN, IMSI)   
	string10					MAC_Address;
	string20					Serial_Number;
	string25					Device_Type ; 
	string25          Device_identification_Provider; 
// TRANSACTION (case, claim, policy,...)
	string20					Transaction_ID;
	string10					Transaction_Type;
	string12					Amount_of_Loss;
// LICENSED PROFESSIONAL (LP)
	string12					Professional_ID; //(NPI, EIN, PTIN, state bar number)
	string50					Profession_Type;
	string12					Corresponding_Professional_IDs;
	string2						Licensed_PR_State;
	// Classification // per source mapped at record level
  Classification.source                  classification_source; 
	Classification.Activity                classification_Activity;
	Classification.Entity                  classification_Entity;
	Classification.Permissible_use_access  classification_Permissible_use_access;
  unsigned8         UID ; 
	string50		      Source; 
	unsigned4         process_date ; 
	unsigned4         dt_first_seen;
	unsigned4         dt_last_seen;
	unsigned4         dt_vendor_last_reported;
	unsigned4         dt_vendor_first_reported;
	unsigned6         source_rec_id;
	//clean person
	Address.Layout_Clean_Name						cleaned_name;     
	unsigned8       	NID:=0;       // name cleaner ID
	unsigned2       	name_ind:=0;  // name indicator bitmap
	//Clean address 
	Address.Layout_Clean182_fips				clean_address						;
	string100         address_1 ;   
	string50          address_2 ; 
	unsigned8         RawAID := 0;     //address id 
	unsigned8         AceAID := 0; 
	unsigned2         Address_ind:=0;  // address indicator bitmap
	unsigned6 				did ; 
	unsigned1					did_score;	
// Business 
  string100       	clean_business_name;
	unsigned6 				Bdid ; 
	unsigned1					bdid_score ; 
	bipv2.IDlayouts.l_xlink_ids;
	clean_phones      clean_phones ; 
	
end; 

export temp := module 
	 
	 export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			string9 		ssn							;
			string8   	dob							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	business_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		// City
			string2			state		 					;
			string10		phone		  		    ;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			string9 		fein						  ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids		;
	  end;
		
		  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base.main									;
		end;
		
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