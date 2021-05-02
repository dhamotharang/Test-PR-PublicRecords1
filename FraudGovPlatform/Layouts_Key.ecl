﻿import	Address,bipv2; 
EXPORT Layouts_Key := MODULE 

	shared flagsrec := RECORD
		string indicator;
		string value;
  END;

	EXPORT Cluster_Exp1_	:= RECORD
		string entity_context_uid_;
		unsigned1 __entity_context_uid__flags;
		unsigned2 date_first_seen_;
		unsigned2 date_last_seen_;
		integer8 __recordcount;
	END;
	
	EXPORT ClusterDetails	:=	RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		string100 tree_uid_;
		unsigned8 source_customer_;
		unsigned1 __source_customer__flags;
		unsigned1 __customer_id__flags;
		unsigned1 __industry_type__flags;
		unsigned1 __tree_uid__flags;
		unsigned1 __entity_context_uid__flags;
		unsigned2 date_first_seen_;
		unsigned2 date_last_seen_;
		integer8 __recordcount;
		integer8 entity_type_;
		string label_;
		unsigned1 __label__flags;
		integer8 score_;
		unsigned1 __score__flags;
		integer8 cluster_score_;
		unsigned1 __cluster_score__flags;
		integer8 cl_event_count_;
		integer8 cl_identity_count_;
		integer8 cl_address_count_;
		integer8 deceased_match_;
		integer8 death_prior_to_all_events_;
		integer8 nas9_flag_;
		integer8 nap3_flag_;
		DATASET(RECORD
		 string entity_context_uid_;
		 unsigned1 __entity_context_uid__flags;
		 unsigned2 date_first_seen_;
		 unsigned2 date_last_seen_;
		 integer8 __recordcount;
		END) exp1_;
		unsigned1 __exp1__flags;
		real8 latitude_;
		unsigned1 __latitude__flags;
		real8 longitude_;
		unsigned1 __longitude__flags;
		string street_address_;
		unsigned1 __street_address__flags;
		string vanity_city_;
		unsigned1 __vanity_city__flags;
		string state_;
		unsigned1 __state__flags;
		integer8 zip_;
		unsigned1 __zip__flags;
		integer8 person_count_;
		integer8 high_frequency_flag_;
		integer8 high_risk_death_prior_to_all_events_percent_flag_;
		integer8 all_high_risk_death_prior_to_all_events_person_percent_flag_;
		integer8 deceased_person_count_;
		DATASET(flagsrec) flags;
	END; 

	EXPORT ElementPivot	:= RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		unsigned8 entityhash;
		string field;
		string200 value;
		string indicatortype;
		string indicatordescription;
		string label;
		string fieldtype;
		unsigned8 risklevel;
		integer8 recs;
	END;
	
	EXPORT ScoreBreakdown	:= RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		string indicatortype;
		string indicatordescription;
		integer8 risklevel;
		string populationtype;
		integer8 value;
	END;
	
	EXPORT WeightingChart	:= RECORD
		string200 field;
		integer8 entitytype;
		string value;
		decimal64_32 low;
		decimal64_32 high;
		integer8 risklevel;
		integer8 weight;
		string uidescription;
	END;
	
	shared nvprec := RECORD
   string name;
   string value;
  END;

	EXPORT EntityProfile	:=RECORD
  integer8 customerid;
  integer8 industrytype;
  string100 entitycontextuid;
  integer1 entitytype;
  integer8 recordid;
  unsigned4 eventdate;
  string caseid;
  string label;
  integer1 riskindx;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  integer1 aotcurrprofflag;
  integer8 t_personuidecho;
  string t_inpclnfirstnmecho;
  string t_inpclnlastnmecho;
  string t_inpclnssnecho;
  integer8 t_inpclndobecho;
  string t_inpclnaddrprimrangeecho;
  string t_inpclnaddrpredirecho;
  string t_inpclnaddrprimnmecho;
  string t_inpclnaddrsuffixecho;
  string t_inpclnaddrpostdirecho;
  string t_inpclnaddrunitdesigecho;
  string t_inpclnaddrsecrangeecho;
  string t_inpclnaddrcityecho;
  string t_inpclnaddrstecho;
  string t_inpclnaddrzip5echo;
  string t_inpclnipaddrecho;
  string t18_ipaddrispnm;
  string t18_ipaddrcountry;
  string t_inpclnphnecho;
  string t_inpclnemailecho;
  string t19_bnkacctbnknm;
  string t_inpclnbnkacctecho;
  string t_inpclnbnkacctrtgecho;
  string t_inpclndlstecho;
  string t_inpclndlecho;
  unsigned8 event30count;
  unsigned8 eventcount;
  integer8 personeventcount;
  string100 deviceid;
  DATASET(nvprec) nvp;
 END;

 EXPORT ConfigAttributes := Record
  integer8 entitytype;
  string200 field; 
  string250 value; 
  decimal low;
  decimal high; 
  integer risklevel; 
  string indicatortype;
  string indicatordescription;
  integer weight; 
  string uidescription;
  unsigned customerid;
  unsigned industrytype;
 END;

 EXPORT ConfigRules := Record
  unsigned8 customerid;
  unsigned8 industrytype;
  integer1 entitytype;
  string100 rulename;
  string description;
  string200 field;
  string value;
  decimal low;
  decimal high;
  integer8 risklevel;
 END;

 EXPORT DisposableEmailDomains := Record
  string200 domain;
  string1 dispsblemail;
 END;
 
 export clean_phones :=
	record
	string10            phone_number ; 
	string10            cell_phone   ; 
	string10            Work_phone   ; 
	end;
	
export address_cleaner :=
	record
	string100						Street_1 := '';
	string50						Street_2 := '';
	string100						City := '';
	string10						State := '';
	string10						Zip := '';
	string10						Address_Type := '';
	string100         	address_1 := '';   
	string50          	address_2 := '';
	Address.Layout_Clean182_fips				clean_address;
	end;
	
export Classification := module 

export Source := record
	unsigned2  Source_type_id ;
	string25   Source_type ;
	unsigned2  Primary_source_Entity_id ;
	string10   Primary_source_Entity ;
	unsigned2  Expectation_of_Victim_Entities_id;
	string10   Expectation_of_Victim_Entities;
	string100  Industry_segment ;
	string2		Customer_State := '';
	string3		Customer_County := '';	
	string 		Customer_Vertical := '';
end; 

export Activity := record 
	unsigned2  Suspected_Discrepancy_id ;
	String25   Suspected_Discrepancy ;
	unsigned2  Confidence_that_activity_was_deceitful_id;
	string10   Confidence_that_activity_was_deceitful;
	unsigned2  workflow_stage_committed_id;
	String15   workflow_stage_committed;
	unsigned2  workflow_stage_detected_id ;
	string15   workflow_stage_detected ;
	unsigned2  Channels_id ;
	string10   Channels ;
	string50   category_or_fraudtype;
	string250  description ;
	unsigned2  Threat_id ;
	string50   Threat ;
	string12   Exposure;
	string12   write_off_loss ;
	string12   Mitigated ;
	unsigned2  Alert_level_id ;
	String10   Alert_level ;

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

export Main  
:= 
   record ,maxLength(60000)
// primary record 
	unsigned8 	 			Record_ID;
	string12 				  Customer_ID; // global company id
	string12 				  Sub_Customer_ID ;// company id 
	string60          Vendor_ID ; 
  string60          Offender_key;
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
	string20 					Household_ID;
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
	string20					  Customer_Person_ID;
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
	string						Host ;
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
	string25					MAC_Address;
	string20					Serial_Number;
	string25					Device_Type ; 
	string25          Device_identification_Provider; 
// TRANSACTION (case, claim, policy,...)
	string					  Transaction_ID;
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
	string100		      Source; 
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
	// FraudGovPlatform	IDDT & KNFD 	
	string1						head_of_household_indicator := '';
	string20					relationship_indicator := '';
	string3						county := ''; //   County/Parish ???
	address_cleaner		additional_address;	

// FraudGovPlatform	IdentityData
	string1						Race := '';
	string1						Ethnicity := '';
	string20					bank_routing_number_1 := '';
	string20					bank_account_number_1 := '';
	string20					bank_routing_number_2 := '';
	string20					bank_account_number_2 := '';

// FraudGovPlatform	KnownFraud
	string30					reported_by := '';
	string60					name_risk_code := '';
	string60					ssn_risk_code := '';
	string60					dob_risk_code := '';
	string60					drivers_license_risk_code := '';
	string60					physical_address_risk_code := '';
	string60					phone_risk_code := '';
	string60					cell_phone_risk_code := '';
	string60					work_phone_risk_code := '';
	string60					bank_account_1_risk_code := '';
	string60					bank_account_2_risk_code := '';
	string60					email_address_risk_code := '';
	string30					ip_address_fraud_code := '';
	string60					business_risk_code := '';
	string60					mailing_address_risk_code := '';
	string60					device_risk_code := '';
	string60					identity_risk_code := '';
	string10					tax_preparer_id := '';
	string75					start_date := '';
	string75					end_date := '';
	string10  					amount_paid := '';
	string10					region_code := '';
	string10					investigator_id := '';	
	string3						cleared_fraud := ''; 
	string250					reason_cleared_code := ''; 
	unsigned4					global_sid := 0;
	unsigned8					record_sid := 0; 	
	string10					Duration := '';
	string30					TransactionStatus := '';
	string						Reason := ''; 

end; 

export autokey  
:= Record
 // primary record 
	unsigned8 	 			Record_ID;
	string12 				  Customer_ID; // global company id
	string12 				  Sub_Customer_ID ;// company id 
	string12    		  Sub_Sub_Customer_ID;
	string20    			Customer_Event_ID;
	string12     			Sub_Customer_Event_ID;
	string12    			Sub_Sub_Customer_Event_ID;
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
	string20 					Household_ID;
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
	string20					  Customer_Person_ID;
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
	Classification.Entity          classification_Entity;
	string100		      Source; 
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
	unsigned8         UID ; 
	bipv2.IDlayouts.l_xlink_ids;
	clean_phones      clean_phones ;
	address_cleaner		additional_address;			
	
end; 

Export MbsIndTypeExclusion := record 

	unsigned6  fdn_file_info_id ;
	unsigned6  fdn_file_ind_type_exclusion_id ; 
	unsigned6  Ind_type; 
	unsigned3  status; // 1=Active, 2=Expired/not-active',
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
End; 

Export  MbsProductInclude := Record 

	unsigned6  fdn_file_info_id;
	unsigned6  fdn_file_product_include_id; 
	unsigned6  product_id ; 
	unsigned3  status ; 	
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
	
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

Export   MbsFdnMasterIDIndTypeIncl    := record 
	unsigned6		fdn_ind_type_gc_id_inclusion;  
	unsigned6		fdn_file_info_id;                         
	unsigned6		ind_type;                                    
	unsigned6		inclusion_id;                             
	string20		inclusion_type; 
	data16			FdnMasterId;	
	unsigned3		status; //1=Active, 2=Expired/not-active
	string20		date_added;                              
	string30		user_added;                              
	string20		date_changed;                          
	string30		user_changed;                             
END;

Export FDNMasterID := record 
  unsigned6  gc_id; 
  unsigned6  hh_id; 
  unsigned6  cc_id; 
	unsigned6  GC_CC_HH_ID;
  string10   id_type;
  string10   FDNMasterID_Type;
	data16     FdnMasterId;    
End;

Export MbsFdnIndType	:= Record
	string255  description ;  
	unsigned6  ind_type ; 
	unsigned3  status ; 
	string20   date_added; 
	string30   user_added; 
	string20   date_changed; 
	string30   user_changed; 
End;
END;