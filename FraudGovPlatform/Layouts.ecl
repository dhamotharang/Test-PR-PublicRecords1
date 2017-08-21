import Address , bipv2, Inquiry_Acclogs, corrections,FraudShared;

export Layouts := MODULE

	export Sprayed := module
		export IdentityData := RECORD
			string		Customer_Name;  
			string20	Customer_Account_Number;
			string2		Customer_State;
			string3		Customer_County;
			string		Customer_Agency;														
			string		Customer_Agency_Vertical_Type;
			string1		Customer_Program;
			string		Customer_Job_ID;
			string		Batch_Record_ID;
			string		Transaction_ID_Number;
			string		Reason_for_Transaction_Activity;	
			string10	Date_of_Transaction;												
			unsigned6	LexID;
			string60	Full_Name;
			string5		Title;
			string25	First_name;
			string25	Middle_Name;
			string30	Last_Name;
			string5		Suffix;
			string9		SSN;
			string4		SSN4;
			string10	Address_Type;
			string70	Physical_Address_1;
			string70	Physical_Address_2;
			string30	City;
			string2		State;
			string9		Zip;
			string70	Mailing_Address_1;
			string70	Mailing_Address_2;
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
			string25	Drivers_License_Number;
			string20	Bank_Routing_Number_1;
			string20	Bank_Account_Number_1;
			string20	Bank_Routing_Number_2;
			string20	Bank_Account_Number_2;
			string1		Ethnicity;
			string1		Race;
			string20	Case_ID;
			string20	Client_ID;
			string1		Head_of_Household_indicator;
			string20	Relationship_Indicator;
			string25	IP_Address;
			string50	Device_ID;
			string20	Unique_number;
			string10	MAC_Address;
			string20	Serial_Number;
			string25	Device_Type;
			string25	Device_identification_Provider; 
			string10	geo_lat;
			string11	geo_long; 
		END;
		
		export KnownFraud := RECORD
			string		customer_name;
			string20	customer_account_number;
			string2		customer_state;
			string3		customer_county;
			string		customer_agency;
			string		customer_agency_vertical_type;
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
			unsigned8	case_id;
			string20	client_id;
			string1		head_of_household_indicator;
			string20	relationship_indicator;
			unsigned6	lexid;
			string50	title;
			string100	first_name;
			string60	middle_name;
			string100	last_name;
			string10	orig_suffix;
			string100	full_name;
			string60	name_risk_code;
			string10	ssn;
			string60	ssn_risk_code;
			string10	dob;
			string60	dob_risk_code;
			string25	Drivers_License_Number;
			string2		Drivers_License_State;
			string60	drivers_license_risk_code;
			string100	physical_address_1;
			string50	physical_address_2;
			string100	city;
			string10	state;
			string10	zip;
			string60	physical_address_risk_code;
			string70	mailing_address_1;
			string70	mailing_address_2;
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
			string15	host;
			string25	alias;
			string25	location;
			string25	ip_address;
			string30	ip_address_fraud_code;
			string8		ip_address_date;
			string10	version;
			string75	isp;
			string12	device_id;
			string8		device_date;
			string20	unique_number;
			string10	mac_address;
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
			string10  amount_paid;
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
		END;

		export validate_record := record
			string 		Customer_Name								 		:= '';
			string20 	Customer_Account_Number			 		:= '';
			string2 	Customer_State 									:= '';
			string3		customer_county 								:= '';
			string		customer_agency 								:= '';
			string 		Customer_Agency_Vertical_Type 	:= '';
			string1 	Customer_Program 								:= '';
			string		Customer_Job_ID 								:= '';
			string		Batch_Record_ID 								:= '';
			string		Reason_for_Transaction_Activity	:= '';
			string10	Date_of_Transaction							:= '';
			string20	customer_event_id 							:= '';
			string8		reported_date 									:= '';
			string10	reported_time 									:= '';
			string30	reported_by 										:= '';
			string20	lexid 													:= '';
			string25 	First_name 											:= '';
			string30 	Last_Name 											:= '';
			string9 	SSN 														:= '';
			string10 	phone_number 										:= '';
			string10 	Cell_Phone 											:= '';
			string2 	State 													:= '';
			string9 	Zip 														:= '';
			string2 	Mailing_State 									:= '';
			string9 	Mailing_Zip 										:= '';
			string10	Address_Type 										:= '';
			string8 	dob  														:= '';
			string25	Drivers_License_Number					:= '';
			string2		Drivers_License_State						:= '';			
		end;

	END;

	export vLoad := {string75 fn { virtual(logicalfilename)},Sprayed.IdentityData};

	export Provenance := RECORD
				string75 FileName:=''
				,unsigned4 ProcessDate:=0
				,unsigned4 FileDate:=0
				,string6   FileTime:=''
				,unsigned6 PrepRecNo:=0
				,unsigned6 PrepRecSeq:=0	
	END;
	
	export Input := module
		export IdentityData := RECORD
				Sprayed.IdentityData;
				Provenance;
		END;
		export KnownFraud := RECORD
				Sprayed.KnownFraud;
				Provenance
		END;
	end;


EXPORT Base := MODULE
	export IdentityData	:= 
		record 
		Sprayed.IdentityData ;
		string100		address_1 ;   
		string50		address_2 ; 
		Address.Layout_Clean_Name	cleaned_name;         
		string			current ; 
		unsigned4		dt_first_seen;
		unsigned4		dt_last_seen;
		unsigned4		dt_vendor_first_reported;
		unsigned4		dt_vendor_last_reported;
		unsigned2		name_ind:=0;
		unsigned8		NID:=0;
		unsigned4		process_date ; 
		string4			Source; 
		unsigned8		source_rec_id;
		unsigned8		Unique_Id ; 
	end; 
	
	export KnownFraud	:= 
		record 
		Sprayed.KnownFraud ;
		string100		address_1 ;   
		string50		address_2 ; 
		Address.Layout_Clean_Name	cleaned_name;         
		string			current ; 
		unsigned4		dt_first_seen;
		unsigned4		dt_last_seen;
		unsigned4		dt_vendor_first_reported;
		unsigned4		dt_vendor_last_reported;
		unsigned2		name_ind:=0;
		unsigned8		NID:=0;
		unsigned4		process_date ; 
		string4			Source; 
		unsigned8		source_rec_id;
		unsigned8		Unique_Id ; 
	end; 	
END;

END;