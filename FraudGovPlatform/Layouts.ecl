import Address , bipv2, Inquiry_Acclogs, corrections, NAC,CriminalRecords_BatchService,DeathV2_Services,risk_indicators;

EXPORT Layouts := MODULE

	EXPORT Sprayed := module
		EXPORT IdentityData := RECORD
			string		Customer_Job_ID;
			string		Batch_Record_ID;
			string		transaction_id;
			string		Reason_Description;
			string8		Date_of_Transaction;
			unsigned6	Rawlinkid;
			string60	raw_Full_Name;
			string5		raw_Title;
			string100	raw_First_name;
			string60	raw_Middle_Name;
			string100	raw_Last_Name;
			string10	raw_Orig_Suffix;
			string9		SSN;
			string4		SSN4;
			string10	Address_Type;
			string70	Street_1;
			string70	Street_2;
			string30	City;
			string2		State;
			string9		Zip;
			string70	Mailing_Street_1;
			string70	Mailing_Street_2;
			string30	Mailing_City;
			string2		Mailing_State;
			string9		Mailing_Zip;
			string3		County;
			string20	Contact_Type;
			string10	phone_number;
			string10	Cell_Phone;
			string8		dob;
			string256	Email_Address;
			string2		Drivers_License_State;
			string25	Drivers_License;
			string20	Bank_Routing_Number_1;
			string20	Bank_Account_Number_1;
			string20	Bank_Routing_Number_2;
			string20	Bank_Account_Number_2;
			string1		Ethnicity;
			string1		Race;
			string20	Household_ID;
			string20	Customer_Person_ID;
			string1		Head_of_Household_indicator;
			string20	Relationship_Indicator;
			string25	IP_Address;
			string50	Device_ID;
			string20	Unique_number;
			string25	MAC_Address;
			string20	Serial_Number;
			string25	Device_Type;
			string25	Device_identification_Provider; 
			string10	geo_lat;
			string11	geo_long;
      		unsigned2   RIN_Source := 0;
			//RDP Section  
			string75	start_date := '';
			string75	end_date := '';
			string10	Duration := '';
			string30	TransactionStatus := '';
			string		Reason := ''; 
		END;
		
		EXPORT KnownFraud := RECORD
			string20	customer_event_id;
			string8		reported_date;
			string10	reported_time;
			string30	reported_by;
			string8		event_date;
			string8		event_end_date;
			string75	event_location;
			string75	event_type_1;
			string75	event_type_2;
			string75	event_type_3;
			string20	Household_ID;
			string20	Customer_Person_ID;
			string1		head_of_household_indicator;
			string20	relationship_indicator;
			unsigned6	Rawlinkid;
			string50	raw_Title;
			string100	raw_First_name;
			string60	raw_Middle_Name;
			string100	raw_Last_Name;
			string10	raw_Orig_Suffix;
			string100	raw_Full_Name;
			string60	name_risk_code;
			string10	ssn;
			string60	ssn_risk_code;
			string10	dob;
			string60	dob_risk_code;
			string25	Drivers_License;
			string2		Drivers_License_State;
			string60	drivers_license_risk_code;
			string100	street_1;
			string50	street_2;
			string100	city;
			string10	state;
			string10	zip;
			string60	physical_address_risk_code;
			string70	mailing_street_1;
			string70	mailing_street_2;
			string30	mailing_city;
			string2		mailing_state;
			string9		mailing_zip;
			string60	mailing_address_risk_code;
			string10	address_date;
			string10	address_type;
			string3		county;
			string12	phone_number;
			string60	phone_risk_code;
			string12	cell_phone;
			string60	cell_phone_risk_code;
			string12	work_phone;
			string60	work_phone_risk_code;
			string12	contact_type;
			string8		contact_date;
			string25	carrier;
			string25	contact_location;
			string25	contact;
			string25	call_records;
			string1		in_service;
			string50	email_address;
			string60	email_address_risk_code;
			string10	email_address_type;
			string8		email_date;
			string		host;
			string25	alias;
			string25	location;
			string25	ip_address;
			string30	ip_address_fraud_code;
			string8		ip_address_date;
			string10	version;
			string75	isp;
			string50	device_id;
			string8		device_date;
			string60	device_risk_code;
			string20	unique_number;
			string25	MAC_Address;
			string20	serial_number;
			string25	device_type;
			string25	device_identification_provider;
			string20	bank_routing_number_1;
			string20	bank_account_number_1;
			string60	bank_account_1_risk_code;
			string20	bank_routing_number_2;
			string20	bank_account_number_2;
			string60	bank_account_2_risk_code;
			unsigned6	appended_provider_id;
			string100	business_name;
			string10	tin;
			string10	fein;
			string10	npi;
			string10	tax_preparer_id;
			string10	business_type_1;
			string10	business_date;
			string60	business_risk_code;
			string1		Customer_Program;
			string8		start_date;
			string8		end_date;
			string10  	amount_paid;
			string10	region_code;
			string10	investigator_id;
			string250	reason_description;
			string25	investigation_referral_case_id;
			string8		investigation_referral_date_opened;
			string8		investigation_referral_date_closed;
			string20	customer_fraud_code_1;
			string20	customer_fraud_code_2;
			string10	type_of_referral;
			string20	referral_reason;
			string25	disposition;
			string3		mitigated;
			string10	mitigated_amount;
			string20	external_referral_or_casenumber;
			string3		cleared_fraud;
			string		reason_cleared_code;
      		unsigned2   RIN_Source := 0;
		END;
		EXPORT SafeList	:= RECORD
			KnownFraud;
		END;
		EXPORT Deltabase := RECORD
			unsigned6	InqLog_ID;
			string20	customer_id;
			string		transaction_id;
			string10	Date_of_Transaction;
			string20	Household_ID;
			string20	Customer_Person_ID;
			string1		Customer_Program;
			string		Reason_for_Transaction_Activity;
			string100	inquiry_source;
			string3		customer_county;
			string2		customer_state;
			string		customer_agency_vertical_type;
			string10	ssn;
			string10	dob;
			unsigned6	Rawlinkid;
			string100	raw_full_name;
			string50	raw_title;
			string100	raw_first_name;
			string60	raw_middle_name;
			string100 raw_last_name;
			string10	raw_Orig_Suffix;
			string  	full_address;
			string100	street_1;
			string100	city;
			string10	state;
			string10	zip;
			string3		county;
			string100	mailing_street_1;
			string30	mailing_city;
			string2		mailing_state;
			string9		mailing_zip;
			string3		mailing_county;
			string10	phone_number;
			unsigned6	ultid;
			unsigned6	orgid;
			unsigned6	seleid;
			string10	tin;
			string256	Email_Address;
			unsigned6	appended_provider_id;
			unsigned6	lnpid;
			string10	npi;
			string25	ip_address;
			string50	device_id;
			string12	professional_id;
			string20	bank_routing_number_1;
			string20	bank_account_number_1;
			string2		Drivers_License_State;
			string25	Drivers_License;
			string10	geo_lat;
			string11	geo_long;
			string75	reported_date;			
			unsigned3	file_type;
			string10	deceitful_confidence;
			string30	reported_by;
			string250	reason_description;
			string30	event_type_1;
			string30	event_entity_1;
      		unsigned2   RIN_Source := 0;
		END;

		EXPORT RDP := record
			string Transaction_ID;
			string75 TransactionDate;
			string100 FirstName;
			string100 LastName;
			string60 MiddleName;
			string10 Suffix;
			string10 BirthDate;
			string10 SSN;
			unsigned6 Lexid_Input;
			string100 Street1;
			string50 Street2;
			string50 Suite;
			string100 City;
			string10 State;
			string10 Zip5;
			string12 Phone;
			unsigned6 Lexid_Discovered;
			string25 RemoteIPAddress;
			string25 ConsumerIPAddress;
      		string256 Email_Address;
			string75 EndDate; 
			string10 Duration;
			string30 TransactionStatus;
			string Reason;
		END;
	
		EXPORT validate_record := record
			string	field1	:= '';
			string	field2	:= '';
			string	field3	:= '';
			string 	field4	:= '';
			string  field5	:= '';
			string  field6	:= ''; //raw_Orig_Suffix
		END;
		
		EXPORT DisposableEmailDomains := Record
			string200 domain;
			string1	  dispsblemail;
		END;			
	END;

	EXPORT vLoad := {string75 fn { virtual(logicalfilename)},Sprayed.IdentityData};

	EXPORT clean_phones := RECORD
			string10	phone_number ; 
			string10	cell_phone   ; 
			string10	Work_phone   ; 
	END;	

  EXPORT clean_Drivers_License := RECORD
			string2		Drivers_License_State := '';
			string25	Drivers_License  := '';
  END;

	EXPORT Provenance := RECORD
				string75 FileName	:=''
				,unsigned4 process_date	:=0
				,unsigned4 FileDate	:=0
				,string6   FileTime	:=''
				,unsigned6 PrepRecNo	:=0
				,unsigned6 PrepRecSeq	:=0	
	END;
	
	EXPORT Input := module
		EXPORT IdentityData := RECORD
			Sprayed.IdentityData;
			string20		customer_id;
			string2			Customer_State;
			string			Customer_Agency_Vertical_Type;
			string1			Customer_Program;
			unsigned8		source_rec_id;
			unsigned3		file_type;
			unsigned6		ind_type;
			string100 	source := '';
			Provenance;
		END;
		EXPORT KnownFraud := RECORD
			Sprayed.KnownFraud;
			string20		customer_id;
			string2			customer_state;
			string			customer_agency_vertical_type;
			string1			customer_program_fn; // use this one
			unsigned8		source_rec_id ;
			unsigned3		file_type;
			unsigned6		ind_type;
			string100 	source := '';
			Provenance;
		END;
		EXPORT Deltabase := RECORD
			Sprayed.Deltabase;
			unsigned8		source_rec_id ;
			unsigned6		ind_type;
			string12		cell_phone := '';
			string100 	source := '';
			Provenance;
		END;
		
		EXPORT ConfigRiskLevel	:= RECORD
		  STRING entitytype;
			STRING field;
			STRING value;
			STRING low;
			STRING high;
			STRING risklevel;
			STRING weight;
			STRING uidescription;
		END;
		
		EXPORT ConfigAttributes	:= RECORD
			STRING entitytype;
			STRING field;
			STRING value;
			STRING low;
			STRING high;
			STRING risklevel;
			STRING indicatortype;
			STRING indicatordescription;
			STRING weight;
			STRING uidescription;
			STRING customerid;
			STRING industrytype;
		END;

		EXPORT ConfigRules	:= RECORD
			unsigned8 customerid;
			unsigned8 industrytype;
			integer1 entitytype;
			string rulename;
			string description;
			string200 field;
			string value;
			decimal low;
			decimal high;
			integer8 risklevel;
		END;
		EXPORT DisposableEmailDomains := Record
			Sprayed.DisposableEmailDomains;
			unsigned8		source_rec_id;
			Provenance;
		END;	

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
			string2			Customer_State := '';
			string3			Customer_County := '';	
			string 			Customer_Vertical := '';
		end; 

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

		Export   MbsFdnMasterIDIndTypeInclusion    := record 
			unsigned6	fdn_ind_type_gc_id_inclusion;  
			unsigned6	fdn_file_info_id;                         
			unsigned6	ind_type;                                    
			unsigned6 inclusion_id;                             
			string20	inclusion_type;                           
			unsigned3	status; //1=Active, 2=Expired/not-active
			string20 	date_added;                              
			string30	user_added;                              
			string20	date_changed;                          
			string30	user_changed;                             
		END;

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

		Export   MbsFdnMasterIDIndTypeIncl    := record 
			unsigned6	fdn_ind_type_gc_id_inclusion;  
			unsigned6	fdn_file_info_id;                         
			unsigned6	ind_type;                                    
			unsigned6 	inclusion_id;                             
			string20	inclusion_type; 
			data16     	FdnMasterId;	
			unsigned3	status; //1=Active, 2=Expired/not-active
			string20 	date_added;                              
			string30	user_added;                              
			string20	date_changed;                          
			string30	user_changed;                             
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

		Export	MbsVelocityRules		:= record
			unsigned6 ruleNum;
			unsigned6	gc_id;
			string60	fragment;
			string100 fragment_description;
			string60	contributionType;
			string100	contributionTypeDescription;
			unsigned2 fragment_weight;
			unsigned2	category_weight;
			unsigned2	minCnt;
			unsigned2	maxTime;
			string20	timeUnit;
			unsigned2	status;
			string25	date_added;
			string25	date_changed;
			string60	user_added;
			string60	user_changed;
		END;
	END;

	EXPORT address_cleaner :=
		RECORD
		string100	Street_1 := '';
		string50	Street_2 := '';
		string100	City := '';
		string10	State := '';
		string10	Zip := '';
		string10	Address_Type := '';
		string100	address_1 := '';   
		string50	address_2 := '';
		Address.Layout_Clean182_fips	clean_address;
	END;

	EXPORT Classification := MODULE 

		EXPORT Source := RECORD
			unsigned2 Source_type_id ;
			string25  Source_type ;
			unsigned2 Primary_source_Entity_id ;
			string10  Primary_source_Entity ;
			unsigned2 Expectation_of_Victim_Entities_id;
			string10  Expectation_of_Victim_Entities;
			string100 Industry_segment ;
			string2 Customer_State := '';
			string3 Customer_County := '';	
			string Customer_Vertical := '';		
		END; 

		EXPORT Activity := RECORD 
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

		EXPORT Entity := RECORD 
			unsigned2 Entity_type_id ;
			string25  Entity_type ;
			unsigned2 Entity_sub_type_id ;
			string25  Entity_sub_type ;
			unsigned2 role_id ;
			string25  role ;
			unsigned2 Evidence_id ;
			string10  Evidence ;
			string10  investigated_count ;
		END; 

		EXPORT Permissible_use_access := 
			RECORD 
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
		END; 
	END; 

	EXPORT Base := MODULE
		EXPORT Main         :=  
		RECORD ,MAXLENGTH(60000)
			// primary record 
			unsigned8	Record_ID;
			string12	Customer_ID; // global company id
			string12	Sub_Customer_ID ;// company id 
			string60	Vendor_ID ;
			string60	offender_key; 
			string12	Sub_Sub_Customer_ID;
			string20	Customer_Event_ID;
			string12	Sub_Customer_Event_ID;
			string12	Sub_Sub_Customer_Event_ID;
			string12	LN_Product_ID;
			string12	LN_Sub_Product_ID;
			string12	LN_Sub_Sub_Product_ID;
			string12	LN_Product_Key;// (ID)
			string8	LN_Report_Date;
			string10	LN_Report_Time;
			string8	Reported_Date;
			string10	Reported_Time;
			string8	Event_Date;
			string10	Event_End_Date;
			string75	Event_Location;
			string75	Event_Type_1; 
			string75	Event_Type_2;
			string75	Event_Type_3;
			//ENTITY CHARACTERISTICS
			string20	Household_ID;
			string250	Reason_Description;
			string25	Investigation_Referral_Case_ID;
			string8	Investigation_Referral_Date_Opened;
			string8	Investigation_Referral_Date_Closed;
			string20	Customer_Fraud_Code_1;
			string20	Customer_Fraud_Code_2;
			string25	Type_of_Referral;
			string50	Referral_Reason;
			string25	Disposition; 
			string3	Mitigated;
			string10	Mitigated_Amount;
			string20	External_Referral_or_CaseNumber;
			string5	Fraud_Point_Score;
			// Entity 
			// Person 
			string20	Customer_Person_ID;
			string50	raw_title;
			string100	raw_First_Name;
			string60	raw_Middle_Name;
			string100	raw_Last_Name;
			string10	raw_Orig_Suffix;
			string100	raw_Full_name; 
			string10	SSN;
			string10	DOB;
			string25	Drivers_License;
			string2	Drivers_License_State;
			string8	Person_Date;
			string10	Name_Type;
			string10	income; 
			string5	own_or_rent; 
			unsigned8	Rawlinkid;  
			// Address 
			string100	Street_1;
			string50	Street_2;
			string100	City;
			string10	State;
			string10	Zip;
			string20	GPS_coordinates;
			string10	Address_Date;
			string10	Address_Type;
			unsigned6	Appended_Provider_ID ;
			unsigned8	lnpid; 
			string100	Business_Name;
			string10	TIN;
			string10	FEIN;
			string10	NPI;
			string25	Business_Type_1;
			string25	Business_Type_2;
			string10	Business_Date;
			// CONTACT NUMBER
			//string	Contact_Number;
			string12	phone_number ; 
			string12	cell_phone; 
			string12	Work_phone ; 
			string10	Contact_Type;
			string8	Contact_Date;
			string25	Carrier;
			string25	Contact_Location;
			string25	Contact;   // Individual or business associated with number
			string25	Call_records;
			string1	In_service;
			// EMAIL ADDRESS
			string50	Email_Address ;
			string10	Email_Address_Type ;
			string8	Email_Date ;
			string	Host ;
			string25	Alias ;
			string25	Location ;
			// IP ADDRESS
			string25	IP_Address;
			string8	IP_Address_Date;
			string10	Version;
			string10	Class;
			string10	Subnet_mask;
			string2	Reserved;
			string75	ISP;
			// DEVICE
			string50	Device_ID;
			string8	Device_Date;
			string20	Unique_number;// (IMEI, MEID, ESN, IMSI)   
			string25	MAC_Address;
			string20	Serial_Number;
			string25	Device_Type ; 
			string25	Device_identification_Provider; 
			// TRANSACTION (case, claim, policy,...)
			string	Transaction_ID;
			string10	Transaction_Type;
			string12	Amount_of_Loss;
			// LICENSED PROFESSIONAL (LP)
			string12	Professional_ID; //(NPI, EIN, PTIN, state bar number)
			string50	Profession_Type;
			string12	Corresponding_Professional_IDs;
			string2	Licensed_PR_State;
			//Vehicle
			string25	VIN := ''; 
			// Classification // per source mapped at record level
			Classification.source	classification_source; 
			Classification.Activity	classification_Activity;
			Classification.Entity	classification_Entity;
			Classification.Permissible_use_access	classification_Permissible_use_access;
			unsigned8	UID ; 
			string100	Source;
			unsigned4	process_date ; 
			unsigned4	dt_first_seen;
			unsigned4	dt_last_seen;
			unsigned4	dt_vendor_last_reported;
			unsigned4	dt_vendor_first_reported;
			unsigned6	source_rec_id;
			//clean person
			Address.Layout_Clean_Name	cleaned_name;     
			unsigned8	NID:=0;       // name cleaner ID
			unsigned2	name_ind:=0;  // name indicator bitmap
			//Clean address 
			Address.Layout_Clean182_fips	clean_address						;
			string100	address_1 ;   
			string50	address_2 ; 
			unsigned8	RawAID := 0;     //address id 
			unsigned8	AceAID := 0; 
			unsigned2	Address_ind:=0;  // address indicator bitmap
			unsigned6	did ; 
			unsigned1	did_score;	
			// Business 
			string100	clean_business_name;
			unsigned6	Bdid ; 
			unsigned1	bdid_score ; 
			bipv2.IDlayouts.l_xlink_ids;
			clean_phones	clean_phones ; 
			// FraudGovPlatform	IDDT & KNFD 	
			string1	head_of_household_indicator := '';
			string20	relationship_indicator := '';
			string3	county := ''; //   County/Parish ???
			address_cleaner	additional_address;	
			string10	clean_SSN :='';
			string10	clean_Zip :='';
			string25	clean_IP_Address :='';
			string10	clean_dob :='';

			// FraudGovPlatform	IdentityData
			string1	Race := '';
			string1	Ethnicity := '';
			string20	bank_routing_number_1 := '';
			string20	bank_account_number_1 := '';
			string20	bank_routing_number_2 := '';
			string20	bank_account_number_2 := '';

			// FraudGovPlatform	KnownFraud
			string30	reported_by := '';
			string60	name_risk_code := '';
			string60	ssn_risk_code := '';
			string60	dob_risk_code := '';
			string60	drivers_license_risk_code := '';
			string60	physical_address_risk_code := '';
			string60	phone_risk_code := '';
			string60	cell_phone_risk_code := '';
			string60	work_phone_risk_code := '';
			string60	bank_account_1_risk_code := '';
			string60	bank_account_2_risk_code := '';
			string60	email_address_risk_code := '';
			string30	ip_address_fraud_code := '';
			string60	business_risk_code := '';
			string60	mailing_address_risk_code := '';
			string60	device_risk_code := '';
			string60	identity_risk_code := '';
			string10	tax_preparer_id := '';
			string8	start_date := '';
			string8	end_date := '';
			string10	amount_paid := '';
			string10	region_code := '';
			string10	investigator_id := '';	
			string3	cleared_fraud := ''; 
			string250	reason_cleared_code := ''; 

			//  Other fields
			unsigned4	global_sid := 0;
			unsigned8	record_sid := 0;
			unsigned2	RIN_Source := 0;
			clean_Drivers_License	clean_Drivers_License;
			string10	geo_lat := '';
			string11	geo_long := '';	
			string20	RIN_SourceLabel := '';
		END; 

		EXPORT AddressCache := record
            string100 Street_1 := '';
            string50 Street_2 := '';
            string100 City := '';
            string10 State := '';
            string10 Zip := '';
            Address.Layout_Clean182_fips clean_address;
            string100 address_1 := '';   
            string50 address_2 := '';
			unsigned4 address_cleaned;
		END;

		EXPORT DisposableEmailDomains := Record
			string200 domain;
			string1	  dispsblemail;
		END;
		
	END;
	EXPORT CustomerSettings := record 
		string20 	Customer_Id;
		string2 	Customer_State;
		string 		Customer_Agency_Vertical_Type;
		string1 	Customer_Program;
		unsigned3 	file_type;
		unsigned6 	ind_type;
		boolean 	Anonymize_Data;
		boolean 	Validate_Data;
		string30 	MSH_Prefix;
		string 		Customer_Email; // Emails Separated by semicolon ";"
		unsigned6 	fdn_file_info_id;
	end;

	EXPORT CustomerMappings := RECORD
		unsigned6	fdn_file_info_id;
		string20	contribution_source;
		string		contribution_gc_id;
		integer8	contribution_billing_id;
	END;
	export Flags := module

		export FraudgovInfoRec := RECORD
			string PreviousVersion;
			string NewVersion;
			string Status;
		END;

		EXPORT SourcesToAnonymize := RECORD
			unsigned6 fdn_file_info_id;
		END;
		
		export SkipModules := RECORD
			//General Processes
			boolean SkipBuild;
			boolean SkipContributions;
			boolean SkipNAC;
			boolean SkipInquiryLogs;
			boolean SkipMBS;
			boolean SkipDeltabase;
			boolean SkipRDP;
			boolean SkipDashboards;
			boolean SkipDashboardVersion;
			boolean SkipDEDI;
		END;

		export SkipValidationByGCID	 := RECORD
			string Gc_ID;
		end;


		export CustomerActiveSprays := record 
			string20 	Customer_Id;
			string20	File_type;
		end;
	end;

export temp := module 
	 
	 export DidSlim := 
	  record
			unsigned8		record_id;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string5  		name_suffix;
			string10		prim_range;
			string28		prim_name;
			string8			sec_range;
			string5			zip5;
			string2			state;
			string10		phone;
			string9 		ssn;
			string8			dob;
			unsigned6		did:= 0;
			unsigned1		did_score:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		record_id;
			string100		business_name;
			string10		prim_range;
			string28		prim_name;
			string5			zip5;
			string8			sec_range;
			string25 		p_City_name;	// City
			string2			state;
			string10		phone;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string9 		fein;
			unsigned6		bdid:= 0;
			unsigned1		bdid_score:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
	  end;

 end; 

Export PII	:=RECORD
  unsigned6 did;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
	string10 prim_range;
	string2 predir;
	string28 prim_name;
	string4 addr_suffix;
	string2 postdir;
	string10 unit_desig;
	string8 sec_range;
	string25 p_city_name;
  string2 st;
  string5 zip;
	string100 address_1;
  string10 ssn;
  string10 dob;
  string25 drivers_license;
  string2 drivers_license_state;
  string10 home_phone;
  string10 work_phone_;
	string50 email_address;
  string25 ip_address;
	string8	reported_date;
	unsigned8 Record_ID;
	unsigned6 fdn_file_info_id;

END;

 Export Crim	:= RECORD
 CriminalRecords_BatchService.Layouts.batch_out;
 string errorcode;
 unsigned8 Record_ID;
 unsigned6 fdn_file_info_id;
 string20	fname_orig;
 string20	mname_orig;
 string20	lname_orig;
 string10	ssn_orig;
 string10	dob_orig;
 unsigned6 did_orig;
 END;
 
 Export Death	:= RECORD
 DeathV2_Services.Layouts.BatchOut;
 string errorcode;
 unsigned8 Record_ID;
 unsigned6 fdn_file_info_id;
 unsigned6 did_orig;
 END;
 
 Export IPMetaData	:= RECORD
  unsigned6 did;
  string25 ip_address;
	unsigned8 Record_ID;
	unsigned6 fdn_file_info_id;
  string20 iprngbeg;
  string20 iprngend;
  string5 edgecountry;
  string10 edgeregion;
  string60 edgecity;
  string10 edgeconnspeed;
  unsigned8 edgemetrocode;
  string10 edgelatitude;
  string10 edgelongitude;
  string10 edgepostalcode;
  unsigned8 edgecountrycode;
  unsigned8 edgeregioncode;
  unsigned8 edgecitycode;
  unsigned8 edgecontinentcode;
  string5 edgetwolettercountry;
  unsigned8 edgeinternalcode;
  string20 edgeareacodes;
  unsigned8 edgecountryconf;
  unsigned8 edgeregionconf;
  unsigned8 edgecitycong;
  unsigned8 edgepostalconf;
  integer8 edgegmtoffset;
  string5 edgeindst;
  string10 siccode;
  string70 domainname;
  string200 ispname;
  string10 homebiztype;
  unsigned8 asn;
  string200 asnname;
  string40 primarylang;
  string105 secondarylang;
  string15 proxytype;
  string15 proxydescription;
  string5 isanisp;
  string70 companyname;
  string10 ranks;
  string10 households;
  string10 women;
  string10 women18to34;
  string10 women35to49;
  string10 men;
  string10 men18to34;
  string10 men35to49;
  string10 teens;
  string10 kids;
  unsigned8 naicscode;
  unsigned8 cbsacode;
  string55 cbsatitle;
  string10 cbsatype;
  unsigned8 csacode;
  string55 csatitle;
  unsigned8 mdcode;
  string55 mdtitle;
  string100 organizationname;
 END;
 
 EXPORT BestInfo := RECORD
		unsigned8 	Record_ID;
		unsigned6 	did;
		unsigned6 	fdn_file_info_id;
		string10 	best_phone;
		string9  	best_ssn;
		string9  	max_ssn;
		string5		best_title;
		string20	best_fname;
		string20	best_mname;
		string20	best_lname;
		string5		best_name_suffix;
		string120 	best_addr1;
		string30	best_city;
		string2		best_state;
		string5		best_zip;
		string4		best_zip4;
		STRING6		best_addr_date;
		string8  	best_dob;
		string8  	best_dod;
		STRING3 	verify_best_phone;
		STRING3 	verify_best_ssn;
		STRING3 	verify_best_address;
		STRING3 	verify_best_name;
		STRING3 	verify_best_dob;
		STRING3 	score_any_ssn;
		STRING3 	score_any_addr;
		STRING3 	any_addr_date;
		STRING3 	score_any_dob;
		STRING3 	score_any_phn;
		STRING3		score_any_fzzy;
		STRING		errorcode;
		STRING2		best_drivers_license_state := '';
		STRING25	best_drivers_license := '';    
		unsigned8   best_drivers_license_exp := 0;
	    unsigned8   best_drivers_dt_first_seen := 0;
	    unsigned8   best_drivers_dt_last_seen := 0;
	    string8   Reported_Date := '';
 END;

EXPORT Drivers_Batch := MODULE

    import Autokey_batch,DriversV2_Services;
    
    SHARED ResultNarrow := DriversV2_Services.layouts.result_narrow;

		SHARED AutoKeyBatchInput := Autokey_batch.Layouts.rec_inBatchMaster;
		SHARED Seq := DriversV2_Services.layouts.seq;
		SHARED AcctRec := RECORD(Seq)
			AutoKeyBatchInput.acctno;
			UNSIGNED6	did := 0;
			STRING24	dl_number := '';
			STRING2		dlstate := '';
		END;		
		EXPORT layout_in   := Autokey_batch.Layouts.rec_inBatchMaster;
		EXPORT layout_out := RECORD(ResultNarrow)
			AcctRec.acctno;
			STRING10	height_desc;
		END;
 END;   

 EXPORT DLHistory := RECORD
		unsigned6 	did;
    Drivers_Batch.layout_out;
 END;

 EXPORT CoverageDates := RECORD
    unsigned6 customer_id;
    string2		customer_state;
    string1   customer_program;
    string100 contribution_code;
    string100	source := '';
    string100	source_group := '';
    unsigned4	max_reported_date := 0;
    unsigned4	max_process_date := 0;
    unsigned4	record_count := 1;				
  END;
	
	EXPORT BankNames :=RECORD
		string50 bank_name;
	END;
	
	EXPORT IspNames :=RECORD
		string75 isp_name;
	END;
	
	EXPORT AgencyActivityDate := RECORD
		string8		reported_date;
		string10	reported_time;
	END;
 EXPORT PrepaidPhone	:= RECORD
	string10	phone;
	string8	reported_date;
	unsigned8	vendor_first_reported_dt;
	unsigned8	vendor_last_reported_dt;
	string2	prepaid;
	unsigned8	record_id;
	unsigned6	fdn_file_info_id;
 END;
 

//KEL Dashboards Response Layout
 rresults := RECORD
    string name{xpath('name')};
    string value{xpath('value')};
    string filename{xpath('filename')};
    string total{xpath('total')};
   END;

 rappvalues := RECORD
    string application{xpath('application')};
    string name{xpath('name')};
    string value{xpath('value')};
   END;

 rworkunit := RECORD
   string wuid{xpath('wuid')};
   string owner{xpath('owner')};
   string cluster{xpath('cluster')};
   string jobname{xpath('jobname')};
   string stateid{xpath('stateID')};
   string state{xpath('state')};
   string totalthortime{xpath('totalThorTime')};
   DATASET(rresults) results{xpath('results')};
   DATASET(rappvalues) appvalues{xpath('applicationValues')};
   integer8 errorcount{xpath('errorCount')};
   integer8 warningcount{xpath('warningCount')};
   integer8 infocount{xpath('infoCount')};
   integer8 resultcount{xpath('resultCount')};
  END;

 rresponse	:= RECORD 
  string uuid{xpath('uuid')};
  string username{xpath('username')};
  string workunitid{xpath('workunitId')};
  rworkunit workunit{xpath('workunit')};
  string failed{xpath('failed')};
  string running{xpath('running')};
  string connectionurl{xpath('connectionURL')};
  string compositionuuid{xpath('compositionUuid')};
  string paused{xpath('paused')};
  string complete{xpath('complete')};
  string compositionname{xpath('compositionName')};
 END;
 
 Export DashboardResponse :={ DATASET(rresponse) response{xpath('response')} END;
 
 Export ProdDashboardVersion := Record
  string version;
 End; 
 
 Export Advo	:= Record
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
	unsigned6 did;
  string1 advo_hitflag;
  string1 advo_vacancyindicator;
  string1 advo_throwbackindicator;
  string1 advo_seasonaldeliveryindicator;
  string5 advo_seasonalsuppressionstartdate;
  string5 advo_seasonalsuppressionenddate;
  string1 advo_donotdeliverindicator;
  string1 advo_collegeindicator;
  string10 advo_collegesuppressionstartdate;
  string10 advo_collegesuppressionenddate;
  string1 advo_addressstyle;
  string5 advo_simplifyaddresscount;
  string1 advo_dropindicator;
  string1 advo_residentialorbusinessindicator;
  string1 advo_onlywaytogetmailindicator;
  string1 advo_recordtypecode;
  string1 advo_addresstype;
  string1 advo_addressusagetype;
  string8 advo_firstseendate;
  string8 advo_lastseendate;
  string8 advo_vendorfirstreporteddate;
  string8 advo_vendorlastreporteddate;
  string8 advo_vacationbegindate;
  string8 advo_vacationenddate;
  string8 advo_numberofcurrentvacationmonths;
  string8 advo_maxvacationmonths;
  string8 advo_vacationperiodscount;
 End;

 //KEL Layouts
  
 EXPORT ConfigAttributes := Record
  integer8 entitytype;
  string200 field; 
  string value; 
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
 
 EXPORT EntityProfile	:= RECORD
  integer1 entitytype;
  string label;
  integer1 riskindx;
  integer1 aotcurrprofflag;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  unsigned8 aotkractnewdtev;
  unsigned8 aotkractcntev;
  unsigned8 aotnonstactcntev;
  unsigned8 aotnewkraftidactcntev;
  unsigned8 aotidactcnt30d;
  unsigned8 aotnonstactcnt30d;
  unsigned8 aotnewkraftnonstactcntev;
  integer8 aothiidcurrprofusngcntev;
  unsigned8 aotidusngcntev;
  unsigned8 aotidactcntev;
  unsigned8 aotidcurrprofusngcntev;
  unsigned1 not_aotkractflagev;
  unsigned1 not_aotsafeactflagev;
  string customerprogramdescription;
  integer8 industrytype;
  integer8 customerid;
  string entitycontextuid;
  integer8 recordid;
  string caseid;
  unsigned4 eventdate;
  string ottoaddressid;
  unsigned4 deceaseddate;
  unsigned4 deceaseddateofbirth;
  string deceasedfirst;
  string deceasedmiddle;
  string deceasedlast;
  string phonenumber;
  string ottoemailid;
  string ottoipaddressid;
  string ottodriverslicenseid;
  integer8 currentlyincarceratedflag;
  integer8 deceased;
  integer8 eventage;
  integer8 contributorsafeflag;
  integer8 personeventcount;
  integer8 safeflag;
  string rin_sourcelabel;
  integer8 rin_source;
  integer8 idislasteventid;
  integer8 emlislasteventid;
  integer8 addrislasteventid;
  integer8 ipislasteventid;
  integer8 bnkislasteventid;
  integer8 dlislasteventid;
  integer8 ssnislasteventid;
  integer8 phislasteventid;
  string personlabel;
  string emaillabel;
  string addresslabel;
  string iplabel;
  string bankaccountlabel;
  string driverslicenselabel;
  string ssnlabel;
  string phonelabel;
  string addressentitycontextuid;
  string ssnentitycontextuid;
  string personentitycontextuid;
  string phoneentitycontextuid;
  string emailentitycontextuid;
  string ipentitycontextuid;
  string bankaccountentitycontextuid;
  string driverslicenseentitycontextuid;
  string streetaddress;
  string city;
  string state;
  string zip;
  integer8 incustomerpopulation;
  integer8 agencyuid;
  integer8 agencyprogtype;
  string agencyprogdesc;
  string agencyprogjurst;
  integer8 t_srcagencyuid;
  integer8 t_srcagencyprogtype;
  integer8 t_actuid;
  unsigned4 t_actdtecho;
  integer8 t_srctype;
  string t_srcdesc;
  integer8 t_srcclasstype;
  integer8 t_personuidecho;
  string t_inpclnaddrstreetecho;
  string t_inpclnmiddlenmecho;
  string t_inpcaseidecho;
  string t_inpdvcidecho;
  string t_inpclntitleecho;
  string t_inpclnfirstnmecho;
  string t_inpclnlastnmecho;
  string t_inpclnnmsuffixecho;
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
  string t_inpclnaddrzip4echo;
  real8 t_inpclnaddrlatecho;
  real8 t_inpclnaddrlongecho;
  string t_inpclnaddrcountyecho;
  integer8 t_inpclnaddrgeoblkecho;
  string t_inpclnssnecho;
  integer8 t_inpclndobecho;
  string t_inpclndlecho;
  string t_inpclndlstecho;
  string t_inpclnemailecho;
  string t_inpclnbnkacctecho;
  string t_inpclnbnkacctrtgecho;
  string t_inpclnipaddrecho;
  string t_inpclnphnecho;
  integer8 t1_lexidpopflag;
  integer8 t1_rinidpopflag;
  integer8 t18_isipmetahitflag;
  string t18_ipaddrcity;
  string t18_ipaddrcountry;
  string t18_ipaddrregion;
  string t18_ipaddrdomain;
  string t18_ipaddrispnm;
  string t18_ipaddrloctype;
  string t18_ipaddrproxytype;
  string t18_ipaddrproxydesc;
  integer8 t18_ipaddrisispflag;
  string t18_ipaddrasncompnm;
  string t18_ipaddrasn;
  string t18_ipaddrcompnm;
  string t18_ipaddrorgnm;
  integer8 t18_ipaddrhostedflag;
  integer8 t18_ipaddrvpnflag;
  integer8 t18_ipaddrtornodeflag;
  integer8 t18_ipaddrlocnonusflag;
  integer8 t18_ipaddrlocmiamiflag;
  integer8 t19_bnkacctpopflag;
  integer8 t19_isbnkapphitflag;
  string t19_bnkacctbnknm;
  integer8 t19_bnkaccthrprepdrtgflag;
  integer8 t17_emailpopflag;
  string t17_emaildomain;
  integer8 t17_emaildomaindispflag;
  integer8 t9_addrpopflag;
  string t9_addrtype;
  string t9_addrstatus;
  integer8 t16_phnpopflag;
  integer8 t15_ssnpopflag;
  integer8 t20_dlpopflag;
  integer8 t18_ipaddrpopflag;
  integer8 t_inagencyflag;
  integer8 t15_ssniskrflag;
  integer8 t20_dliskrflag;
  integer8 t9_addriskrflag;
  integer8 t16_phniskrflag;
  integer8 t17_emailiskrflag;
  integer8 t18_ipaddriskrflag;
  integer8 t19_bnkacctiskrflag;
  integer8 t1_idiskrgenfrdflag;
  integer8 t1_idiskrstolidflag;
  integer8 t1_idiskrappfrdflag;
  integer8 t1_idiskrothfrdflag;
  integer8 t1_idiskrflag;
  integer8 t_firstnmpopflag;
  integer8 t_lastnmpopflag;
  integer8 t_dobpopflag;
  integer8 p1_aotidcurrprofflag;
  integer8 p9_aotaddrcurrprofflag;
  integer8 p15_aotssncurrprofflag;
  integer8 p20_aotdlcurrprofflag;
  integer8 p16_aotphncurrprofflag;
  integer8 p17_aotemailcurrprofflag;
  integer8 p18_aotipaddrcurrprofflag;
  integer8 p19_aotbnkacctcurrprofflag;
  integer8 p1_aotidkractcntev;
  integer8 p1_aotidkractflagev;
  integer8 p1_aotidkractshrdcntev;
  integer8 p1_aotidkractshrdflagev;
  integer8 p1_aotidkractolddtev;
  integer8 p1_aotidkractnewdtev;
  integer8 p1_aotidkractshrdolddtev;
  integer8 p1_aotidkractshrdnewdtev;
  integer8 p1_aotidkrappfrdactcntev;
  integer8 p1_aotidkrappfrdactflagev;
  integer8 p1_aotidkrappfrdactshrdcntev;
  integer8 p1_aotidkrappfrdactshrdflagev;
  integer8 p1_aotidkrappfrdactolddtev;
  integer8 p1_aotidkrappfrdactnewdtev;
  integer8 p1_aotidkrappfrdactshrdolddtev;
  integer8 p1_aotidkrappfrdactshrdnewdtev;
  integer8 p1_aotidkrgenfrdactcntev;
  integer8 p1_aotidkrgenfrdactflagev;
  integer8 p1_aotidkrgenfrdactshrdcntev;
  integer8 p1_aotidkrgenfrdactshrdflagev;
  integer8 p1_aotidkrgenfrdactolddtev;
  integer8 p1_aotidkrgenfrdactnewdtev;
  integer8 p1_aotidkrgenfrdactshrdolddtev;
  integer8 p1_aotidkrgenfrdactshrdnewdtev;
  integer8 p1_aotidkrothfrdactcntev;
  integer8 p1_aotidkrothfrdactflagev;
  integer8 p1_aotidkrothfrdactshrdcntev;
  integer8 p1_aotidkrothfrdactshrdflagev;
  integer8 p1_aotidkrothfrdactolddtev;
  integer8 p1_aotidkrothfrdactnewdtev;
  integer8 p1_aotidkrothfrdactshrdolddtev;
  integer8 p1_aotidkrothfrdactshrdnewdtev;
  integer8 t_evttype1statuscodeecho;
  integer8 t_evttype2statuscodeecho;
  integer8 t_evttype3statuscodeecho;
  integer8 t_idstatuscodeecho;
  integer8 t_namestatuscodeecho;
  integer8 t_addrstatuscodeecho;
  integer8 t_bnkacctstatuscodeecho;
  integer8 t_dlstatuscodeecho;
  integer8 t_emailstatuscodeecho;
  integer8 t_ipaddrstatuscodeecho;
  integer8 t_phnstatuscodeecho;
  integer8 t_ssnstatuscodeecho;
  integer8 p1_aotidkrstolidactcntev;
  integer8 p1_aotidkrstolidactflagev;
  integer8 p1_aotidkrstolidactshrdcntev;
  integer8 p1_aotidkrstolidactshrdflagev;
  integer8 p1_aotidkrstolidactolddtev;
  integer8 p1_aotidkrstolidactnewdtev;
  integer8 p1_aotidkrstolidactshrdolddtev;
  integer8 p1_aotidkrstolidactshrdnewdtev;
  integer8 p9_aotaddrkractcntev;
  integer8 p9_aotaddrkractflagev;
  integer8 p9_aotaddrkractshrdcntev;
  integer8 p9_aotaddrkractshrdflagev;
  integer8 p9_aotaddrkractolddtev;
  integer8 p9_aotaddrkractnewdtev;
  integer8 p9_aotaddrkractshrdolddtev;
  integer8 p9_aotaddrkractshrdnewdtev;
  integer8 p15_aotssnkractcntev;
  integer8 p15_aotssnkractflagev;
  integer8 p15_aotssnkractshrdcntev;
  integer8 p15_aotssnkractshrdflagev;
  integer8 p15_aotssnkractolddtev;
  integer8 p15_aotssnkractnewdtev;
  integer8 p15_aotssnkractshrdolddtev;
  integer8 p15_aotssnkractshrdnewdtev;
  integer8 p16_aotphnkractcntev;
  integer8 p16_aotphnkractflagev;
  integer8 p16_aotphnkractshrdcntev;
  integer8 p16_aotphnkractshrdflagev;
  integer8 p16_aotphnkractolddtev;
  integer8 p16_aotphnkractnewdtev;
  integer8 p16_aotphnkractshrdolddtev;
  integer8 p16_aotphnkractshrdnewdtev;
  integer8 p17_aotemailkractcntev;
  integer8 p17_aotemailkractflagev;
  integer8 p17_aotemailkractshrdcntev;
  integer8 p17_aotemailkractshrdflagev;
  integer8 p17_aotemailkractolddtev;
  integer8 p17_aotemailkractnewdtev;
  integer8 p17_aotemailkractshrdolddtev;
  integer8 p17_aotemailkractshrdnewdtev;
  integer8 p18_aotipaddrkractcntev;
  integer8 p18_aotipaddrkractflagev;
  integer8 p18_aotipaddrkractshrdcntev;
  integer8 p18_aotipaddrkractshrdflagev;
  integer8 p18_aotipaddrkractolddtev;
  integer8 p18_aotipaddrkractnewdtev;
  integer8 p18_aotipaddrkractshrdolddtev;
  integer8 p18_aotipaddrkractshrdnewdtev;
  integer8 p19_aotbnkacctkractcntev;
  integer8 p19_aotbnkacctkractflagev;
  integer8 p19_aotbnkacctkractshrdcntev;
  integer8 p19_aotbnkacctkractshrdflagev;
  integer8 p19_aotbnkacctkractolddtev;
  integer8 p19_aotbnkacctkractnewdtev;
  integer8 p19_aotbnkacctkractshrdolddtev;
  integer8 p19_aotbnkacctkractshrdnewdtev;
  integer8 p20_aotdlkractcntev;
  integer8 p20_aotdlkractflagev;
  integer8 p20_aotdlkractshrdcntev;
  integer8 p20_aotdlkractshrdflagev;
  integer8 p20_aotdlkractolddtev;
  integer8 p20_aotdlkractnewdtev;
  integer8 p20_aotdlkractshrdolddtev;
  integer8 p20_aotdlkractshrdnewdtev;
  integer8 t9_addrissafeflag;
  integer8 t16_phnissafeflag;
  integer8 t18_ipaddrissafeflag;
  integer8 p9_aotaddrsafeactcntev;
  integer8 p9_aotaddrsafeactflagev;
  integer8 p9_aotaddrsafeactolddtev;
  integer8 p9_aotaddrsafeactnewdtev;
  integer8 p16_aotphnsafeactcntev;
  integer8 p16_aotphnsafeactflagev;
  integer8 p16_aotphnsafeactolddtev;
  integer8 p16_aotphnsafeactnewdtev;
  integer8 p18_aotipaddrsafeactcntev;
  integer8 p18_aotipaddrsafeactflagev;
  integer8 p18_aotipaddrsafeactolddtev;
  integer8 p18_aotipaddrsafeactnewdtev;
  integer8 t_isbcshllhitflag;
  integer8 t_bcshlllexidecho;
  integer8 t1l_lexidseenflag;
  integer8 t1l_bcshlllexidmatchesinpflag;
  integer8 t1l_idisbcshllhitflag;
  integer8 t1_idage;
  integer8 t1l_dobverindx;
  integer8 t1_napsummary;
  integer8 t1l_iddeceasedflag;
  integer8 t1l_nassummary;
  integer8 t1_cvi;
  string t1_fp3;
  integer8 t1_fp3_stolenidentityindex;
  integer8 t1_fp3_syntheticidentityindex;
  integer8 t1_fp3_manipidentityindex;
  integer8 t1l_fp_sourcerisklevel;
  integer8 t1_adultidnotseenflag;
  integer8 t1_minorwlexidflag;
  string t1_ssnpriordobflag;
  integer8 t1_firstnmnotverflag;
  integer8 t1_lastnmnotverflag;
  integer8 t1_addrnotverflag;
  integer8 t1l_ssnnotverflag;
  integer8 t1l_ssnwaltnaverflag;
  integer8 t1l_ssnwaddrnotverflag;
  integer8 t1_phnnotverflag;
  integer8 t1l_dobnotverflag;
  integer8 t1_hiriskcviflag;
  integer8 t1_medriskcviflag;
  integer8 t1l_hdrsrccatcntlwflag;
  integer8 t1_stolidflag;
  integer8 t1_synthidflag;
  integer8 t1_manipidflag;
  integer8 t1l_iddtofdeathaftidactcntev;
  integer8 t1l_iddtofdeathaftidactflagev;
  string t_bcshllarchdtecho;
  string t1l_bestfirstnmecho;
  string t1l_bestlastnmecho;
  integer8 t1l_bestfirstnmpopflag;
  integer8 t1l_bestlastnmpopflag;
  string t1l_bestfullnmecho;
  string t1l_curraddrprimrangeecho;
  string t1l_curraddrpredirecho;
  string t1l_curraddrprimnmecho;
  string t1l_curraddrsuffixecho;
  string t1l_curraddrpostdirecho;
  string t1l_curraddrunitdesigecho;
  string t1l_curraddrsecrangeecho;
  string t1l_curraddrcityecho;
  string t1l_curraddrstecho;
  string t1l_curraddrzip5echo;
  integer8 t1l_curraddrpopflag;
  string t1l_curraddrfullecho;
  integer8 t1l_curraddrolddt;
  integer8 t1l_curraddrnewdt;
  string t1l_bestssnecho;
  integer8 t1l_bestssnpopflag;
  integer8 t1l_bestdobecho;
  integer8 t1l_bestdobpopflag;
  string t1l_bestphnecho;
  integer8 t1l_bestphnpopflag;
  string t1l_bestdlecho;
  string t1l_bestdlstecho;
  integer8 t1l_bestdlpopflag;
  string t1l_bestdlexpdt;
  string t1l_bestfirstnmmatchesinpflag;
  string t1l_bestlastnmmatchesinpflag;
  integer8 t1l_bestfullnmmatchesinpflag;
  integer8 t1l_curraddrmatchesinpflag;
  string t1l_bestssnmatchesinpflag;
  integer8 t1l_bestdobmatchesinpflag;
  integer8 t1l_bestphnmatchesinpflag;
  integer8 t1l_bestdlmatchesinpflag;
  integer8 t1l_curraddrnotinagcyjurstflag;
  integer8 t1l_bestdlnotinagcyjurstflag;
  integer8 p1_aotidactcntev;
  integer8 p1_aotidactcnt30d;
  integer8 p9_aotidactcntev;
  integer8 p9_aotidactcnt30d;
  integer8 p15_aotidactcntev;
  integer8 p15_aotidactcnt30d;
  integer8 p16_aotidactcntev;
  integer8 p16_aotidactcnt30d;
  integer8 p17_aotidactcntev;
  integer8 p17_aotidactcnt30d;
  integer8 p18_aotidactcntev;
  integer8 p18_aotidactcnt30d;
  integer8 p19_aotidactcntev;
  integer8 p19_aotidactcnt30d;
  integer8 p20_aotidactcntev;
  integer8 p20_aotidactcnt30d;
  integer8 p1_aotaddactcntev;
  integer8 p1_aotaddactcnt30d;
  integer8 p9_aotaddactcntev;
  integer8 p9_aotaddactcnt30d;
  integer8 p15_aotaddactcntev;
  integer8 p15_aotaddactcnt30d;
  integer8 p16_aotaddactcntev;
  integer8 p16_aotaddactcnt30d;
  integer8 p17_aotaddactcntev;
  integer8 p17_aotaddactcnt30d;
  integer8 p18_aotaddactcntev;
  integer8 p18_aotaddactcnt30d;
  integer8 p19_aotaddactcntev;
  integer8 p19_aotaddactcnt30d;
  integer8 p20_aotaddactcntev;
  integer8 p20_aotaddactcnt30d;
  integer8 p1_aotnonstactcntev;
  integer8 p1_aotnonstactcnt30d;
  integer8 p9_aotnonstactcntev;
  integer8 p9_aotnonstactcnt30d;
  integer8 p15_aotnonstactcntev;
  integer8 p15_aotnonstactcnt30d;
  integer8 p16_aotnonstactcntev;
  integer8 p16_aotnonstactcnt30d;
  integer8 p17_aotnonstactcntev;
  integer8 p17_aotnonstactcnt30d;
  integer8 p18_aotnonstactcntev;
  integer8 p18_aotnonstactcnt30d;
  integer8 p19_aotnonstactcntev;
  integer8 p19_aotnonstactcnt30d;
  integer8 p20_aotnonstactcntev;
  integer8 p20_aotnonstactcnt30d;
  integer8 p1_aotidnewkraftidactcntev;
  integer8 p9_aotaddrnewkraftidactcntev;
  integer8 p15_aotssnnewkraftidactcntev;
  integer8 p16_aotphnnewkraftidactcntev;
  integer8 p17_aotemlnewkraftidactcntev;
  integer8 p18_aotipnewkraftidactcntev;
  integer8 p19_aotbkacnewkraftidactcntev;
  integer8 p20_aotdlnewkraftidactcntev;
  integer8 p1_aotidnewkraftaddactcntev;
  integer8 p9_aotaddrnewkraftaddactcntev;
  integer8 p15_aotssnnewkraftaddactcntev;
  integer8 p16_aotphnnewkraftaddactcntev;
  integer8 p17_aotemlnewkraftaddactcntev;
  integer8 p18_aotipnewkraftaddactcntev;
  integer8 p19_aotbkacnewkraftaddactcntev;
  integer8 p20_aotdlnewkraftaddactcntev;
  integer8 p1_aotidnewkraftnonstactcntev;
  integer8 p9_aotaddrnewkraftnonstactcntev;
  integer8 p15_aotssnnewkraftnonstactcntev;
  integer8 p16_aotphnnewkraftnonstactcntev;
  integer8 p17_aotemlnewkraftnonstactcntev;
  integer8 p18_aotipnewkraftnonstactcntev;
  integer8 p19_aotbkacnewkraftnonstactcntev;
  integer8 p20_aotdlnewkraftnonstactcntev;
  integer8 p9_aotidcurrprofusngaddrcntev;
  integer8 p15_aotidcurrprofusngssncntev;
  integer8 p16_aotidcurrprofusngphncntev;
  integer8 p17_aotidcurrprofusngemlcntev;
  integer8 p18_aotidcurrprofusngipcntev;
  integer8 p19_aotidcurrprofusngbkaccntev;
  integer8 p20_aotidcurrprofusngdlcntev;
  integer8 p9_aotidhistprofusngaddrcntev;
  integer8 p15_aotidhistprofusngssncntev;
  integer8 p16_aotidhistprofusngphncntev;
  integer8 p17_aotidhistprofusngemlcntev;
  integer8 p18_aotidhistprofusngipcntev;
  integer8 p19_aotidhistprofusngbkaccntev;
  integer8 p20_aotidhistprofusngdlcntev;
  integer8 p9_aotidusngaddrcntev;
  integer8 p15_aotidusngssncntev;
  integer8 p16_aotidusngphncntev;
  integer8 p17_aotidusngemailcntev;
  integer8 p18_aotidusngipaddrcntev;
  integer8 p19_aotidusngbnkacctcntev;
  integer8 p20_aotidusngdlcntev;
  integer8 p1_aotidnaccollactcntev;
  integer8 p1_aotidnaccollflagev;
  integer8 p1_aotidnaccollnewdt;
  integer8 p1_aotidnaccollnewtype;
  integer8 p1_idriskunscrbleflag;
  integer8 p9_addrriskunscrbleflag;
  integer8 p15_ssnriskunscrbleflag;
  integer8 p16_phnriskunscrbleflag;
  integer8 p17_emailriskunscrbleflag;
  integer8 p18_ipaddrriskunscrbleflag;
  integer8 p19_bnkacctriskunscrbleflag;
  integer8 p20_dlriskunscrbleflag;
  integer8 t1l_idcurrincarcflag;
  string t_inpclnfullnmecho;
  string t_acttmecho;
  string t_inpaddrtypeecho;
  string t_inpclnmailingaddrstreetecho;
  string t_inpclnmailingaddrcityecho;
  string t_inpclnmailingaddrstecho;
  string t_inpclnmailingaddrzipecho;
  string t_inpphncontacttypeecho;
  string t_inpclncellphnecho;
  string t_inpclnworkphnecho;
  string t_inpclnbnkacct2echo;
  string t_inpclnbnkacctrtg2echo;
  string t_inpethnicityecho;
  string t_inpraceecho;
  string t_inpheadofhhecho;
  string t_inprelationshipecho;
  string t_inpdvcuniquenumecho;
  string t_inpdvcmacaddrecho;
  string t_inpdvcserialnumecho;
  string t_inpdvctypeecho;
  string t_inpdvcidprovecho;
  real8 t_inpdvclatecho;
  real8 t_inpdvclongecho;
  string t_inpinvestigatoridecho;
  string t_inpreferralcaseidecho;
  string t_inpreferraltypedescecho;
  string t_inpreferralreasondescecho;
  string t_inpreferraldispositionecho;
  string t_inpclearedfraudecho;
  string t_inpreasondescecho;
  string t_inpclientidecho;
  string t_agencyusernm;
  string t_statusactiondesc;
  string t_inpclearedreasonecho;
  integer8 t1_idinvupdflag;
  integer8 t1l_iddtofdeath;
  integer8 t1l_idcrimflsdmatchflag;
  integer8 t1l_idcrimhitflag;
  integer8 t1_minoridflag;
  integer8 t9_idcurrprofusngaddrcntev;
  integer8 t15_idcurrprofusngssncntev;
  integer8 t20_idcurrprofusngdlcntev;
  integer8 t19_idcurrprofusngbnkacctcntev;
  string t9_addrvaltype;
  string t9_addrmaildroptype;
  string t15_ssnvaltype;
  string t20_dlvaltype;
  string t16_phnvaltype;
  integer8 t16_isphnmetahitflag;
  integer8 t16_phnmetanewvenddt;
  integer8 t16_phnmetaoldvenddt;
  integer8 t9_addrpoboxmultcurridflagev;
  integer8 t9_addrisvacantflag;
  integer8 t9_addrisinvalidflag;
  integer8 t9_addriscmraflag;
  integer8 t9_addrnotinagcyjurstflag;
  integer8 t15_ssnmultcurridflagev;
  integer8 t15_ssnisinvalidflag;
  integer8 t20_dlmultcurridflagev;
  integer8 t20_dlisinvalidflag;
  string t16_phnprepdflag;
  integer8 t16_phnisinvalidflag;
  integer8 t19_bnkacctmultcurridflagev;
  integer8 p1_idactolddt;
  integer8 p9_idactolddt;
  integer8 p15_idactolddt;
  integer8 p16_idactolddt;
  integer8 p17_idactolddt;
  integer8 p18_idactolddt;
  integer8 p19_idactolddt;
  integer8 p20_idactolddt;
  integer8 p1_aotactcntev;
  integer8 p1_aotsrc1actcntev;
  boolean p1_aotsrc1actonlyflag;
  integer8 p9_aotactcntev;
  integer8 p9_aotsrc1actcntev;
  boolean p9_aotsrc1actonlyflag;
  integer8 p15_aotactcntev;
  integer8 p15_aotsrc1actcntev;
  boolean p15_aotsrc1actonlyflag;
  integer8 p20_aotactcntev;
  integer8 p20_aotsrc1actcntev;
  boolean p20_aotsrc1actonlyflag;
  integer8 p16_aotactcntev;
  integer8 p16_aotsrc1actcntev;
  boolean p16_aotsrc1actonlyflag;
  integer8 p17_aotactcntev;
  integer8 p17_aotsrc1actcntev;
  boolean p17_aotsrc1actonlyflag;
  integer8 p18_aotactcntev;
  integer8 p18_aotsrc1actcntev;
  boolean p18_aotsrc1actonlyflag;
  integer8 p19_aotactcntev;
  integer8 p19_aotsrc1actcntev;
  boolean p19_aotsrc1actonlyflag;
  integer8 p1_aotidkractinagcycntev;
  integer8 p1_aotidkractinagcyflagev;
  integer8 p1_aotidkractinagcyolddtev;
  integer8 p1_aotidkractinagcynewdtev;
  integer8 p1_aotidkrappfrdactinagcycntev;
  integer8 p1_aotidkrappfrdactinagcyflagev;
  integer8 p1_aotidkrappfrdactinagcyolddtev;
  integer8 p1_aotidkrappfrdactinagcynewdtev;
  integer8 p1_aotidkrgenfrdactinagcycntev;
  integer8 p1_aotidkrgenfrdactinagcyflagev;
  integer8 p1_aotidkrgenfrdactinagcyolddtev;
  integer8 p1_aotidkrgenfrdactinagcynewdtev;
  integer8 p1_aotidkrothfrdactinagcycntev;
  integer8 p1_aotidkrothfrdactinagcyflagev;
  integer8 p1_aotidkrothfrdactinagcyolddtev;
  integer8 p1_aotidkrothfrdactinagcynewdtev;
  integer8 p1_aotidkrstolidactinagcycntev;
  integer8 p1_aotidkrstolidactinagcyflagev;
  integer8 p1_aotidkrstolidactinagcyolddtev;
  integer8 p1_aotidkrstolidactinagcynewdtev;
  integer8 p9_aotaddrkractinagcycntev;
  integer8 p9_aotaddrkractinagcyflagev;
  integer8 p9_aotaddrkractinagcyolddtev;
  integer8 p9_aotaddrkractinagcynewdtev;
  integer8 p15_aotssnkractinagcycntev;
  integer8 p15_aotssnkractinagcyflagev;
  integer8 p15_aotssnkractinagcyolddtev;
  integer8 p15_aotssnkractinagcynewdtev;
  integer8 p16_aotphnkractinagcycntev;
  integer8 p16_aotphnkractinagcyflagev;
  integer8 p16_aotphnkractinagcyolddtev;
  integer8 p16_aotphnkractinagcynewdtev;
  integer8 p17_aotemailkractinagcycntev;
  integer8 p17_aotemailkractinagcyflagev;
  integer8 p17_aotemailkractinagcyolddtev;
  integer8 p17_aotemailkractinagcynewdtev;
  integer8 p18_aotipaddrkractinagcycntev;
  integer8 p18_aotipaddrkractinagcyflagev;
  integer8 p18_aotipaddrkractinagcyolddtev;
  integer8 p18_aotipaddrkractinagcynewdtev;
  integer8 p19_aotbnkacctkractinagcycntev;
  integer8 p19_aotbnkacctkractinagcyflagev;
  integer8 p19_aotbnkacctkractinagcyolddtev;
  integer8 p19_aotbnkacctkractinagcynewdtev;
  integer8 p20_aotdlkractinagcycntev;
  integer8 p20_aotdlkractinagcyflagev;
  integer8 p20_aotdlkractinagcyolddtev;
  integer8 p20_aotdlkractinagcynewdtev;
  string t_inpclnaddrgeomatchecho;
  integer8 p1_aotidkractshrdsrcagencycntev;
  string p1_aotidkractshrdnewsrcagencydescev;
  integer8 p1_aotidkrgenfrdactshrdsrcagencycntev;
  string p1_aotidkrgenfrdactshrdnewsrcagencydescev;
  integer8 p1_aotidkrstolidactshrdsrcagencycntev;
  string p1_aotidkrstolidactshrdnewsrcagencydescev;
  integer8 p1_aotidkrappfrdactshrdsrcagencycntev;
  string p1_aotidkrappfrdactshrdnewsrcagencydescev;
  integer8 p1_aotidkrothfrdactshrdsrcagencycntev;
  string p1_aotidkrothfrdactshrdnewsrcagencydescev;
  integer8 p9_aotaddrkractshrdsrcagencycntev;
  string p9_aotaddrkractshrdnewsrcagencydescev;
  integer8 p15_aotssnkractshrdsrcagencycntev;
  string p15_aotssnkractshrdnewsrcagencydescev;
  integer8 p16_aotphnkractshrdsrcagencycntev;
  string p16_aotphnkractshrdnewsrcagencydescev;
  integer8 p17_aotemailkractshrdsrcagencycntev;
  string p17_aotemailkractshrdnewsrcagencydescev;
  integer8 p18_aotipaddrkractshrdsrcagencycntev;
  string p18_aotipaddrkractshrdnewsrcagencydescev;
  integer8 p19_aotbnkacctkractshrdsrcagencycntev;
  string p19_aotbnkacctkractshrdnewsrcagencydescev;
  integer8 p20_aotdlkractshrdsrcagencycntev;
  string p20_aotdlkractshrdnewsrcagencydescev;
  string t18_ipaddrgeoloclat;
  string t18_ipaddrgeoloclong;
  string t_srcagencydesc;
  string agencydesc;
  string t_srcagencyprogdesc;
  string t_srcagencyprogjurst;
  string t_addrstatusdesc;
  string t_bnkacctstatusdesc;
  string t_dlstatusdesc;
  string t_emailstatusdesc;
  string t_evttype1statusdesc;
  string t_evttype2statusdesc;
  string t_evttype3statusdesc;
  string t_idstatusdesc;
  string t_namestatusdesc;
  string t_ipaddrstatusdesc;
  string t_phnstatusdesc;
  string t_ssnstatusdesc;
  string t_inpdvciprovecho;
  string t_inpclnbnkacct2rtg2echo;
  integer1 p1_idriskindx;
  integer1 p15_ssnriskindx;
  integer1 p16_phnriskindx;
  integer1 p17_emailriskindx;
  integer1 p19_bnkacctriskindx;
  integer1 p20_dlriskindx;
  integer1 p18_ipaddrriskindx;
  integer1 p9_addrriskindx;
  unsigned8 iscurrent;
  unsigned8 ishistorical;
 END;

 EXPORT EntityRules	:=	RECORD
  unsigned8 customerid;
  unsigned8 industrytype;
  string100 entitycontextuid;
  string100 rulename;
  string250 description;
  integer1 risklevel;
 END;
 
 EXPORT EntityAttributes := RECORD
  string field;
  string value;
  string indicatortype;
  string indicatordescription;
  string label;
  string fieldtype;
  integer8 risklevel;
  integer8 customerid;
  integer8 industrytype;
  string entitycontextuid;
  integer8 recordid;
  integer8 recs;
  integer8 weight;
  integer8 entitytype;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  integer1 aotcurrprofflag;
  unsigned8 iscurrent;
  unsigned4 t_actdtecho;
  integer8 t18_ipaddrlocmiamiflag;
  integer8 t18_ipaddrlocnonusflag;
  integer8 t18_ipaddrhostedflag;
  integer8 t18_ipaddrvpnflag;
  integer8 t18_ipaddrtornodeflag;
  integer8 t19_bnkaccthrprepdrtgflag;
  integer8 t17_emaildomaindispflag;
  integer8 p1_aotidkrstolidactflagev;
  integer8 p1_aotidkrgenfrdactflagev;
  integer8 p1_aotidkrappfrdactflagev;
  integer8 p1_aotidkrothfrdactflagev;
  integer8 p9_aotaddrkractflagev;
  integer8 p15_aotssnkractflagev;
  integer8 p16_aotphnkractflagev;
  integer8 p17_aotemailkractflagev;
  integer8 p18_aotipaddrkractflagev;
  integer8 p19_aotbnkacctkractflagev;
  integer8 p20_aotdlkractflagev;
  unsigned1 not_aotkractflagev;
  unsigned1 not_aotsafeactflagev;
  integer8 t1l_dobnotverflag;
  integer8 t1_stolidflag;
  integer8 t1_synthidflag;
  integer8 t1_manipidflag;
  integer8 t1_adultidnotseenflag;
  integer8 t1_addrnotverflag;
  integer8 t1l_ssnwaltnaverflag;
  integer8 t1_firstnmnotverflag;
  integer8 t1_hiriskcviflag;
  integer8 t1_medriskcviflag;
  integer8 t1_minorwlexidflag;
  integer8 t1_lastnmnotverflag;
  integer8 t1_phnnotverflag;
  integer8 t1l_ssnwaddrnotverflag;
  string t1_ssnpriordobflag;
  integer8 t1l_ssnnotverflag;
  integer8 t1l_curraddrnotinagcyjurstflag;
  integer8 t1l_bestdlnotinagcyjurstflag;
  integer8 t1l_hdrsrccatcntlwflag;
  integer8 t1l_iddeceasedflag;
  integer8 t1l_idcurrincarcflag;
  integer8 t1l_iddtofdeathaftidactflagev;
  unsigned8 aotidcurrprofusngcntev;
  integer8 t9_addrisvacantflag;
  integer8 t9_addrisinvalidflag;
  integer8 t9_addriscmraflag;
  integer8 t9_addrpoboxmultcurridflagev;
  integer8 t9_addrnotinagcyjurstflag;
  integer8 t15_ssnisinvalidflag;
  integer8 t15_ssnmultcurridflagev;
  integer8 t16_phnisinvalidflag;
  string t16_phnprepdflag;
  integer8 t19_bnkacctmultcurridflagev;
  integer8 t20_dlisinvalidflag;
  integer8 t20_dlmultcurridflagev;
  integer8 incustomerpopulation;
  integer8 t_inagencyflag;
  integer1 riskindx;
  integer8 p1_aotidkrappfrdactshrdflagev;
  integer8 p1_aotidkrgenfrdactshrdflagev;
  integer8 p1_aotidkrothfrdactshrdflagev;
  integer8 p1_aotidkrstolidactshrdflagev;
  integer8 p9_aotaddrkractshrdflagev;
  integer8 p15_aotssnkractshrdflagev;
  integer8 p16_aotphnkractshrdflagev;
  integer8 p17_aotemailkractshrdflagev;
  integer8 p18_aotipaddrkractshrdflagev;
  integer8 p19_aotbnkacctkractshrdflagev;
  integer8 p20_aotdlkractshrdflagev;
  integer8 p1_aotidkrstolidactinagcyflagev;
  integer8 p1_aotidkrgenfrdactinagcyflagev;
  integer8 p1_aotidkrappfrdactinagcyflagev;
  integer8 p1_aotidkrothfrdactinagcyflagev;
  integer8 p9_aotaddrkractinagcyflagev;
  integer8 p15_aotssnkractinagcyflagev;
  integer8 p16_aotphnkractinagcyflagev;
  integer8 p17_aotemailkractinagcyflagev;
  integer8 p18_aotipaddrkractinagcyflagev;
  integer8 p19_aotbnkacctkractinagcyflagev;
  integer8 p20_aotdlkractinagcyflagev;
 END;

 EXPORT GraphEdges	:= RECORD
  integer8 customerid;
  integer8 industrytype;
  string treeuid;
  string fromentitycontextuid;
  string toentitycontextuid;
  unsigned4 t_actdtecho;
 END;
 
 EXPORT GraphVertices := RECORD
  integer8 customerid;
  integer8 industrytype;
  string treeuid;
  string entitycontextuid;
  unsigned4 t_actdtecho;
  integer1 entitytype;
  string label;
  integer1 riskindx;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  integer8 personeventcount;
  integer8 t_inpclndobecho;
  integer8 t1l_iddeceasedflag;
  unsigned8 aotidactcntev;
  unsigned4 deceaseddate;
  integer8 t1_minoridflag;
  integer8 t_inagencyflag;
 END;


  //Begin BocaShell Layout

﻿includeADLFields := FALSE; // If you set this to TRUE, make sure you set it to TRUE in Risk_Indicators.ToEdina_v4!

layout_counts := RECORD
    unsigned2 counttotal;
    unsigned2 countday;  // new for shell 5.0
    unsigned2 countweek;	// new for shell 5.0
    unsigned2 count01;
    unsigned2 count03;
    unsigned2 count06;
    unsigned2 count12;
    unsigned2 count24;
   END;

Layout_inq_PII_tumblings := RECORD
	integer	inq_ssnsperadl_1subs	;
	integer	inq_phnsperadl_1subs	;
	integer	inq_primrangesperadl_1subs	;
	integer	inq_dobsperadl_1subs	;
	integer	inq_fnamesperadl_1subs	;
	integer	inq_lnamesperadl_1subs	;
	integer	inq_dobsperadl_daysubs	;
	integer	inq_dobsperadl_mosubs	;
	integer	inq_dobsperadl_yrsubs	;
	integer	inq_ssnsperadl_1dig	;
	integer	inq_phnsperadl_1dig	;
	integer	inq_primrangesperadl_1dig	;
	integer	inq_dobsperadl_1dig	;
	integer	inq_primrangesperssn_1dig	;
	integer	inq_dobsperssn_1dig	;
	integer	inq_ssnsperaddr_1dig	;
END;

Layout_inq_PII_corroboration := RECORD
	integer	inq_corrnameaddr	;
	integer	inq_corrnameaddr_adl	;
	integer	inq_corrnamessn	;
	integer	inq_corrnamessn_adl	;
	integer	inq_corrnamephone	;
	integer	inq_corrnamephone_adl	;
	integer	inq_corraddrssn	;
	integer	inq_corraddrssn_adl	;
	integer	inq_corrdobaddr	;
	integer	inq_corrdobaddr_adl	;
	integer	inq_corraddrphone	;
	integer	inq_corraddrphone_adl	;
	integer	inq_corrdobssn	;
	integer	inq_corrdobssn_adl	;
	integer	inq_corrphonessn	;
	integer	inq_corrphonessn_adl	;
	integer	inq_corrdobphone	;
	integer	inq_corrdobphone_adl	;
	integer	inq_corrnameaddrssn	;
	integer	inq_corrnameaddrssn_adl	;
	integer	inq_corrnamephonessn	;
	integer	inq_corrnamephonessn_adl	;
	integer	inq_corrnameaddrphnssn	;
	integer	inq_corrnameaddrphnssn_adl	;
END;

layout_best_pii_inquiries := record
	unsigned2 inq_perbestssn := 0;
	unsigned2 inq_adlsperbestssn := 0;
	unsigned2 inq_lnamesperbestssn := 0;
	unsigned2 inq_addrsperbestssn := 0;
	unsigned2 inq_dobsperbestssn := 0;
	unsigned2 inq_percurraddr := 0;
	unsigned2 inq_adlspercurraddr := 0;
	unsigned2 inq_lnamespercurraddr := 0;
	unsigned2 inq_ssnspercurraddr := 0;
	unsigned2 inq_curraddr_ver_count := 0;
	unsigned2 inq_bestfname_ver_count := 0;
	unsigned2 inq_bestlname_ver_count := 0;
	unsigned2 inq_bestssn_ver_count := 0;
	unsigned2 inq_bestdob_ver_count := 0;
end;

layout_inquiries_edina := RECORD
	string8 first_log_date;
	string8 last_log_date;
	integer2 inquiry_addr_ver_ct;
	integer2 inquiry_fname_ver_ct;
	integer2 inquiry_lname_ver_ct;
	integer2 inquiry_ssn_ver_ct;
	integer2 inquiry_dob_ver_ct;
	integer2 inquiry_phone_ver_ct;
	integer2 inquiry_email_ver_ct;  // new for shell 5.0
	layout_counts inquiries;
	layout_counts auto;
	layout_counts banking;
	layout_counts collection;
	layout_counts communications;
	layout_counts highriskcredit;
	layout_counts mortgage;
	layout_counts other;
	layout_counts prepaidCards;  // new for shell 5.0
	layout_counts QuizProvider;  // new for shell 5.0
	layout_counts retail;
	layout_counts retailPayments;// new for shell 5.0
	layout_counts StudentLoans;// new for shell 5.0
	layout_counts Utilities;// new for shell 5.0
  integer3 bus_inq_count12 := 0;  //new for 5.4
  integer3 bus_inq_credit_count12 := 0;  //new for 5.4
  integer3 bus_inq_highriskcredit_count12 := 0;  //new for 5.4
  integer3 bus_inq_other_count12 := 0;  //new for 5.4
	
   unsigned2 inquiryperadl;
		unsigned2	inq_peradl_count_day	;
		unsigned2	inq_peradl_count_week	;
		unsigned2	inq_peradl_count01	;
		unsigned2	inq_peradl_count03	;
		unsigned2	inq_peradl_count06	;
		
   unsigned2 inquiryssnsperadl;
		unsigned2	inq_ssnsperadl_count_day	;
		unsigned2	inq_ssnsperadl_count_week	;
		unsigned2	inq_ssnsperadl_count01	;
		unsigned2	inq_ssnsperadl_count03	;
		unsigned2	inq_ssnsperadl_count06	;	
		
   unsigned2 inquiryaddrsperadl;
		unsigned2	inq_addrsperadl_count_day	;
		unsigned2	inq_addrsperadl_count_week	;
		unsigned2	inq_addrsperadl_count01	;
		unsigned2	inq_addrsperadl_count03	;
		unsigned2	inq_addrsperadl_count06	;
		
   unsigned2 inquirylnamesperadl;
		unsigned2	inq_lnamesperadl_count_day	;
		unsigned2	inq_lnamesperadl_count_week	;
		unsigned2	inq_lnamesperadl_count01	;
		unsigned2	inq_lnamesperadl_count03	;
		unsigned2	inq_lnamesperadl_count06	;
		
   unsigned2 inquiryfnamesperadl;
		unsigned2	inq_fnamesperadl_count_day	;
		unsigned2	inq_fnamesperadl_count_week	;
		unsigned2	inq_fnamesperadl_count01	;
		unsigned2	inq_fnamesperadl_count03	;
		unsigned2	inq_fnamesperadl_count06	;
		
   unsigned2 inquiryphonesperadl;
		unsigned2	inq_phonesperadl_count_day	;
		unsigned2	inq_phonesperadl_count_week	;
		unsigned2	inq_phonesperadl_count01	;
		unsigned2	inq_phonesperadl_count03	;
		unsigned2	inq_phonesperadl_count06	;
		
   unsigned2 inquirydobsperadl;
		unsigned2	inq_dobsperadl_count_day	;
		unsigned2	inq_dobsperadl_count_week	;
		unsigned2	inq_dobsperadl_count01	;
		unsigned2	inq_dobsperadl_count03	;
		unsigned2	inq_dobsperadl_count06	;
		
   unsigned2 inquiryperssn;
		unsigned2	inq_perssn_count_day	;
		unsigned2	inq_perssn_count_week	;
		unsigned2	inq_perssn_count01	;
		unsigned2	inq_perssn_count03	;
		unsigned2	inq_perssn_count06	;
		
   unsigned2 inquiryadlsperssn;
		unsigned2	inq_adlsperssn_count_day	;
		unsigned2	inq_adlsperssn_count_week	;
		unsigned2	inq_adlsperssn_count01	;
		unsigned2	inq_adlsperssn_count03	;
		unsigned2	inq_adlsperssn_count06	;
		
   unsigned2 inquirylnamesperssn;
		unsigned2	inq_lnamesperssn_count_day	;
		unsigned2	inq_lnamesperssn_count_week	;
		unsigned2	inq_lnamesperssn_count01	;
		unsigned2	inq_lnamesperssn_count03	;
		unsigned2	inq_lnamesperssn_count06	;
		
   unsigned2 inquiryaddrsperssn;
		unsigned2	inq_addrsperssn_count_day	;
		unsigned2	inq_addrsperssn_count_week	;
		unsigned2	inq_addrsperssn_count01	;
		unsigned2	inq_addrsperssn_count03	;
		unsigned2	inq_addrsperssn_count06	;
		
   unsigned2 inquirydobsperssn;
		unsigned2	inq_dobsperssn_count_day	;
		unsigned2	inq_dobsperssn_count_week	;
		unsigned2	inq_dobsperssn_count01	;
		unsigned2	inq_dobsperssn_count03	;
		unsigned2	inq_dobsperssn_count06	;
		
   unsigned2 inquiryperaddr;
		unsigned2	inq_peraddr_count_day	;
		unsigned2	inq_peraddr_count_week	;
		unsigned2	inq_peraddr_count01	;
		unsigned2	inq_peraddr_count03	;
		unsigned2	inq_peraddr_count06	;
	
   unsigned2 inquiryadlsperaddr;
		unsigned2	inq_adlsperaddr_count_day	;
		unsigned2	inq_adlsperaddr_count_week	;
		unsigned2	inq_adlsperaddr_count01	;
		unsigned2	inq_adlsperaddr_count03	;
		unsigned2	inq_adlsperaddr_count06	;
	
   unsigned2 inquirylnamesperaddr;
		unsigned2	inq_lnamesperaddr_count_day	;
		unsigned2	inq_lnamesperaddr_count_week	;
		unsigned2	inq_lnamesperaddr_count01	;
		unsigned2	inq_lnamesperaddr_count03	;
		unsigned2	inq_lnamesperaddr_count06	;
	
   unsigned2 inquiryssnsperaddr;
		unsigned2	inq_ssnsperaddr_count_day	;
		unsigned2	inq_ssnsperaddr_count_week	;
		unsigned2	inq_ssnsperaddr_count01	;
		unsigned2	inq_ssnsperaddr_count03	;
		unsigned2	inq_ssnsperaddr_count06	;
	
   unsigned2 inquiryperphone;
		unsigned2	inq_perphone_count_day	;
		unsigned2	inq_perphone_count_week	;
		unsigned2	inq_perphone_count01	;
		unsigned2	inq_perphone_count03	;
		unsigned2	inq_perphone_count06	;
	
   unsigned2 inquiryadlsperphone;
		unsigned2	inq_adlsperphone_count_day	;
		unsigned2	inq_adlsperphone_count_week	;
		unsigned2	inq_adlsperphone_count01	;
		unsigned2	inq_adlsperphone_count03	;
		unsigned2	inq_adlsperphone_count06	;
	
	 unsigned2 inquiryemailsperADL;
		unsigned2	inq_emailsperadl_count_day	;
		unsigned2	inq_emailsperadl_count_week	;
		unsigned2	inq_emailsperadl_count01	;
		unsigned2	inq_emailsperadl_count03	;
		unsigned2	inq_emailsperadl_count06	;
	
   unsigned2 inquiryADLsperEmail;
		unsigned2	inq_adlsperemail_count_day	;
		unsigned2	inq_adlsperemail_count_week	;
		unsigned2	inq_adlsperemail_count01	;
		unsigned2	inq_adlsperemail_count03	;
		unsigned2	inq_adlsperemail_count06	;

		Layout_inq_PII_tumblings; //     		 inq_PII_tumblings; //new for 5.3

		string8 am_first_seen_date;
		string8 am_last_seen_date;
		string8 cm_first_seen_date;
		string8 cm_last_seen_date;
		string8 om_first_seen_date;
		string8 om_last_seen_date;
	
		layout_best_pii_inquiries;
		
		Layout_inq_PII_corroboration; //     inq_PII_corroboration; //new for 5.3
		
  END;
	
Layout_Name_Verification := RECORD
	UNSIGNED1 adl_score;			
	UNSIGNED1 fname_score;
	UNSIGNED1 lname_score;
	UNSIGNED3 lname_change_date;
	UNSIGNED3 lname_prev_change_date;
	UNSIGNED1 source_count;
	BOOLEAN fname_eda_sourced;
	string2 fname_eda_sourced_type;
	BOOLEAN lname_eda_sourced;
	string2 lname_eda_sourced_type;
	UNSIGNED1 age;
END;

Layout_Address_AVM_edina := RECORD
	unsigned8 avm_automated_valuation;	
	unsigned8 avm_automated_valuation2;
	unsigned8 avm_automated_valuation3;
	unsigned8 avm_automated_valuation4;
	unsigned8 avm_automated_valuation5;
	unsigned8 avm_automated_valuation6;
	unsigned1 avm_confidence_score;
	unsigned8 avm_median_fips_level;
	unsigned8 avm_median_geo11_level;
	unsigned8 avm_median_geo12_level;
END;

Layout_Address_Information_Edina := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	UNSIGNED4 unit_count;
	unsigned2 lres;
	
	
	boolean dirty_address;
	boolean not_verified;
	boolean owned_not_occupied;
	integer non_relative_ADLs;
	integer occupancy_index;
	
	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;

	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5   mortgage_type;
	string4   type_financing;
	string8   first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	string4	assessed_value_year;

	// address risk fields
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//
	
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Address_Information_Edina1 := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	string1 addr_type;
	unsigned2 lres;
	
	integer1 occupancy_index;  

	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	UNSIGNED1 source_count;
	
	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;	
	string8 first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
		string4 standardized_land_use_code;
	string4	assessed_value_year;
	boolean hr_address;
	// address risk fields
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//	
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Address_Information_Edina2 := RECORD
	UNSIGNED3 address_score;
	BOOLEAN House_Number_match;
	BOOLEAN isBestMatch;
	string1 addr_type;
	unsigned2 lres; 
	// advo fields
		string1		Address_Vacancy_Indicator		;
		string1		Throw_Back_Indicator			;
		string1		Seasonal_Delivery_Indicator		;
		string1		DND_Indicator					;
		string1		College_Indicator				;
		string1		Drop_Indicator					;
		string1		Residential_or_Business_Ind		;
		string1		Mixed_Address_Usage				;
	//
	Layout_Address_AVM_edina;
	decimal5_2 fips_fc_index;
	decimal5_2 geo11_fc_index;
	decimal5_2 geo12_fc_index;
	
	UNSIGNED1 source_count;
	
	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string100 addr_sources_recordcount := '';
	
	BOOLEAN eda_sourced;
	BOOLEAN applicant_owned;
	BOOLEAN occupant_owned;
	BOOLEAN family_owned;
 	UNSIGNED1 NAProp;
	UNSIGNED4 purchase_date;
	UNSIGNED4 built_date;
	UNSIGNED4 purchase_amount;
	UNSIGNED4 mortgage_amount;
	UNSIGNED4 mortgage_date;
	string5 mortgage_type;
	string4 type_financing;
	string8 first_td_due_date;
	UNSIGNED4 market_total_value;
	UNSIGNED4 assessed_total_value;
	UNSIGNED4 date_first_seen;
	UNSIGNED4 date_last_seen;
	string4 standardized_land_use_code;
	string4	assessed_value_year;
	BOOLEAN HR_Address;
		// address risk fields from shell 4.0
		unsigned2 occupants_1yr;
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 N_Vacant_Properties;
		unsigned2	N_Business_Count;
		unsigned2 N_SFD_Count;
		unsigned2 N_MFD_Count;
		unsigned4 N_ave_building_age;
		unsigned4 N_ave_purchase_amount;
		unsigned4 N_ave_mortgage_amount;
		unsigned4 N_ave_assessed_amount;
		unsigned8 N_ave_building_area;
		unsigned8	N_ave_price_per_sf;
		unsigned8 N_ave_no_of_stories_count;
		unsigned8 N_ave_no_of_rooms_count;
		unsigned8 N_ave_no_of_bedrooms_count;
		unsigned8 N_ave_no_of_baths_count;	
	//	
	boolean addrPop;
	string2  st;
	string5  zip5;
	string3 county;
	string7 geo_blk;
END;

Layout_Property_Value_edina := RECORD
	UNSIGNED2 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
END;

Layout_Property_Value_edina_ambig := RECORD
	UNSIGNED1 property_total;
END;

Layout_Applicant_Property_Values_edina := RECORD
	Layout_Property_Value_edina 	owned;
	integer bus_property_owned_total;
	integer bus_property_owned_assess_total;
	integer bus_property_owned_assess_count;
	Layout_Property_Value_edina 	sold;
	integer bus_property_sold_total;
	integer bus_property_sold_assess_total;
	integer bus_property_sold_assess_count;
	Layout_Property_Value_edina_ambig 	ambiguous;
END;

Layout_Recent_Property_Sales := RECORD
	unsigned8 sale_price1;
	unsigned8 sale_date1;	
	unsigned8 prev_purch_price1;
	unsigned8 prev_purch_date1;
	unsigned8 sale_price2;
	unsigned8 sale_date2;
	unsigned8 prev_purch_price2;
	unsigned8 prev_purch_date2;
END;

Layout_Address_Verification := RECORD
	Layout_Address_Information_Edina 					Input_Address_Information;
	Layout_Applicant_Property_values_edina;	
	Layout_Recent_Property_Sales 							Recent_Property_Sales;
	INTEGER2 distance_in_2_h1;
	INTEGER2 distance_in_2_h2;
	INTEGER2 distance_h1_2_h2;
	unsigned1 addr1addr2score;
	unsigned1 addr1addr3score;
	unsigned1 addr2addr3score;
	Layout_Address_Information_Edina1 				Address_History_1;
	Layout_Address_Information_Edina2 				Address_History_2;
END;

Layout_Gong_DID := RECORD
	string8 gong_adl_dt_first_seen_full;
	string8 gong_adl_dt_last_seen_full;
END;

Layout_Phone_Verification := RECORD
	STRING2 telcordia_type;
	UNSIGNED1 recent_disconnects;
	Layout_Gong_DID 		Gong_DID;
	string2 Insurance_Phone_Verification;
	string2 phone_ver_bureau;
END;	

Layout_SSN_Information := RECORD
	UNSIGNED2 namePerSSN_count;
	UNSIGNED3 header_first_seen;
	UNSIGNED3 header_last_seen;
	BOOLEAN utility_sourced;
	string1 inputsocscharflag;
END;

Layout_Input_Validation := RECORD
	BOOLEAN FirstName;
	BOOLEAN LastName;
	BOOLEAN Address;
	STRING1 SSN_Length;	
	integer ssnLookupFlag;
	BOOLEAN DateOfBirth;
	BOOLEAN Email;
	BOOLEAN IPAddress;
	BOOLEAN HomePhone;
END;

Layout_Available_Sources := RECORD
	BOOLEAN DL;
	BOOLEAN Voter;
END;

Layout_ConsumerFlags_edina :=RECORD
	boolean corrected_flag;
	boolean consumer_statement_flag;
	boolean dispute_flag;
	boolean security_freeze;
	boolean security_alert;
	boolean negative_alert;
	boolean id_theft_flag;
END;

Layout_InstantID_Results := RECORD
	INTEGER1 NAS_Summary;
	INTEGER1 NAP_Summary;
	STRING1 NAP_Type;
	STRING1 NAP_Status;
	INTEGER1 CVI;
	string2 reason1;
  string2 reason2;
  string2 reason3;
  string2 reason4;
	string2 reason5;
  string2 reason6;
	unsigned1 DIDCount;	// - The total number of DIDs found	
	unsigned6 DID2;	// - The second DID returned from the DID Append
	unsigned6 DID3;	// - The third DID returned from the DID Append
	STRING20 correctlast;
	string8 correctdob;
	UNSIGNED1 dirsaddr_lastscore;
	STRING2 drlcvalflag;
	STRING10 watchlist_record_number;
	string10 name_addr_phone;
	BOOLEAN non_us_ssn;	
	unsigned4 deceasedDate;
	boolean inputAddrNotMostRecent;
	UNSIGNED1 combo_sec_rangescore;
	STRING1 hriskphoneflag;
	STRING1 hphonetypeflag;	 
	STRING1 phonevalflag;  
	STRING1 hphonevalflag;  
	STRING1 phonezipflag;
	STRING1 PWphonezipflag;  
	STRING1 hriskaddrflag;
	STRING1 decsflag;
	STRING1 socsdobflag;
	STRING1 PWsocsdobflag;
	STRING1 socsvalflag;
	STRING1 PWsocsvalflag;
	UNSIGNED4 socllowissue;
	UNSIGNED4 soclhighissue;
	STRING2 soclstate;
	STRING1 areacodesplitflag;
	UNSIGNED4 areacodesplitdate;
	STRING1 addrvalflag;
	STRING1 dwelltype;
	STRING1 bansflag;
	UNSIGNED2 firstcount;
	UNSIGNED2 lastcount;
	UNSIGNED2 addrcount;
	UNSIGNED2 socscount;
	UNSIGNED2 numelever;
	UNSIGNED2 phonelastcount;
	UNSIGNED2 phoneaddrcount;
	UNSIGNED2 phonephonecount;
	UNSIGNED2 phoneaddr_lastcount;
	UNSIGNED2 phoneaddr_addrcount;
	UNSIGNED2 phoneaddr_phonecount;
	UNSIGNED2 utiliaddr_lastcount;
	UNSIGNED2 utiliaddr_addrcount;
	UNSIGNED2 utiliaddr_phonecount;
	BOOLEAN socsmiskeyflag;
	BOOLEAN hphonemiskeyflag;
	BOOLEAN addrmiskeyflag;
	STRING1 addrcommflag;
	STRING6 hrisksic;
	STRING6 hrisksicphone;
	UNSIGNED3 disthphoneaddr;
	STRING1 phonetype;
	STRING1 ziptypeflag; 
	string1 zipclass;
	STRING1 statezipflag;
	STRING1 cityzipflag;
	boolean altlastPop;	
	boolean altlast2Pop; 	
	BOOLEAN lastssnmatch := true;
	BOOLEAN lastssnmatch2 := true;
	BOOLEAN firstssnmatch := true;	
	UNSIGNED1 combo_firstscore;
	UNSIGNED1 combo_lastscore;
	UNSIGNED1 combo_addrscore;
	UNSIGNED1 combo_hphonescore;
	UNSIGNED1 combo_ssnscore;
	UNSIGNED1 combo_dobscore;
	UNSIGNED1 combo_firstcount;
	UNSIGNED1 combo_lastcount;
	UNSIGNED1 combo_addrcount;
	UNSIGNED1 combo_hphonecount;
	UNSIGNED1 combo_ssncount;
	UNSIGNED1 combo_dobcount;
	boolean watchlistHit; 
	Layout_ConsumerFlags_edina							ConsumerFlags;
END;

edina_Layout_Input := RECORD
	STRING20 fname;
	STRING120 in_streetAddress;
	STRING25 in_city;
	STRING2 in_state;
	STRING5 in_zipCode;
	STRING25 in_country;
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat;
	STRING11 long;
	string3 county;
	string7 geo_blk;
	STRING1  addr_type;
	STRING4  addr_status;
	STRING25 country;
	STRING8  dob;
	STRING50 email_address;
	STRING45 ip_address;
	STRING10 phone10;
END;

Layout_ADL_Information := RECORD
	unsigned1 ssns_per_adl;
	unsigned1 addrs_per_adl;
	unsigned1 phones_per_adl;
	unsigned1 lnames_per_adl := 0;
	UNSIGNED2 adlPerSSN_count;
	unsigned2 adls_per_bestssn := 0;  // from best_flags section
	unsigned1 addrs_per_ssn; 
	unsigned1 addrs_per_bestssn; // from best_flags section
	unsigned1 adls_per_addr_current;
	unsigned1 adls_per_curraddr_current; // from best_flags section
	unsigned1 ssns_per_addr_current;
	unsigned1 ssns_per_curraddr_current;  // from best_flags section
	unsigned1 phones_per_addr_current;
	unsigned1 phones_per_curraddr_current; // from best_flags section
	unsigned1 adls_per_phone_current; 
	unsigned1 ssns_per_adl_created_6months;
	unsigned1 addrs_per_adl_created_6months;
	unsigned1 phones_per_adl_created_6months;
	unsigned1 lnames_per_adl_created_6months := 0;  
	unsigned1 adls_per_ssn_created_6months;	
	unsigned1 adls_per_bestssn_created_6months;	// from best_flags section
	unsigned1 addrs_per_ssn_created_6months;
	unsigned1 addrs_per_bestssn_created_6months; // from best_flags section
	unsigned1 adls_per_addr_created_6months;
	unsigned1 adls_per_curraddr_created_6months;// from best_flags section
	unsigned1 ssns_per_addr_created_6months;
	unsigned1 ssns_per_curraddr_created_6months; // from best_flags section
	unsigned1 phones_per_addr_created_6months;
	unsigned1 phones_per_curraddr_created_6months;  // from best_flags section
	unsigned1 adls_per_phone_created_6months;
	unsigned1 dl_addrs_per_adl;
	unsigned1 vo_addrs_per_adl;
	unsigned1 pl_addrs_per_adl;
	unsigned1 invalid_phones_per_adl;
	unsigned1 invalid_phones_per_adl_created_6months;
	unsigned1 invalid_ssns_per_adl;
	unsigned1 invalid_ssns_per_adl_created_6months;
	unsigned1 invalid_addrs_per_adl;
	unsigned1 invalid_addrs_per_adl_created_6months;	
END;

Layout_Other_Address_Fields := RECORD
	unsigned2 avg_lres;
	unsigned2 max_lres;
	unsigned1 addrs_last_5years;
	unsigned1 addrs_last_10years;
	unsigned1 addrs_last_15years;
	integer1 economic_trajectory := 0; 
	integer1 economic_trajectory_index := 0; 
	boolean addrsMilitaryEver := false;  
	boolean isPrison := false;
	boolean address_history_advo_college_hit := false;
	integer unverified_addr_count := 0;  
END;

Layout_Property_Value_R := RECORD
	UNSIGNED2 relatives_property_count;
	UNSIGNED2 relatives_property_total;
	UNSIGNED5 relatives_property_owned_purchase_total;
	UNSIGNED2 relatives_property_owned_purchase_count;
	UNSIGNED5 relatives_property_owned_assessed_total;
	UNSIGNED2 relatives_property_owned_assessed_count;
END;

Layout_Relative_Property_Values := RECORD
	Layout_Property_Value_R 	owned;
	Layout_Property_Value_R 	sold;
END;


Layout_Attributes := RECORD
	unsigned1 addrs_last30;
	unsigned1 addrs_last90;
	unsigned1 addrs_last12;
	unsigned1 addrs_last24;
	unsigned1 addrs_last36;	
	unsigned4 date_first_purchase;
	unsigned4 date_most_recent_purchase;
	unsigned4 date_most_recent_sale;
	unsigned1 num_aircraft;
	unsigned1 total_number_derogs;
	unsigned4 date_last_derog;
	unsigned1 arrests;
	unsigned4 date_last_arrest;
	unsigned1 num_unreleased_liens30;
	unsigned1 num_unreleased_liens90;
	unsigned1 num_unreleased_liens180;
	unsigned1 num_unreleased_liens12;
	unsigned1 num_unreleased_liens24;
	unsigned1 num_unreleased_liens36;
	unsigned1 num_unreleased_liens60;
	unsigned1 num_released_liens30;
	unsigned1 num_released_liens90;
	unsigned1 num_released_liens180;
	unsigned1 num_released_liens12;
	unsigned1 num_released_liens24;
	unsigned1 num_released_liens36;
	unsigned1 num_released_liens60;
	unsigned1 bankruptcy_count30;
	unsigned1 bankruptcy_count90;
	unsigned1 bankruptcy_count180;
	unsigned1 bankruptcy_count12;
	unsigned1 bankruptcy_count24;
	unsigned1 bankruptcy_count36;
	unsigned1 bankruptcy_count60;
	unsigned1 eviction_count;
	unsigned4 date_last_eviction;
	unsigned1 eviction_count30;
	unsigned1 eviction_count90;
	unsigned1 eviction_count180;
	unsigned1 eviction_count12;
	unsigned1 eviction_count24;
	unsigned1 eviction_count36;
	unsigned1 eviction_count60;
	unsigned1	attr_eviction_count84	;	
	unsigned1 num_nonderogs;
	unsigned1 num_nonderogs30;
	unsigned1 num_nonderogs90;
	unsigned1 num_nonderogs180;
	unsigned1 num_nonderogs12;
	unsigned1 num_nonderogs24;
	unsigned1 num_nonderogs36;
	unsigned1 num_nonderogs60;
END;

Layout_Relative := RECORD
	UNSIGNED1 relative_count;
	UNSIGNED1 relative_bankrupt_count;
	UNSIGNED1 relative_criminal_count;
	UNSIGNED1 relative_felony_count;
	UNSIGNED1 relative_criminal_total;
	UNSIGNED1 relative_felony_total;
	UNSIGNED1 criminal_relative_within25miles;
	UNSIGNED1 criminal_relative_within100miles;
	UNSIGNED1 criminal_relative_within500miles;
	UNSIGNED1 criminal_relative_withinOther;
	Layout_Relative_Property_Values;
	/* *********** Census related aggregates *************** */
	UNSIGNED1 relative_within25miles_count;
	UNSIGNED1 relative_within100miles_count;
	UNSIGNED1 relative_within500miles_count;
	UNSIGNED1 relative_withinOther_count;
	UNSIGNED1 relative_incomeUnder25_count;
	UNSIGNED1 relative_incomeUnder50_count;
	UNSIGNED1 relative_incomeUnder75_count;
	UNSIGNED1 relative_incomeUnder100_count;
	UNSIGNED1 relative_incomeOver100_count;
	UNSIGNED1 relative_homeUnder50_count;
	UNSIGNED1 relative_homeUnder100_count;
	UNSIGNED1 relative_homeUnder150_count;
	UNSIGNED1 relative_homeUnder200_count;
	UNSIGNED1 relative_homeUnder300_count;
	UNSIGNED1 relative_homeUnder500_count;
	UNSIGNED1 relative_homeOver500_count;	
	UNSIGNED1 relative_educationUnder8_count;
	UNSIGNED1 relative_educationUnder12_count;
	UNSIGNED1 relative_educationOver12_count;
	UNSIGNED1 relative_ageUnder20_count;
	UNSIGNED1 relative_ageUnder30_count;
	UNSIGNED1 relative_ageUnder40_count;
	UNSIGNED1 relative_ageUnder50_count;
	UNSIGNED1 relative_ageUnder60_count;
	UNSIGNED1 relative_ageUnder70_count;
	UNSIGNED1 relative_ageOver70_count;
	unsigned1 relative_vehicle_owned_count;	
	unsigned1 relatives_at_input_address;
END;

Layout_American_Student := RECORD
	unsigned4 DATE_FIRST_SEEN;
	unsigned4 DATE_LAST_SEEN;
	string2 AGE;
	unsigned4 DOB_FORMATTED;
	string3 CLASS;
	string1 COLLEGE_CODE;
	string1 COLLEGE_TYPE;
	string1 INCOME_LEVEL_CODE;
	string1 FILE_TYPE;
	string1 COLLEGE_TIER;  
	string3 college_major;
  boolean attended_college;
END;

Layout_Professional_License := RECORD
	boolean professional_license_flag;
	string60 license_type;
	string150 jobCategory;
	string1 plCategory;
	string2 proflic_Source;  
	unsigned2 sanctions_count := 0;
	unsigned4 sanctions_date_first_seen := 0;
	unsigned4 sanctions_date_last_seen := 0;
	string50 most_recent_sanction_type := '';
END;

Layout_Vehicles_Edina := RECORD
	UNSIGNED1 current_count;
	UNSIGNED1 historical_count;
END;

Layout_Watercraft := RECORD
	unsigned1 watercraft_count;
END;

Layout_FD_Scores := RECORD
	string3 fraudpoint_V3;
	string1 StolenIdentityIndex_V3;
	string1 SyntheticIdentityIndex_V3;
	string1 ManipulatedIdentityIndex_V3;
	string1 VulnerableVictimIndex_V3;
	string1 FriendlyFraudIndex_V3;
	string1 SuspiciousActivityIndex_V3;
	string2 reason1FP_V3;
	string2 reason2FP_V3;
	string2 reason3FP_V3;
	string2 reason4FP_V3;
	string2 reason5FP_V3;
	string2 reason6FP_V3;
	
  string3 digital_insight_score;
	string4 digital_insight_reason1;
	string4 digital_insight_reason2;
  string4 digital_insight_reason3;
  string4 digital_insight_reason4;
  string4 digital_insight_reason5;
  string4 digital_insight_reason6;
END;

Layout_Liens_Info := RECORD
	unsigned1 count;
	unsigned4 earliest_filing_date;
	unsigned4 most_recent_filing_date;
	unsigned5 total_amount;
END;

Layout_Liens := RECORD
	Layout_Liens_Info 	liens_unreleased_civil_judgment;
	Layout_Liens_Info 	liens_released_civil_judgment;
	Layout_Liens_Info 	liens_unreleased_federal_tax;
	Layout_Liens_Info 	liens_released_federal_tax;
	Layout_Liens_Info 	liens_unreleased_foreclosure;
	Layout_Liens_Info 	liens_released_foreclosure;
	Layout_Liens_Info 	liens_unreleased_landlord_tenant;
	Layout_Liens_Info 	liens_released_landlord_tenant;
	Layout_Liens_Info 	liens_unreleased_other_lj;
	Layout_Liens_Info 	liens_released_other_lj;
	Layout_Liens_Info 	liens_unreleased_other_tax;
	Layout_Liens_Info 	liens_released_other_tax;
	Layout_Liens_Info 	liens_unreleased_small_claims;
	Layout_Liens_Info 	liens_released_small_claims;
	Layout_Liens_Info liens_unreleased_suits;  
	Layout_Liens_Info liens_released_suits; 
end;

Layout_Derogs_edina := RECORD
	BOOLEAN bankrupt;
	UNSIGNED4 date_last_seen;
	STRING1 filing_type;
	unsigned1	filing_count120	;
	STRING35 disposition;	
	UNSIGNED1 filing_count;
	UNSIGNED1 bk_dismissed_recent_count;  
	UNSIGNED1 bk_dismissed_historical_count;
	unsigned1	bk_dismissed_historical_cnt120	;
	string3 bk_chapter;
	UNSIGNED1 bk_disposed_recent_count;
	UNSIGNED1 bk_disposed_historical_count;
	unsigned1	bk_disposed_historical_cnt120	;
	UNSIGNED1 liens_recent_unreleased_count;
	UNSIGNED1 liens_historical_unreleased_count;
	unsigned1	liens_unreleased_count84	;
	UNSIGNED1 liens_recent_released_count;
	UNSIGNED1 liens_historical_released_count;
	unsigned1	liens_released_count84	;
	string8 last_liens_unreleased_date;
	string8		liens_last_unrel_date84	;
	unsigned4	liens_last_rel_date84	;
	unsigned	liens_unrel_total_amount84	;
	unsigned	liens_unrel_total_amount	;
	unsigned	liens_rel_total_amount84	;
	unsigned	liens_rel_total_amount	;
	
	layout_liens Liens;
	// risk_indicators.Layouts_Derog_Info.LNJ_attrs LnJ_attributes;  // new JuLi fields for 5.2
	UNSIGNED1 criminal_count;
	UNSIGNED4 last_criminal_date;
	UNSIGNED1 felony_count;
	UNSIGNED4 last_felony_date;
	boolean foreclosure_flag;
	string8 last_foreclosure_date;
	
END;

Layout_Accident := RECORD
	unsigned1 num_accidents;
	unsigned8 dmgamtaccidents;
	unsigned8 datelastaccident;
	unsigned8 dmgamtlastaccident;
	unsigned1 numaccidents30;
	unsigned1 numaccidents90;
	unsigned1 numaccidents180;
	unsigned1 numaccidents12;
	unsigned1 numaccidents24;
	unsigned1 numaccidents36;
	unsigned1 numaccidents60;
end;

Layout_Accident_Data := RECORD
	Layout_accident 		acc;
END;

Layout_Utility := RECORD
	string50  utili_adl_type; 
	string150 utili_adl_dt_first_seen;
	unsigned1 utili_adl_count;
	string8   utili_adl_earliest_dt_first_seen;
	unsigned1 utili_adl_nap;
	string50  utili_addr1_type; 
	string150 utili_addr1_dt_first_seen;
	unsigned1 utili_addr1_nap;
	string50  utili_addr2_type; 
	string150 utili_addr2_dt_first_seen;
	unsigned1 utili_addr2_nap;
END;

Layout_Infutor := RECORD
	unsigned4 infutor_date_first_seen;
	unsigned4 infutor_date_last_seen;
	unsigned1 infutor_nap;
END;

Layout_Impulse := RECORD
	unsigned2 count;
	unsigned4 first_seen_date;
	unsigned4 last_seen_date;
	unsigned2 count30;
	unsigned2 count90;
	unsigned2 count180;
	unsigned2 count12;
	unsigned2 count24;
	unsigned2 count36;
	unsigned2 count60;
END;

header_verification_summary := RECORD
   qstring100 ver_sources;
   qstring100 ver_sources_nas;
   qstring200 ver_sources_first_seen_date;
   qstring200 ver_sources_last_seen_date;
   qstring100 ver_sources_recordcount;
   qstring100 ver_fname_sources;
   qstring200 ver_fname_sources_first_seen_date;
   qstring100 ver_fname_sources_recordcount;
   qstring100 ver_lname_sources;
   qstring200 ver_lname_sources_first_seen_date;
   qstring100 ver_lname_sources_recordcount;
   qstring100 ver_addr_sources;
   qstring200 ver_addr_sources_first_seen_date;
   qstring100 ver_addr_sources_recordcount;
   qstring100 ver_ssn_sources;
   qstring200 ver_ssn_sources_first_seen_date;
   qstring100 ver_ssn_sources_recordcount;
   qstring100 ver_dob_sources;
   qstring200 ver_dob_sources_first_seen_date;
   qstring100 ver_dob_sources_recordcount;
	 unsigned3 header_build_date;
  END;

layout_virtual_fraud := record
	integer1  hi_risk_ct;
	integer1  lo_risk_ct;
	integer1  LexID_phone_hi_risk_ct;
	integer1  LexID_phone_lo_risk_ct;
	integer1  AltLexID_Phone_hi_risk_ct;
	integer1  AltLexID_Phone_lo_risk_ct;
	integer1  LexID_addr_hi_risk_ct;
	integer1  LexID_addr_lo_risk_ct;
	integer1  AltLexID_addr_hi_risk_ct;
	integer1  AltLexID_addr_lo_risk_ct;
	integer1  LexID_ssn_hi_risk_ct;
	integer1  LexID_ssn_lo_risk_ct;
	integer1  AltLexID_ssn_hi_risk_ct;
	integer1  AltLexID_ssn_lo_risk_ct;
end;


layout_pii_stability := record
	unsigned1	link_candidate_cnt	;
	unsigned1	link_wgt_dob_npos_cnt	;
	unsigned1	link_wgt_fname_npos_cnt	;
	unsigned1	link_wgt_lname_npos_cnt	;
	unsigned1	link_wgt_phone_npos_cnt	;
	unsigned1	link_wgt_prim_name_npos_cnt	;
	unsigned1	link_wgt_prim_range_npos_cnt	;
	unsigned1	link_wgt_ssn4_npos_cnt	;
	unsigned1	link_wgt_ssn5_npos_cnt	;
	unsigned1	link_wgt_dob_nneg_cnt	;
	unsigned1	link_wgt_fname_nneg_cnt	;
	unsigned1	link_wgt_lname_nneg_cnt	;
	unsigned1	link_wgt_phone_nneg_cnt	;
	unsigned1	link_wgt_prim_name_nneg_cnt	;
	unsigned1	link_wgt_prim_range_nneg_cnt	;
	unsigned1	link_wgt_ssn4_nneg_cnt	;
	unsigned1	link_wgt_ssn5_nneg_cnt	;
	unsigned1	link_wgt_dob_nzero_cnt	;
	unsigned1	link_wgt_fname_nzero_cnt	;
	unsigned1	link_wgt_lname_nzero_cnt	;
	unsigned1	link_wgt_phone_nzero_cnt	;
	unsigned1	link_wgt_prim_name_nzero_cnt	;
	unsigned1	link_wgt_prim_range_nzero_cnt	;
	unsigned1	link_wgt_ssn4_nzero_cnt	;
	unsigned1	link_wgt_ssn5_nzero_cnt	;
	string15	link_max_weight_element	;
	string15	link_min_weight_element	;
end;
/* Exclude VOO attributes from the Edina shell layout until they are approved for release...
// slimmed down version of VOO attributes they were interested in for MS-39
Layout_VOOAttributes := RECORD
	String2 	AddressReportingHistoryIndex;
	String2 	AddressSearchHistoryIndex;
	String2 	AddressUtilityHistoryIndex;
	String2 	AddressOwnershipHistoryIndex;
	String2 	AddressPropertyTypeIndex;
	String2 	RelativesConfirmingAddressIndex;
	String2 	AddressOwnerMailingAddressIndex;
	String2 	PriorAddressMoveIndex;
	String2 	PriorResidentMoveIndex;
	String2 	OccupancyOverride;
	String2 	InferredOwnershipTypeIndex;
	String5   OtherOwnedPropertyProximity;
END;
*/
Layout_corr_risk_summary := RECORD
		//these fields added in BS 5.3 and are based off of converted source code versus the raw source code
	string50   corrssnname_sources;
	qstring200 corrssnname_firstseen;
	qstring200 corrssnname_lastseen;
	// string100	 corrssnname_source_cnt;
	string50   corrssnaddr_sources;
	qstring200 corrssnaddr_firstseen;
	qstring200 corrssnaddr_lastseen;
	// string100	 corrssnaddr_source_cnt;
	string50   corraddrname_sources;
	qstring200 corraddrname_firstseen;
	qstring200 corraddrname_lastseen;
	// string100	 corraddrname_source_cnt;
	string50   corraddrphone_sources;
	qstring200 corraddrphone_firstseen;
	qstring200 corraddrphone_lastseen;
	// string100	 corraddrphone_source_cnt;
	string50   corrphonelastname_sources;
	qstring200 corrphonelastname_firstseen;
	qstring200 corrphonelastname_lastseen;
	// string100	 corrphonelastname_source_cnt;
	string50   corrnamedob_sources;
	qstring200 corrnamedob_firstseen;
	qstring200 corrnamedob_lastseen;
	// string100	 corrnamedob_source_cnt;
	string50   corraddrdob_sources;
	qstring200 corraddrdob_firstseen;
	qstring200 corraddrdob_lastseen;
	// string100	 corraddrdob_source_cnt;
	string50   corrssndob_sources;
	qstring200 corrssndob_firstseen;
	qstring200 corrssndob_lastseen;
	// string100	 corrssndob_source_cnt;
	string50   corrssnphone_sources;
	qstring200 corrssnphone_firstseen;
	qstring200 corrssnphone_lastseen;
	// string100	 corrssnphone_source_cnt;
	string50   corrdobphone_sources;
	qstring200 corrdobphone_firstseen;
	qstring200 corrdobphone_lastseen;
	// string100	 corrdobphone_source_cnt;
END;

layout_best_pii_flags := record
	string2 input_fname_isbestmatch := '';
	string2 input_lname_isbestmatch := '';
	string2 input_ssn_isbestmatch := '';
	string1 curraddr_hriskaddrflag := '';
	string8 best_ssn_dod := '';
	string1 best_ssn_decsflag := '';
	string1 best_ssn_ssndobflag := '';
	string1 best_ssn_valid := '';
end;

layout_BIP_Header_info := record
	integer 	bus_seleids_peradl := 0;
	integer 	bus_gold_seleids_peradl := 0;
	integer 	bus_active_seleids_peradl := 0;
	integer 	bus_inactive_seleids_peradl := 0;
	integer 	bus_defunct_seleids_peradl := 0;
	integer 	bus_gold_seleid_first_seen := 0;
	integer 	bus_header_first_seen := 0;
	integer 	bus_header_last_seen := 0;
	integer 	bus_header_build_date := 0;
end;

layout_BIP_Header_info_54 := record
	integer     bus_ver_sources_total := 0;
	qstring100 	bus_ver_sources := '';
	qstring200 	bus_ver_sources_first_seen := '';
	qstring200 	bus_ver_sources_last_seen := '';
	integer    	bus_fname_ver_sources_total := 0;
	qstring100 	bus_fname_ver_sources := '';
	qstring200 	bus_fname_ver_sources_first_seen := '';
	qstring200 	bus_fname_ver_sources_last_seen := '';
	integer    	bus_lname_ver_sources_total := 0;
	qstring100 	bus_lname_ver_sources := '';
	qstring200 	bus_lname_ver_sources_first_seen := '';
	qstring200 	bus_lname_ver_sources_last_seen := '';
	integer    	bus_addr_ver_sources_total := 0;
	qstring100 	bus_addr_ver_sources := '';
	qstring200 	bus_addr_ver_sources_first_seen	 := '';
	qstring200 	bus_addr_ver_sources_last_seen		 := '';
	integer    	bus_ssn_ver_sources_total		 := 0;
	qstring100 	bus_ssn_ver_sources		 := '';
	qstring200 	bus_ssn_ver_sources_first_seen		 := '';
	qstring200 	bus_ssn_ver_sources_last_seen		 := '';
	integer   	 bus_phone_ver_sources_total		 := 0;
	qstring100 	bus_phone_ver_sources		 := '';
	qstring200 	bus_phone_ver_sources_first_seen		 := '';
	qstring200 	bus_phone_ver_sources_last_seen		 := '';
end;
	
 Export BocaShell	:= RECORD
 	// #if(includeADLFields)
	// risk_indicators.iid_constants.adl_based_modeling_flags;
	// #end
	integer bsversion;
	string1 isFCRA;	// 2.5 field
	string3 cb_allowed;	// EQ/EN/ALL
	string1 IntendedPurpose;
	string30 AccountNumber;// added
	unsigned4 seq;
	unsigned6 did;
	BOOLEAN trueDID;
	string15 adlCategory;
	BOOLEAN DIDdeceased := false;
	UNSIGNED4 DIDdeceasedDate := 0;
	integer swappedNames;
	edina_Layout_Input 																			Shell_Input;
	Layout_InstantID_Results 																iid;
	decimal4_1 source_profile;  					
	integer source_profile_index; 				
	header_verification_summary 														header_summary;
	Layout_corr_risk_summary         												corr_risk_summary; 
  layout_best_pii_flags						                        best_pii_flags;
	Layout_Available_Sources 																Available_Sources;
	integer	bus_addr_only_curr;
	integer	bus_addr_only;
	layout_BIP_Header_info 					                        BIP_Header;
  layout_BIP_Header_info_54                 					    BIP_Header54;
	integer bus_SOS_filings_peradl := 0;
	integer bus_active_SOS_filings_peradl := 0;
  integer3 bus_sos_filings_not_instate := 0;
  integer3 bus_ucc_count := 0;
  integer3 bus_ucc_active_count := 0;
	Layout_Input_Validation 																Input_Validation;
	Layout_Name_Verification 																Name_Verification;
	Layout_Utility																					Utility;
	Layout_Address_Verification 														Address_Verification;
	Layout_Other_Address_Fields															Other_Address_Info;
	Layout_Phone_Verification 															Phone_Verification;
	Layout_SSN_Information 																	SSN_Verification;
	Layout_ADL_Information																	Velocity_Counters;
	layout_inquiries_edina              										acc_logs;  	
	risk_indicators.layouts.layout_employment 							employment;  
	Layout_Infutor																					Infutor;
	Layout_Impulse																					Impulse;
	risk_indicators.layouts.layout_email_50									email_summary;  
	Layout_Attributes																				Attributes; 
	layout_pii_stability 																		PII_Stability; 
	layout_virtual_fraud																		Virtual_Fraud;	
	risk_indicators.layouts.layout_test_fraud  							Test_Fraud;
	risk_indicators.layouts.layout_contributory_fraud  			Contributory_Fraud;
  risk_indicators.layouts.layout_threatmetrix_shell_results ThreatMetrix;
	risk_indicators.layouts.layout_fd_attributesv2 -CorrelationRiskLevel -CorrelationSSNNameCount -CorrelationSSNAddrCount -CorrelationAddrNameCount -CorrelationAddrPhoneCount -CorrelationPhoneLastNameCount	fdAttributesv2;	
	Risk_Indicators.Layouts.layout_fp201_attributes 				fpAttributes201;
	Layout_Derogs_edina 																		BJL;
	risk_indicators.layouts.layout_hhid_summary  						hhid_summary;
	Layout_Relative																					Relatives;
	Layout_Vehicles_Edina																		Vehicles;
	Layout_Watercraft																				Watercraft;
	Layout_Accident_Data																		Accident_Data;
	Layout_American_Student																	Student;
	Layout_Professional_License															Professional_License;
	// Layout_RV_Scores																				RV_Scores;
	// risk_indicators.layouts.layout_riskview_alerts 					riskview_alerts;
	Layout_FD_Scores																				FD_Scores;
	Risk_Indicators.Layouts.layout_Equifax_FraudFlags 			Eqfx_FraudFlags;

	
	string1 wealth_indicator;
	string8 input_dob_age;
	string1 dobmatchlevel;
	integer2 inferred_age;	
	unsigned4 reported_dob;
	string1 mobility_indicator;		 // original addr_stability model
	string1 addr_stability := '';  // new model for shell 4.0, addr_stability_v2
	unsigned5 estimated_income;
	// Layout_credit_derived_perf       												credit_derived_perf; 
	string20 input_dl_number;
	string2 input_dl_state;
	string20 best_fname;
	string20 best_lname;
	string9 best_ssn;
	string10 add_curr_prim_range;
	string2 add_curr_predir;
	string28 add_curr_prim_name;
	string4 add_curr_addr_suffix;
	string2 add_curr_postdir;
	string10 add_curr_unit_desig;
	string8 add_curr_sec_range;
	string25 add_curr_city_name;
	string5 add_curr_st;
	string5 add_curr_zip5;
	string10 add_curr_lat;
	string11 add_curr_long;
	string20	historyDateTimeStamp := '';  
	STRING200 errorcode;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;

 END;
 //End BocaShell Layout
END;