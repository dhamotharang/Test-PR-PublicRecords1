﻿Import Models;
Import Profilebooster;
Import iesp;

EXPORT Layouts_Healthcare_RT_Service := module 
	EXPORT Layout_SocioEconomic_Data_In := RECORD unsigned4 seq;
		STRING30 AcctNo;
		STRING15 SSN_in;
		STRING120 unParsedFullName := '';
		STRING30 Name_First;
		STRING30 Name_Middle;
		STRING30 Name_Last;
		STRING5 Name_Suffix;
		STRING8 DOB_in;
		STRING65 street_addr := '';
		STRING25 p_City_name;
		STRING5 St_in;
		STRING10 ZIP_in;
		STRING20 DL_Number;
		STRING2 DL_State;
		STRING20 Home_Phone_in;
		STRING20 Work_Phone_in;
		string10 MemberGENDer_in := '';
		unsigned6 DID := 0;
		STRING8 ADMIT_DATE_in;
		STRING15 ADMIT_DIAGNOSIS_CODE; 
		STRING6 FINANCIAL_CLASS;
		STRING5 PATIENT_TYPE;
		unsigned3 HistorydateYYYYMM := 999999;
	END;
	EXPORT Layout_SocioEconomic_Data_Cln := RECORD 
		Layout_SocioEconomic_Data_In;
		REAL8 Age   := 0.000;
		STRING9 SSN_Cln;
		STRING8 DOB_Cln;
		STRING2 ST_Cln;
		STRING5 Z5_Cln;
		STRING10 Home_Phone_Cln;
		STRING10 Work_Phone_Cln;
		STRING8 ADMIT_DATE_Cln;
		string1 MemberGENDer_Cln;
	END;

	export ScoresDSFromCore := RECORD
	unsigned4 seq;
	iesp.healthcare_socio_indicators.t_SocioScore;
	END;

	export IndicatorsDSwithSeq := RECORD
	unsigned4 seq;
	iesp.healthcare_socio_indicators.t_SocioIndicators
	END;

	export common_runtime_config := record
			unsigned1 cfg_Version := 0;

			string14 ReferenceNumber :='';
			string16 TransactionId :='';
			string10 GlobalCompanyId :='';

			string50 ProductKey := '';

			//Subscription Settings
			Boolean SubscribedToReadmissionScore := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToHealthAttributesV3 := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToMedicationAdherenceScore := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SubscribedToMotivationScore := Healthcare_Constants_RT_Service.CFG_False;
			
			//Attribute group suppression settings
			Boolean SuppressAccident := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressAddressStability := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressAsset := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressCurrentAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDemographics := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryCrimeRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressDerogatoryFinancialRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressEducation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityActivity := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityAssociation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityFraudRisk := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityProductSearchEvent := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityValidation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIdentityVariation := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressIncome := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInputAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInputSSN := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressInterests := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressMostRecentAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressNonDerogatoryRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressNonDerogatoryOccupationalRecord := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressPhone := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressPreviousAddress := Healthcare_Constants_RT_Service.CFG_False;
			Boolean SuppressSubprimeRequests := Healthcare_Constants_RT_Service.CFG_False;

			//The thresholds for Socio Readmission Category Calculation are set to default values here
			DECIMAL7_4 ReadmissionScore_Category_5_High	:= 100 ;
			DECIMAL7_4 ReadmissionScore_Category_5_Low	:= 34.8015 ;
			DECIMAL7_4 ReadmissionScore_Category_4_High	:= 34.8014 ;
			DECIMAL7_4 ReadmissionScore_Category_4_Low	:= 16.3241 ;
			DECIMAL7_4 ReadmissionScore_Category_3_High	:= 16.3240 ;
			DECIMAL7_4 ReadmissionScore_Category_3_Low	:= 12.2211 ;
			DECIMAL7_4 ReadmissionScore_Category_2_High	:= 12.2210 ;
			DECIMAL7_4 ReadmissionScore_Category_2_Low	:= 8.5245 ;
			DECIMAL7_4 ReadmissionScore_Category_1_High	:= 8.5244 ;
			DECIMAL7_4 ReadmissionScore_Category_1_Low	:= 0 ;

			DECIMAL7_4 MedicationAdherenceScore_Category_5_High	:= 37.5323 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_5_Low	:= 0 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_4_High	:= 64.3456 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_4_Low	:= 37.5324 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_3_High	:= 74.2270 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_3_Low	:= 64.3457 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_2_High	:= 79.9234 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_2_Low	:= 74.2271 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_1_High	:= 100 ;
			DECIMAL7_4 MedicationAdherenceScore_Category_1_Low	:= 79.9235 ;

			DECIMAL7_4 MotivationScore_Category_5_High	:= 37.5323 ;
			DECIMAL7_4 MotivationScore_Category_5_Low	:= 0 ;
			DECIMAL7_4 MotivationScore_Category_4_High	:= 64.3456 ;
			DECIMAL7_4 MotivationScore_Category_4_Low	:= 37.5324 ;
			DECIMAL7_4 MotivationScore_Category_3_High	:= 74.2270 ;
			DECIMAL7_4 MotivationScore_Category_3_Low	:= 64.3457 ;
			DECIMAL7_4 MotivationScore_Category_2_High	:= 79.9234 ;
			DECIMAL7_4 MotivationScore_Category_2_Low	:= 74.2271 ;
			DECIMAL7_4 MotivationScore_Category_1_High	:= 100 ;
			DECIMAL7_4 MotivationScore_Category_1_Low	:= 79.9235 ;
	end;

	EXPORT transactionLog := RECORD			
		STRING20 transaction_id ; 				// ID of the transaction. This ID will be associated with all logging entries.
		INTEGER  product_id ; 					// MBS gbl_product_id
		INTEGER  sub_product_id ; 				// MBS sub product id		
		STRING60 date_added ; 					// Date the record was added.
		STRING60 login_id ; 					// LOG-IN id of the USER executing the search.
		STRING60 billing_code ; 				// Billing CODE of the transaciton. FOR migrated products it would be special billing id
		STRING30 function_name ; 				// TYPE of TRANSACTION/search that IS being executed. Equivalent FOR the current insurance products AS "report_service_type"
		INTEGER  report_code ; 					// Denotes the reporting CODE TO be used FOR billing
		INTEGER  gc_id ; 						// Gc id of the company running the search
		INTEGER  billing_id ; 					// Billing id of the company running the search
		STRING32 customer_reference_code; 		// Pass through VALUE BY the customer TO ID the transaction. IN the current insurance world referred AS "full quote back" AND IN accurint "reference number"
		STRING120 end_user_name ; 				// EndUser Company name
		STRING200 end_user_address_1 ;			// EndUser address suppled in request
		STRING25 end_user_city ;
		STRING2 end_user_state ;
		STRING5 end_user_zip ;
		STRING10 end_user_phone ;
		STRING32 i_unique_id ; 					// UNIQUE ID provided aka LexID
		STRING15 i_tax_id ; 					// Input TaxId
		STRING15 i_fein ; 						// Input FEIN
		STRING10 i_npi ; 						// Input NPI
		STRING15 i_clia ; 						// Input CLIA
		STRING12 i_upin ; 						// Input UPIN
		STRING20 i_provider_id ; 				// Input LN ProviderId
		STRING20 i_facility_id ; 				// Input LN FacilityId
		STRING5  i_person_name_prefix ; 		// Prefix NAME provided
		STRING20 i_person_last_name ; 			// LAST NAME, input IN search
		STRING20 i_person_first_name ; 			// FIRST NAME input IN search
		STRING20 i_person_middle_name ; 		// Middle NAME input IN search
		STRING5  i_person_name_suffix ; 		// Suffix NAME provided
		STRING8  i_person_dob ; 				// DOB of the SUBJECT
		STRING9  i_person_ssn ; 				// SSN of the person being inquiried
		STRING10 i_person_phone ; 				// Phone of the person being inquiried
		STRING90 i_person_addr ; 				// Line1 address being passed
		STRING50 i_person_city ; 				// City of the address passed
		STRING2  i_person_state ; 				// State of the address being passed
		STRING10 i_person_zip ; 				// ZIP of the address passed
		STRING3  i_person_country ; 			// 3 letter ISO CODE of the country of the address passed
		STRING80 i_bus_name ; 					// Business/facility/organization Name
		STRING10 i_bus_phone ; 					// Phone of the business being inquiried
		STRING90 i_bus_addr ; 					// Line1 business address being passed
		STRING50 i_bus_city ; 					// City of the business address passed
		STRING2  i_bus_state ; 					// State of the business address being passed
		STRING10 i_bus_zip ; 					// ZIP of the business address passed
		STRING3  i_bus_country ; 				// 3 letter ISO CODE of the country of the business address passed
		STRING256 user_agent; 					// User Agent string if from Web App if Web transaction
		STRING10  error_code; 					// Other transaction error
		STRING100 error_detail; 				// Verbose description of error_code
		STRING10 dataprep_error_code ; 			// Processing error from Roxie
		STRING1  match_flag ; 					// From Roxie
		STRING1  subject_to_sla ; 				// From Roxie - if transaction is subject to SLA
		DECIMAL18_9 price; 						// Price of the transaction. Having the price in the accounting_log easily helps reporting tieing a type of transaction with the price
		INTEGER  currency; 						// Indicates the type of currency. 0=unknown, 1= U.S Dollar,etc
		INTEGER  pricing_error_code; 			// To be set by the pricing application. Indicates default pricing status after pricer process the record
		INTEGER  free; 							// Tells whether the record is for free and the reason, i.e free = 1 Free Trial, free 2= Exempt Company, free = 3 Next Page search, free = 4/6 , marked as Freebee
		INTEGER  record_count ; 				// Results returned from the search for one type
		STRING10 report_options ; 				// Register the options for each possible search if applies. Can be similar to what we use in Accurint accounting_log but even expand the use if necessary, and as opposed to use boolean 1/0 for each position, can have different values
		INTEGER  transaction_code ; 			// This would be used for billing and potentially for rollup
		INTEGER  order_status_code ; 			// Order status code reflects whether its subject to billing, not or if there has been any error
		INTEGER  result_code ; 					// Denotes the specifics/nature of the result, in case it could be fulfilled
		INTEGER  login_history_id ; 			// Optional. Possibly NULL in this case for non WEB transactions
		STRING20 ip_address ; 					// IP where the request was made for the search
		STRING8  response_time ; 				// Response time taken to fullfil the request, from request to result
		STRING40 esp_method ; 					// ESP method tied to this transaction id
	END; // RECORD
	
	EXPORT transactionLogWrap := RECORD
		transactionLog Rec {xpath('Rec')};
	END;
	
	EXPORT transactionLogWrapWrap := RECORD
		transactionLogWrap Records {xpath('Records')};
	END;
	
END; // MODULE
