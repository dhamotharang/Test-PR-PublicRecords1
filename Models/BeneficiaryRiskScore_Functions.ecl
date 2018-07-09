
IMPORT Address, AutoStandardI, BatchShare, Doxie, Gateway, Models, Risk_Indicators, Riskwise, ut, VehicleV2, 
VehicleV2_Services, std;

EXPORT BeneficiaryRiskScore_Functions := MODULE
	
	SHARED UCase := StringLib.StringToUpperCase;

	// --------------------[ List of functions in this module ]--------------------
	//
	//   o  Functions for query input:
	//      -  get_search_subject_params()
	//      -  get_restriction_params()
	//      -  get_InputSearchOptions_BocaShell()
	//      -  get_InputSearchOptions_PostBeneficiaryFraud()
	//      -  get_gateways()
	//   o  Functions for transforming query input (search subject) for processing:
	//      -  convert_search_subject_to_datarow()
	//      -  create_input_for_InstantID_Function()
	//      -  create_input_for_PostBeneficiaryFraud()
	//   o  Functions for query processing and output:
	//      -  fn_getMVRInfo()
	//      -  transform_postbeneficiaryfraud_results()
	
	// -----------------------------------------------------------------------------------------------
	//
	//                                  [ Functions for query input ]                                 
	//
	// -----------------------------------------------------------------------------------------------
	
	// The following function is invoked by the Search service and assigns Stored searchBy values 
	// to a Module of type ISearchSubject. This will later be transformed to a one-record dataset.
	EXPORT get_search_subject_params() := 
		FUNCTION
			modSearchSubject := MODULE(Models.BeneficiaryRiskScore_Interfaces.ISearchSubject)
				// Shared attributes for assigning default values below per product specifications.
				SHARED STRING8 todays_date_full       := StringLib.GetDateYYYYMMDD();
				SHARED UNSIGNED3 history_dt           :=  0 : STORED('HistoryDateYYYYMM');
				SHARED STRING20  mvr_vehicle_val      := '' : STORED('MVRVehicleValue');
				SHARED STRING5   number_mvrs          := '' : STORED('NumberMVRsReported');
				SHARED STRING5   number_properties    := '' : STORED('NumberPropertiesReported');
				SHARED STRING5   number_adults        := '' : STORED('NumberOfAdultsInHousehold');
				SHARED STRING8   dt_appl_for_benefits := '' : STORED('DateAppliedForBenefits');

				// Record-level or SearchBy fields
				EXPORT STRING30  acctno       := '' : STORED('UniqueClientID');
				EXPORT UNSIGNED4 seq          :=  1;
				EXPORT UNSIGNED3 history_date := 
					MAP( 
						dt_appl_for_benefits != '' => (UNSIGNED3)(dt_appl_for_benefits[1..6]),
						history_dt           !=  0 => history_dt, 
						Risk_Indicators.iid_constants.default_history_date // default
					);
				EXPORT STRING20	 historyDateTimeStamp := '' : STORED('historyDateTimeStamp');  // new for shell 5.0
				EXPORT STRING20  did_value            := '' : STORED('LexID');
				EXPORT STRING100 full_name_value      := '' : STORED('FullName');
				EXPORT STRING30  first_name_value     := '' : STORED('FirstName');
				EXPORT STRING30  middle_name_value    := '' : STORED('MiddleName');
				EXPORT STRING30  last_name_value      := '' : STORED('LastName');
				EXPORT STRING5   name_suffix_value    := '' : STORED('NameSuffix');
				EXPORT STRING120 addr1_value          := '' : STORED('StreetAddress1');
				EXPORT STRING100 addr2_value          := '' : STORED('StreetAddress2');
				EXPORT STRING25  city_value           := '' : STORED('City');
				EXPORT STRING2   state_value          := '' : STORED('State');
				EXPORT STRING5   zip_value            := '' : STORED('Zip5');
				EXPORT STRING25  country_value        := '' : STORED('Country');
				EXPORT STRING9   ssn_value            := '' : STORED('SocialSecurityNumber');
				EXPORT STRING8   dob_value            := '' : STORED('DateOfBirth');
				EXPORT UNSIGNED1 age_value            :=  0 : STORED('Age');
				EXPORT STRING20  dl_number_value      := '' : STORED('DLNumber');
				EXPORT STRING2   dl_state_value       := '' : STORED('DLState');
				EXPORT STRING100 email_value          := '' : STORED('Email');
				EXPORT STRING45  ip_value             := '' : STORED('IPAddress');
				EXPORT STRING10  phone_value          := '' : STORED('HomePhone');
				EXPORT STRING10  wphone_value         := '' : STORED('WorkPhone');
				EXPORT STRING100 employer_name_value  := '' : STORED('EmployerName');
				EXPORT STRING30  prev_lname_value     := '' : STORED('FormerName');
				EXPORT STRING30  case_number          := '' : STORED('CaseNumber');
				EXPORT STRING20  benefit_claim_amount := '' : STORED('BenefitClaimAmount');
				EXPORT STRING2   benefits_issued_state   := '' : STORED('BenefitsIssuedState');
				EXPORT STRING8   date_applied_for_benefits  := 
					MAP( 
						dt_appl_for_benefits != ''    => dt_appl_for_benefits,
						history_dt NOT IN [0, 999999] => (STRING8)(history_dt * 100 + 1), 
						todays_date_full // default
					);
				
				// The following default values are assigned per business rules stated in the product spec.
				EXPORT STRING20  mvr_vehicle_value          := IF( mvr_vehicle_val = ''  , '10000', mvr_vehicle_val );
				EXPORT STRING5   number_mvrs_reported       := IF( number_mvrs = ''      , '0', number_mvrs );
				EXPORT STRING5   number_properties_reported := IF( number_properties = '', '0', number_properties );
				EXPORT STRING5   number_adults_in_household := IF( number_adults = ''    , '0', number_adults );
				EXPORT STRING100 filler_field_1             := '' : STORED('FillerField1');			
			END;
			
			RETURN modSearchSubject;
		END;
		
	// The following function assigns values to attributes used to allow/restrict a customer's 
	// access to sensitive data, e.g. DPPAPurpose, GLBPurpose, DataRestrictionMask, etc.
	EXPORT get_restriction_params() := 
		FUNCTION
			
			base_params := BatchShare.IParam.getBatchParams();
			
			// Project the base params to read shared parameters from stored(). If necessary, you may 
			// redefine default values for common parameters and/or define default values for domain-
			// specific parameters.
			modInputRestrictions := 
				MODULE(PROJECT(base_params, Models.BeneficiaryRiskScore_Interfaces.IRestrictionParams, opt))
					EXPORT BOOLEAN dppa_ok     := DPPAPurpose BETWEEN 1 AND 7;
					EXPORT BOOLEAN ViewDebugs  := FALSE : STORED('ViewDebugs');
				END;
			
			RETURN modInputRestrictions;
		END;

	// The following function is invoked by both the Search and Batch services and assigns Stored 
	// "Options" values to a Module of type IInputOptions_BocaShell. This will be used to provide 
	// parameters to the functions that together compose the Boca Shell.
	EXPORT get_InputSearchOptions_BocaShell() := 
		FUNCTION
			modInputSearch := MODULE(Models.BeneficiaryRiskScore_Interfaces.IInputOptions_BocaShell)
				
				// For assigning default values below per product specifications.
				SHARED UNSIGNED3 LastSeenThresholdIn  :=   0   : STORED('LastSeenThreshold');
				SHARED BOOLEAN   Lead_Integrity_Mode  := FALSE : STORED('LeadIntegrityMode');
				SHARED UNSIGNED1 bsversionIn          := 50    : STORED('BSVersion');	// version 1 is the original, 2 would add BS 2 fields and 3 will add BS 3 fields
				SHARED BOOLEAN   FraudPointMode       := bsversionIn >= 41; // Hardcode this to true so that fraud attributes are run correctly
				SHARED UNSIGNED8 InclDoNotMail        := risk_indicators.iid_constants.BSOptions.IncludeDoNotMail;
				SHARED UNSIGNED8 InclFraudVelocity    := risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity;
				SHARED UNSIGNED3 LastSeenThreshold_default := 
						IF( bsversionIn >= 50, risk_indicators.iid_constants.max_unsigned3, risk_indicators.iid_constants.oneyear );
	
				// Public/Exportable members:
				
				// Options: filter by date_last_seen
				EXPORT UNSIGNED3 LastSeenThreshold     := IF(LastSeenThresholdIn = 0, lastSeenThreshold_default, LastSeenThresholdIn);
			
				// Options: other bocashell things
				EXPORT BOOLEAN   Exclude_Relatives     := FALSE : STORED('ExcludeRelatives');
				EXPORT BOOLEAN   Include_Score         := FALSE : STORED('IncludeScore');
				EXPORT BOOLEAN   ADL_Based_Shell       := FALSE : STORED('ADLBasedShell');
				EXPORT BOOLEAN   Remove_Fares          := FALSE : STORED('RemoveFares');
				EXPORT BOOLEAN   IncludeDLverification := FraudPointMode;	
				
				// A value of 2 indicates to append best SSN to input; 1 indicates to get 
				// the best ssn but not append to input
				EXPORT UNSIGNED1 append_best := IF(Lead_Integrity_Mode, 2, 1); 
				
				// Query behavior
				EXPORT UNSIGNED1 bsversion  := bsversionIn;
				EXPORT UNSIGNED8 bsOptions  := IF( FraudPointMode, InclDoNotMail + InclFraudVelocity, 0 );
				EXPORT STRING    RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
				
				// NOTES:
				// 1. The Gateways param is handled by the call to Gateway.Configuration.Get().
				// 2. Permissions and Restrictions are handled by BatchParams, defined above.
			END;
			
			RETURN modInputSearch; 
		END;

	// The following function is invoked by both the Search and Batch services and assigns Stored 
	// "Options" values to a Module of type IInputOptions_PostBeneficiaryFraud. This will be used 
	// to provide parameters to another function that fulfills PostBeneficiaryFraud.
	// NOTE: Set the Motor_Vehicle flags to FALSE, since we'll call a different MVR function that
	// is tailored specically to meet the data requirements for BeneficiaryRiskScore. The flags
	// Include_In_House_Motor_Vehicle2 and Include_Real_Time_Motor_Vehicle2 will work in conjunction
	// with the different MVR function.
	EXPORT get_InputSearchOptions_PostBeneficiaryFraud() := 
		FUNCTION
			modInputOptions_PostBeneficiaryFraud := 
				MODULE(Models.BeneficiaryRiskScore_Interfaces.IInputOptions_PostBeneficiaryFraud)
					// For assigning default values below per product specifications.
					SHARED STRING7   select_time_frame    :=  ''   : STORED('SelectTimeFrame');
					SHARED STRING7   time_frame           := IF( select_time_frame = '', 'ALL', select_time_frame );
					SHARED STRING7   Uppercase_Time_Frame := TRIM(UCase(time_frame)); 
					SHARED UNSIGNED  Unsigned_Time_Frame  := (UNSIGNED)(time_frame); 

					SHARED BOOLEAN Incl_All                         := FALSE : STORED('IncludeAllAttributeCategories');
					SHARED BOOLEAN Incl_Relative_And_Associates     := FALSE : STORED('IncludeRelativeAndAssociates');
					SHARED BOOLEAN Incl_Drivers_License             := FALSE : STORED('IncludeDriversLicense');
					SHARED BOOLEAN Incl_Property                    := FALSE : STORED('IncludeProperty');
					SHARED BOOLEAN Incl_In_House_Motor_Vehicle      := FALSE;
					SHARED BOOLEAN Incl_Real_Time_Motor_Vehicle     := FALSE;
					SHARED BOOLEAN Incl_Watercraft_And_Aircraft     := FALSE : STORED('IncludeWatercraftAndAircraft');
					SHARED BOOLEAN Incl_Professional_License        := FALSE : STORED('IncludeProfessionalLicense');
					SHARED BOOLEAN Incl_Business_Affiliations       := FALSE : STORED('IncludeBusinessAffiliations');
					SHARED BOOLEAN Incl_People_At_Work              := FALSE : STORED('IncludePeopleAtWork');
					SHARED BOOLEAN Incl_Bankruptcy_Liens_Judgements := FALSE : STORED('IncludeBankruptcyLiensJudgements');
					SHARED BOOLEAN Incl_Criminal_SOFR               := FALSE : STORED('IncludeCriminalSOFR');
					SHARED BOOLEAN Incl_UCC_Filings                 := FALSE : STORED('IncludeUCCFilings');
					SHARED BOOLEAN Incl_In_House_Motor_Vehicle2     := FALSE : STORED('IncludeInHouseMotorVehicle');     
					SHARED BOOLEAN Incl_Real_Time_Motor_Vehicle2    := FALSE : STORED('IncludeRealTimeMotorVehicle'); 
	
					// Public/Exportable members:
					EXPORT UNSIGNED1 RelativeDepthLevel := 1 : STORED('RelativeDepthLevel');		
					
					// All the attributes dealing with what to include and the 'Select Time Frame' option (Date_Cutoff)
					EXPORT BOOLEAN  Current_Only := Uppercase_Time_Frame = 'CURRENT'; // used in get_PostBeneficiaryFraud_Attributes
					EXPORT UNSIGNED2 Date_Cutoff :=                                   // used in get_PostBeneficiaryFraud_Attributes
											MAP(
												Uppercase_Time_Frame IN ['ALL', 'CURRENT'] => 60000,
												Unsigned_Time_Frame BETWEEN 1 AND 255 => Unsigned_Time_Frame,
												60000);
												
					EXPORT BOOLEAN All_False := 
					  NOT Incl_Relative_And_Associates AND NOT Incl_Drivers_License AND NOT Incl_Property AND 
						NOT Incl_In_House_Motor_Vehicle AND NOT Incl_Real_Time_Motor_Vehicle AND 
						NOT Incl_Watercraft_And_Aircraft AND NOT Incl_Professional_License AND 
						NOT Incl_Business_Affiliations AND NOT Incl_People_At_Work AND 
						NOT Incl_Bankruptcy_Liens_Judgements AND NOT Incl_Criminal_SOFR AND NOT Incl_UCC_Filings;											

					EXPORT BOOLEAN Include_All := Incl_All OR All_False;

					// Options: Include (or not) PostBeneficiaryFraud attributes associated with the subject.
					// NOTE: Set the Motor_Vehicle flags to FALSE, since we'll use fn_getMVRInfo (below) which
					// is tailored specifically to meet the data requirements for BeneficiaryRiskScore. The flags
					// Include_In_House_Motor_Vehicle2 and Include_Real_Time_Motor_Vehicle2 will work in 
					// conjunction with fn_getMVRInfo.
					EXPORT BOOLEAN Include_Relative_And_Associates     := Include_All OR Incl_Relative_And_Associates;
					EXPORT BOOLEAN Include_Drivers_License             := Include_All OR Incl_Drivers_License;
					EXPORT BOOLEAN Include_Property                    := Include_All OR Incl_Property;
					EXPORT BOOLEAN Include_In_House_Motor_Vehicle      := FALSE; // Never call Models.PostBeneficiaryFraud_Functions.fn_get_mvr_info( )
					EXPORT BOOLEAN Include_Real_Time_Motor_Vehicle     := FALSE; // Never call Models.PostBeneficiaryFraud_Functions.fn_get_mvr_info( )
					EXPORT BOOLEAN Include_Watercraft_And_Aircraft     := Include_All OR Incl_Watercraft_And_Aircraft;
					EXPORT BOOLEAN Include_Professional_License        := Include_All OR Incl_Professional_License;
					EXPORT BOOLEAN Include_Business_Affiliations       := Include_All OR Incl_Business_Affiliations;
					EXPORT BOOLEAN Include_People_At_Work              := Include_All OR Incl_People_At_Work;
					EXPORT BOOLEAN Include_Bankruptcy_Liens_Judgements := Include_All OR Incl_Bankruptcy_Liens_Judgements;
					EXPORT BOOLEAN Include_Criminal_SOFR               := Include_All OR Incl_Criminal_SOFR;
					EXPORT BOOLEAN Include_UCC_Filings                 := Include_All OR Incl_UCC_Filings;
					EXPORT BOOLEAN Include_In_House_Motor_Vehicle2     := Include_All OR Incl_In_House_Motor_Vehicle2;
					EXPORT BOOLEAN Include_Real_Time_Motor_Vehicle2    := Incl_Real_Time_Motor_Vehicle2; // We only do real-time MVR if the customer has checked that box and ONLY then.
			END;
			
			RETURN modInputOptions_PostBeneficiaryFraud; 
		END;
	
	EXPORT get_gateways(Models.BeneficiaryRiskScore_Interfaces.IInputOptions_BocaShell bocashell_options, unsigned ofac_version_ = 1) :=
		FUNCTION
			gateways_in   := Gateway.Configuration.Get();
      
      			Gateway.Layouts.Config gw_switch_watchlist(Gateway.Layouts.Config le) := TRANSFORM
				SELF.servicename := if(ofac_version_ = 4 and le.servicename = 'bridgerwlc', le.servicename, '');
				SELF.url := if(ofac_version_ = 4 and le.servicename = 'bridgerwlc', le.url, '');
				SELF := le;
			END;

			gateways_watchlist := PROJECT(gateways_in, gw_switch_watchlist(LEFT));
      
      			Gateway.Layouts.Config gw_switch(Gateway.Layouts.Config le) := TRANSFORM
				SELF.servicename := if(le.servicename = 'bridgerwlc', '', le.servicename);
				SELF.url := // insurance phones gateway allowed if shell version 50 or higher
					IF(
						bocashell_options.bsversion >= 50 AND 
						UCase(TRIM(le.servicename)) = Gateway.Constants.ServiceName.InsurancePhoneHeader, 
						le.url, 
						'' 
					); 
				SELF := le;
			END;
      
      gateways_boca_shell := PROJECT(gateways_in, gw_switch(LEFT));
      
      gateways := gateways_watchlist + gateways_boca_shell;
			
			RETURN gateways;
		END;

	// -----------------------------------------------------------------------------------------------
	//
	//           [ Functions for transforming query input (search subject) for processing ]           
	//
	// -----------------------------------------------------------------------------------------------
	
	EXPORT convert_search_subject_to_datarow(Models.BeneficiaryRiskScore_Interfaces.ISearchSubject search_subject) :=
		FUNCTION

			Models.BeneficiaryRiskScore_Layouts.SearchSubject xfm_to_datarow(Models.BeneficiaryRiskScore_Interfaces.ISearchSubject le) := 
				TRANSFORM
					SELF.acctno               := le.acctno;
					SELF.seq                  := le.seq;
					SELF.history_date         := le.history_date;
					SELF.historyDateTimeStamp := le.historyDateTimeStamp;
					SELF.did_value            := le.did_value;
					SELF.full_name_value      := le.full_name_value;
					SELF.first_name_value     := le.first_name_value;
					SELF.middle_name_value    := le.middle_name_value;
					SELF.last_name_value      := le.last_name_value;
					SELF.name_suffix_value    := le.name_suffix_value;
					SELF.addr1_value          := le.addr1_value;
					SELF.addr2_value          := le.addr2_value;
					SELF.city_value           := le.city_value;
					SELF.state_value          := le.state_value;
					SELF.zip_value            := le.zip_value;
					SELF.country_value        := le.country_value;
					SELF.ssn_value            := le.ssn_value;
					SELF.dob_value            := le.dob_value;
					SELF.age_value            := le.age_value;
					SELF.dl_number_value      := le.dl_number_value;
					SELF.dl_state_value       := le.dl_state_value;
					SELF.email_value          := le.email_value;
					SELF.ip_value             := le.ip_value;
					SELF.phone_value          := le.phone_value;
					SELF.wphone_value         := le.wphone_value;
					SELF.employer_name_value  := le.employer_name_value;
					SELF.prev_lname_value     := le.prev_lname_value;
					SELF.case_number          := le.case_number;
					SELF.benefit_claim_amount := le.benefit_claim_amount;
					SELF.benefits_issued_state   := le.benefits_issued_state;
					SELF.date_applied_for_benefits  := le.date_applied_for_benefits;
					SELF.mvr_vehicle_value          := le.mvr_vehicle_value;
					SELF.number_mvrs_reported       := le.number_mvrs_reported;
					SELF.number_properties_reported := le.number_properties_reported;
					SELF.number_adults_in_household := le.number_adults_in_household;
					SELF.filler_field_1             := le.filler_field_1;
				END;
			
			ds_search_subject := DATASET( [xfm_to_datarow(search_subject)] );
			
			RETURN ds_search_subject;
		END;
	
	EXPORT Models.BeneficiaryRiskScore_Layouts.SearchSubjectCleaned xfm_add_cleaned_fields(Models.BeneficiaryRiskScore_Layouts.SearchSubject le, INTEGER c) :=
		TRANSFORM
			valid_cleaned := le.full_name_value != '';
			cleaned_name  := Address.CleanPerson73(le.full_name_value);
			street_addr   := le.addr1_value + IF( TRIM(le.addr2_value) = '', '', ' ' + TRIM(le.addr2_value) );
			clean_addr    := Risk_Indicators.MOD_AddressClean.clean_addr(street_addr, le.city_value, le.state_value, le.zip_value);
			cleaned       := Address.CleanFields(clean_addr);
			dob_val       := RiskWise.cleanDOB(le.dob_value);
			dl_num_clean  := RiskWise.cleanDL_num(le.dl_number_value);
			
			SELF.seq           := c;
			SELF.title         := UCase(IF(valid_cleaned, cleaned_name[1..5], ''));
			SELF.fname         := UCase(IF(le.first_name_value  = '' AND valid_cleaned, cleaned_name[6..25] , le.first_name_value));
			SELF.mname         := UCase(IF(le.middle_name_value = '' AND valid_cleaned, cleaned_name[26..45], le.middle_name_value));
			SELF.lname         := UCase(IF(le.last_name_value   = '' AND valid_cleaned, cleaned_name[46..65], le.last_name_value));
			SELF.suffix        := UCase(IF(le.name_suffix_value = '' AND valid_cleaned, cleaned_name[66..70], le.name_suffix_value));
			SELF.streetAddress := UCase(street_addr);
			SELF.prim_range    := cleaned.prim_range;
			SELF.predir        := cleaned.predir;
			SELF.prim_name     := cleaned.prim_name;
			SELF.addr_suffix   := cleaned.addr_suffix;
			SELF.postdir       := cleaned.postdir;
			SELF.unit_desig    := cleaned.unit_desig;
			SELF.sec_range     := cleaned.sec_range;
			SELF.p_city_name   := cleaned.p_city_name;
			SELF.st            := cleaned.st;
			SELF.z5            := cleaned.zip;
			SELF.zip4          := cleaned.zip4;
			SELF.lat           := cleaned.geo_lat;
			SELF.long          := cleaned.geo_long;
			SELF.addr_type     := cleaned.rec_type[1];
			SELF.addr_status   := cleaned.err_stat;		
			SELF.county        := cleaned.county[3..5]; // county[1..2] = state fips; last 3 are county.
			SELF.geo_blk       := cleaned.geo_blk;
			SELF.dob           := dob_val;
			SELF.dl_number     := UCase(dl_num_clean);		
			SELF               := le;
		END;
	
	EXPORT risk_indicators.Layout_Input xfm_to_input_IID(Models.BeneficiaryRiskScore_Layouts.SearchSubjectCleaned le ) := 
		TRANSFORM
			SELF.seq              := le.seq;
			self.historydate 			:= if(le.historyDateTimeStamp<>'',(unsigned)le.historyDateTimeStamp[1..6], le.history_date); 
			SELF.historyDateTimeStamp := 
					risk_indicators.iid_constants.mygetdateTimeStamp(le.historydateTimeStamp, le.history_date);
			SELF.DID              := (UNSIGNED6)le.did_value;
			SELF.score            := if( (UNSIGNED6)le.did_value != 0, 100, 0 ); 	
			SELF.title            := le.title;
			SELF.fname            := le.fname;
			SELF.mname            := le.mname;
			SELF.lname            := le.lname;
			SELF.suffix           := le.suffix;
			SELF.in_streetAddress := le.streetAddress;
			SELF.in_city          := UCase(le.city_value);
			SELF.in_state         := UCase(le.state_value);
			SELF.in_zipCode       := le.zip_value;
			SELF.in_country       := UCase(le.country_value);
			SELF.prim_range       := le.prim_range;
			SELF.predir           := le.predir;
			SELF.prim_name        := le.prim_name;
			SELF.addr_suffix      := le.addr_suffix;
			SELF.postdir          := le.postdir;
			SELF.unit_desig       := le.unit_desig;
			SELF.sec_range        := le.sec_range;
			SELF.p_city_name      := le.p_city_name;
			SELF.st               := le.st;
			SELF.z5               := le.z5;
			SELF.zip4             := le.zip4;
			SELF.lat              := le.lat;
			SELF.long             := le.long;
			SELF.addr_type        := le.addr_type;
			SELF.addr_status      := le.addr_status;		
			SELF.county           := le.county;
			SELF.geo_blk          := le.geo_blk;
			SELF.country          := UCase(le.country_value);
			SELF.ssn              := le.ssn_value;
			SELF.dob              := le.dob;
			SELF.age              := 
					IF(
						le.age_value = 0 AND (INTEGER)le.dob_value != 0, 
						(STRING3)ut.Age((UNSIGNED)le.dob_value, (UNSIGNED)risk_indicators.iid_constants.myGetDate(le.history_date)), 
						(STRING3)le.age_value
					);
			SELF.dl_number        := le.dl_number;
			SELF.dl_state         := UCase(le.dl_state_value);
			SELF.email_address    := le.email_value;
			SELF.ip_address       := le.ip_value;
			SELF.phone10          := le.phone_value;
			SELF.wphone10         := le.wphone_value;
			SELF.employer_name    := UCase(le.employer_name_value);
			SELF.lname_prev       := UCase(le.prev_lname_value);
		END;

	EXPORT Models.Layout_PostBeneficiaryFraud.BatchInput_With_Seq xfm_to_input_PBF(Models.BeneficiaryRiskScore_Layouts.SearchSubjectCleaned le) := 
		TRANSFORM		
			SELF.seq                   := le.seq;
			SELF.acctno                := le.acctno;
			SELF.unparsed_full_name    := le.full_name_value;
			SELF.name_first            := le.fname;
			SELF.name_middle           := le.mname;
			SELF.name_last             := le.lname;
			SELF.ssn                   := le.ssn_value;
			SELF.dob                   := le.dob;
			SELF.street_address        := le.streetAddress;
			SELF.p_city_name           := UCase(le.city_value);
			SELF.st                    := UCase(le.state_value);
			SELF.z5                    := le.z5;
			SELF.home_phone            := le.phone_value;
			SELF.dl_number             := le.dl_number;
			SELF.dl_state              := UCase(le.dl_state_value);	
			SELF.case_number           := UCase(le.case_number);
			SELF.claim_amount          := le.benefit_claim_amount;
			SELF.input_state           := UCase(le.benefits_issued_state);
			SELF.input_date            := le.date_applied_for_benefits;
			SELF.mvr_vehicle_threshold := le.mvr_vehicle_value;
			SELF.number_of_mvr         := (UNSIGNED2)le.number_mvrs_reported;
			SELF.number_of_properties  := (UNSIGNED2)le.number_properties_reported;
			SELF.number_of_adults      := (UNSIGNED1)le.number_adults_in_household;
			SELF.filler                := '';
		END;

	// -----------------------------------------------------------------------------------------------
	//
	//                         [ Functions for query processing and output ]                          
	//
	// -----------------------------------------------------------------------------------------------
	
	// The following function is cribbed from VehicleV2_Services.RealTime_Batch_Service_Records
	// and simplified to remove unnecessary filters.
	EXPORT Get_RTVehicleSearch(DATASET(VehicleV2_Services.Batch_Layout.RealTime_InLayout) inputData) := 
		FUNCTION
			inputParams := AutoStandardI.GlobalModule();

			layoutAcctNoRpt := RECORD
				VehicleV2_Services.Batch_Layout.RealTime_InLayout.AcctNo;
				VehicleV2_Services.Layout_Report_RealTime;
			END;

			layoutAcctNoChildRpt := RECORD
				VehicleV2_Services.Batch_Layout.RealTime_InLayout.AcctNo;
				DATASET(layoutAcctNoRpt) gatewayData {MAXCOUNT(VehicleV2_Services.Constant.max_child_count)};
			END;

			layoutAcctNoChildRpt vehicleGateway(VehicleV2_Services.Batch_Layout.RealTime_InLayout le) := 
				TRANSFORM
					
					tempmod := MODULE( PROJECT( inputParams,VehicleV2_Services.IParam.polkParams, opt ) )
						EXPORT STRING30  firstName       := le.name_first;
						EXPORT STRING30  middleName      := le.name_middle;
						EXPORT STRING30  lastName        := le.name_last;
						EXPORT STRING    name_Suffix     := le.name_suffix;
						EXPORT STRING120 companyName     := le.comp_name;
						EXPORT STRING200 addr            := TRIM(le.addr1) + ' ' + le.addr2;
						EXPORT STRING25  city            := le.p_city_name;
						EXPORT STRING2   state           := IF( le.st <> '', le.st, le.plateState );
						EXPORT STRING6   zip             := le.z5;
						EXPORT STRING    licensePlateNum := '';
						EXPORT STRING    vin_In          := '';
						EXPORT STRING    modelYear       := '';
						EXPORT STRING    make            := '';
						EXPORT STRING    model           := '';
						EXPORT STRING50	 ReferenceCode   := '' : STORED('ReferenceCode');
						EXPORT STRING20	 BillingCode     := '' : STORED('BillingCode');
						EXPORT STRING50	 QueryId         := '' : STORED('QueryId');
						EXPORT STRING    RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
						EXPORT STRING    SubCustomerID   := '' : STORED('SubCustomerID');
						EXPORT STRING    DataSource      := VehicleV2_Services.Constant.Realtime_val;
						EXPORT BOOLEAN   noFail          := TRUE;
					END;
					
					validInput := (le.addr1 + le.p_city_name + le.st + le.z5) != '';
					
					gatewayVehicleData := 
						IF(
							validInput,
							CHOOSEN(
								SORT( // Get Gateway results
									VehicleV2_Services.Get_Gateway_Data(tempmod),
									-registrants[1].reg_latest_effective_date, -registrants[1].reg_latest_expiration_date
								),
								VehicleV2_Services.Constant.max_child_count),
							DATASET([], VehicleV2_Services.Layout_Report_RealTime)
						);
					
					SELF.acctNo := le.acctNo;
					SELF.gatewayData := 
						PROJECT(
							gatewayVehicleData,
							TRANSFORM( LayoutAcctNoRpt,
								SELF.AcctNo := le.AcctNo,
								SELF := LEFT
							)
						);
				END;
				
				gatewayData := PROJECT( inputData, vehicleGateway(LEFT) );
				
				gatewayNorm := 
					NORMALIZE( 
						gatewayData, 
						LEFT.gatewayData, 
						TRANSFORM(VehicleV2_Services.Layouts.Layout_Report_Batch_New, SELF := RIGHT) 
					);
				
				RETURN gatewayNorm;
			END;
	
	EXPORT fn_getMVRInfo( GROUPED DATASET(Risk_Indicators.Layout_Output) iid_results,
	                      Models.BeneficiaryRiskScore_Interfaces.IInputOptions_PostBeneficiaryFraud pbfSvcOptions) :=
		FUNCTION
			is_RealTime_search := pbfSvcOptions.Include_Real_Time_Motor_Vehicle2;
			
			boca_shell_ids :=
				PROJECT( 
					iid_results,
					TRANSFORM( Risk_Indicators.Layout_Boca_Shell_ids,
						SELF.seq         := LEFT.seq,
						SELF.historydate := LEFT.historydate,
						SELF.did         := LEFT.did,
						SELF.isrelat     := FALSE,
						SELF.fname       := '',
						SELF.lname       := '',
						SELF.relation    := '', 
						SELF             := [] // i.e. Layout_Overrides
					)
				);

			boca_shell_ids_grpd := GROUP( SORT( boca_shell_ids, seq ), seq );

			// Local layouts...:
			layout_vehicle_key_plus_did := 
				RECORD(VehicleV2_Services.Layout_Vehicle_Key)
					INTEGER seq;
					UNSIGNED6	did;
					UNSIGNED3 historydate;
				END;

			layout_vehicle_key_plus_did xfm1(Risk_Indicators.Layout_Boca_Shell_ids l, VehicleV2.Key_Vehicle_DID r) := TRANSFORM
				SELF.seq           := l.seq; 
				SELF.did           := r.Append_DID;
				SELF.historydate   := l.historydate; // YYYYMM
				SELF.Vehicle_Key   := r.Vehicle_Key;
				SELF.Iteration_Key := r.Iteration_Key;
				SELF.Sequence_Key  := r.Sequence_Key;
				SELF.state_origin  := ''; //needed for dppa stuff
				SELF.is_deep_dive  := false;
			END;

			// 1. Join ids to the did key to get vehicle key information; sort and dedup.
			seq_vehicle_keys := 
				JOIN(
					boca_shell_ids_grpd, VehicleV2.Key_Vehicle_DID, 
					KEYED(LEFT.did = RIGHT.Append_DID), 
					xfm1(LEFT, RIGHT),
					ATMOST(1000)
				);

			vehicle_keys_ddpd := 
				DEDUP(
					SORT(
						seq_vehicle_keys, seq, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin
					),
					seq, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin
				);

			// 2. Transform vehicle keys data to layout needed for vehicle search; sort and group.
			// Note that we have to do a slightly awkward transformation seq --> acctno, since the 
			// formal parameter 'ids' doesn't have an acctno field. But the vehicle search requires 
			// an acctno value to differentiate input records properly.
			in_veh_keys := 
				PROJECT(
					vehicle_keys_ddpd,
					TRANSFORM( VehicleV2_Services.Layout_VKeysWithInput, 
						SELF.acctno := (STRING20)LEFT.seq,
						SELF := LEFT, 
						SELF := []
					)
				);

			in_veh_keys_grpd := 
				GROUP( 
					SORT( 
						in_veh_keys, Vehicle_Key, Iteration_Key, Sequence_Key 
					), 
					Vehicle_Key, Iteration_Key, Sequence_Key 
				);

			// 3. Define search module needed for inhouse vehicle search and get vehicle search records.
			in_mod := VehicleV2_Services.IParam.getSearchModule();

			VehicleV2_Services.Layouts.Layout_Report_Batch_New // it's { acctno, VehicleV2_Services.Layout_Report }
					inhouse_vehicles_pre := VehicleV2_Services.Functions.Get_VehicleSearch( in_mod, in_veh_keys_grpd );

			// 4. Get RealTime vehicle search records.
			VehicleV2_Services.Batch_Layout.RealTime_InLayout xfm_to_RT_input(Risk_Indicators.Layout_Output le) :=
				TRANSFORM
					SELF.acctNo      := (STRING)le.seq;
					SELF.name_full   := '';
					SELF.name_first  := le.fname;
					SELF.name_middle := le.mname;
					SELF.name_last   := le.lname;
					SELF.name_suffix := le.suffix;
					SELF.comp_name   := '';
					SELF.addr1       := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name,
					        le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);
					SELF.addr2       := '';
					SELF.p_city_name := le.p_city_name;
					SELF.st          := le.st;
					SELF.z5          := le.z5;
					SELF             := [];					
				END;
			
			input_to_RTVehicleSearch := PROJECT( UNGROUP(iid_results), xfm_to_RT_input(LEFT) );
			
			VehicleV2_Services.Layouts.Layout_Report_Batch_New 
					realtime_vehicles_pre := Get_RTVehicleSearch( input_to_RTVehicleSearch );

			vehicles_pre := IF( is_RealTime_search, realtime_vehicles_pre, UNGROUP(inhouse_vehicles_pre) );
			
			// ----------[ Isolate vehicle registrations. ]----------

			layout_registrations := record
				UNSIGNED4 seq;
				UNSIGNED6 did;
				UNSIGNED3 historydate;
				VehicleV2_Services.Layout_Report AND NOT [matched_party, owners, lienholders, lessees, lessors, brands];
			end;

			vehicle_registrations := 
				JOIN(
					boca_shell_ids_grpd, vehicles_pre,
					LEFT.seq = (INTEGER)RIGHT.acctno,
					TRANSFORM( layout_registrations,
						SELF.seq := LEFT.seq,
						SELF.did := LEFT.did,
						SELF.historydate := LEFT.historydate,
						SELF := RIGHT
					),
					INNER,
					ATMOST(1000)
				);

			// Throw out any blank registrations and any Registrants whose DID doesn't match that 
			// of the input record. This shall leave us with one valid Registrant per vehicle record.
			vehicles_valid_registrations :=	
				PROJECT(
					vehicle_registrations( COUNT(Registrants) > 0 ),
					TRANSFORM( layout_registrations,
						SELF.Registrants := LEFT.Registrants( (UNSIGNED6)append_did = LEFT.did ),
						SELF := LEFT
					)
				);

			// Note: In VehicleV2.file_bocashell_vehicles, year_make, make, and model are assigned 
			// values from Best_Model_Year, Best_Make_Code, and Best_Model_Code, respectively. 
			// Turns outthat Best_Model_Code is pretty sparse. In the transform below we're using  
			// slightly different data that should be a bit more useful: le.model_year is just a  
			// year; le.make_desc is not a code--it spells out entirely the make of the vehicle; 
			// and le.vina_vp_series_name is the concatenation of the Model and Series data.	
			layout_registrants_slim := RECORD
				UNSIGNED4 seq;
				UNSIGNED6 did;
				UNSIGNED3 historydate;
				STRING30 Vehicle_Key;   
				STRING25 vin;
				STRING2  orig_state;
				STRING4  year_make;
				STRING30 make;		
				STRING30 model;
				UNSIGNED6 base_price;
				STRING4  registration_type_code;
				STRING30 registration_type_code_desc;
				UNSIGNED3 earliest_registration_date;
				UNSIGNED3 latest_registration_expiration_date;
				BOOLEAN is_commercial;
			END;

			layout_registrants_slim get_registration_info(layout_registrations le) := TRANSFORM
				type_code := le.registrants[1].reg_license_plate_type_code;
				type_desc := UCase(le.registrants[1].reg_license_plate_type_desc);
				
				SELF.seq           := le.seq;
				SELF.did           := le.did;
				SELF.historydate   := le.historydate,
				SELF.Vehicle_Key   := le.Vehicle_Key;
				SELF.vin           := le.vin;
				SELF.orig_state    := le.state_origin;
				SELF.year_make     := le.model_year;
				SELF.make          := UCase(le.make_desc);		
				SELF.model         := UCase(le.vina_vp_series_name);
				SELF.base_price    := (UNSIGNED6)le.base_price;
				SELF.registration_type_code       := type_code;
				SELF.registration_type_code_desc  := type_desc;
				SELF.earliest_registration_date   := 
						(UNSIGNED3)le.registrants[1].reg_earliest_effective_date[1..6];
				SELF.latest_registration_expiration_date := 
						(UNSIGNED3)le.registrants[1].reg_latest_expiration_date[1..6];
				SELF.is_commercial := 
						MAP(
							type_code IN ['CML', 'COM', 'XC']                           => TRUE,
							type_code = 'NC' AND type_desc != 'NON-COMMERCIAL TRUCK'    => TRUE,
							type_code = 'TC' AND type_desc = 'COMERCIAL (REGULAR TRUCK' => TRUE, // Yep--just one 'M'.
							type_code = 'TK' AND type_desc = 'COMMERCIAL TRUCK'         => TRUE,
							type_code = 'TL' AND type_desc = 'COMMERCIAL TRAILER'       => TRUE,
							/* default.....: */ FALSE
						);
			END;

			registrants_slimmed := PROJECT(vehicles_valid_registrations, get_registration_info(LEFT));
					
			registrants_grouped := 
				GROUP( 
					SORT( 
						registrants_slimmed, 
						seq, did, vehicle_key, -latest_registration_expiration_date 
					),
					seq, did, vehicle_key
				);

			layout_registrants_slim xfm_rollup_registrations( layout_registrants_slim le, DATASET(layout_registrants_slim) allRows ) :=
				TRANSFORM
					SELF.seq           := le.seq;
					SELF.did           := le.did;
					SELF.historydate   := le.historydate,
					SELF.Vehicle_Key   := le.Vehicle_Key;
					SELF.vin           := le.vin;
					SELF.orig_state    := le.orig_state;
					SELF.year_make     := le.year_make;
					SELF.make          := le.make;		
					SELF.model         := le.model;
					SELF.base_price    := MAX(allRows,base_price);
					SELF.registration_type_code       := allRows[1].registration_type_code;
					SELF.registration_type_code_desc  := allRows[1].registration_type_code_desc;
					SELF.earliest_registration_date   := MIN(allRows,earliest_registration_date);
					SELF.latest_registration_expiration_date := MAX(allRows,latest_registration_expiration_date);	
					SELF.is_commercial := allRows[1].is_commercial;
				END;

			registrants_rolled := ROLLUP( registrants_grouped, GROUP, xfm_rollup_registrations(LEFT, ROWS(LEFT)) );

			// ----------[ Isolate vehicle owners for the ttl_earliest_issue_date. ]----------

			// Isolate vehicle owners.
			layout_owners := record
				UNSIGNED4 seq;
				UNSIGNED6 did;
				UNSIGNED3 historydate;
				VehicleV2_Services.Layout_Report AND NOT [matched_party, registrants, lienholders, lessees, lessors, brands];
			end;

			vehicle_owners := 
				JOIN(
					boca_shell_ids_grpd, vehicles_pre,
					LEFT.seq = (INTEGER)RIGHT.acctno,
					TRANSFORM( layout_owners,
						SELF.seq := LEFT.seq,
						SELF.did := LEFT.did,
						SELF.historydate := LEFT.historydate,
						SELF := RIGHT
					),
					INNER,
					ATMOST(1000)
				);

			// Throw out any blank owner records and any Owners who don't match the input record.
			vehicles_valid_owners :=	
				PROJECT(
					vehicle_owners( COUNT(Owners) > 0 ),
					TRANSFORM( layout_owners,
						SELF.Owners := LEFT.Owners( (UNSIGNED6)append_did = LEFT.did ),
						SELF := LEFT
					)
				);

			layout_owners_slim := RECORD
				UNSIGNED4 seq;
				UNSIGNED6 did;
				UNSIGNED3 historydate;
				STRING30 Vehicle_Key;   
				STRING25 vin;
				UNSIGNED3 ttl_earliest_issue_date := 0; 
			END;

			layout_owners_slim get_owner_info(layout_owners le) := TRANSFORM
				SELF.seq           := le.seq;
				SELF.did           := le.did;
				SELF.historydate   := le.historydate,
				SELF.Vehicle_Key   := le.Vehicle_Key;
				SELF.vin           := le.vin;
				SELF.ttl_earliest_issue_date := (UNSIGNED3)le.owners[1].ttl_earliest_issue_date[1..6];
			END;

			owners_slimmed := PROJECT(vehicles_valid_owners, get_owner_info(LEFT));
				
			owners_grouped := 
				GROUP( 
					SORT( 
						owners_slimmed, 
						seq, did, vehicle_key, ttl_earliest_issue_date 
					),
					seq, did, vehicle_key
				);

			layout_owners_slim xfm_rollup_owners( layout_owners_slim le, DATASET(layout_owners_slim) allRows ) :=
				TRANSFORM
					SELF.seq           := le.seq;
					SELF.did           := le.did;
					SELF.historydate   := le.historydate,
					SELF.Vehicle_Key   := le.Vehicle_Key;
					SELF.vin           := le.vin;
					SELF.ttl_earliest_issue_date := MIN(allRows,ttl_earliest_issue_date);		
				END;

			owners_rolled := ROLLUP( owners_grouped, GROUP, xfm_rollup_owners(LEFT, ROWS(LEFT)) );

			// Join owners to registrations.
			layout_vehicles_slim := RECORD
				layout_registrants_slim OR layout_owners_slim;
			END;

			// Join registrant records to owner records to get the ttl_earliest_issue_date, and use a conditional 
			// to prevent '0' from being assigned to ttl_earliest_issue_date; reset history date to this
			// month if it's 0 or 999999.
			vehicle_recs :=
				JOIN(
					registrants_rolled, owners_rolled,
					LEFT.seq = RIGHT.seq AND
					LEFT.did = RIGHT.did AND
					LEFT.vehicle_key = RIGHT.vehicle_key,
					TRANSFORM( layout_vehicles_slim, 
						SELF.historydate := 
								IF( 
									LEFT.historydate IN [ 0,999999 ] OR pbfSvcOptions.Include_Real_Time_Motor_Vehicle2, 
									(UNSIGNED3)(((STRING)Std.Date.Today())[1..6]), 
									LEFT.historydate 
								),
						SELF.ttl_earliest_issue_date := 
								IF( LEFT.vehicle_key = RIGHT.vehicle_key, RIGHT.ttl_earliest_issue_date, 999999 ),
						SELF := LEFT,
						SELF := RIGHT,
						SELF := []
					),
					LEFT OUTER,
					KEEP(1)
				);

			vehicle_recs_filtered :=  
				UNGROUP(vehicle_recs)( 
					(
						historydate BETWEEN 
							MIN( ttl_earliest_issue_date, earliest_registration_date ) AND latest_registration_expiration_date 
					) 
					OR
					is_RealTime_search
				);

			Models.BeneficiaryRiskScore_Layouts.vehicles_rolled xfm_roll_vehicles( layout_vehicles_slim le, DATASET(layout_vehicles_slim) allRows) := 
				TRANSFORM
					SELF.seq         := le.seq;
					SELF.did         := le.did;
					SELF.historydate := le.historydate;
					SELF.vehicles    := PROJECT( allRows, Models.BeneficiaryRiskScore_Layouts.vehicle_info );
					SELF             := [];
				END;
				
			vehicle_recs_rolled :=
				ROLLUP(
					GROUP(SORT(vehicle_recs_filtered, seq, did), seq, did),
					GROUP,
					xfm_roll_vehicles(LEFT, ROWS(LEFT))
				);
		
			RETURN vehicle_recs_rolled;
	END;
	
	EXPORT capU(UNSIGNED input, UNSIGNED lower, UNSIGNED upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
				
	EXPORT transform_postbeneficiaryfraud_results(
		DATASET(Models.Layout_PostBeneficiaryFraud.BatchInput_With_Seq) pbf_prep,
		DATASET(Models.Layout_PostBeneficiaryFraud.Combined_Attributes) results_PostBeneficiaryFraud,
		Models.BeneficiaryRiskScore_Interfaces.IInputOptions_PostBeneficiaryFraud options ) :=
			FUNCTION
				cap_min := 0;
				cap_max := 255;
				
				Models.Layout_PostBeneficiaryFraud.Final_Plus 
					xfm_final_output(
						Models.Layout_PostBeneficiaryFraud.BatchInput_With_Seq le,
						Models.Layout_PostBeneficiaryFraud.Combined_Attributes ri ) := 
							TRANSFORM
								license_category := Risk_Indicators.getPLinfo(ri.license_type).PLcategory;		
								
								SELF.VerifiedSSN      := ri.VerifiedSSN;
								SELF.VerifiedName     := ri.VerifiedName;
								SELF.VerifiedAddress  := ri.VerifiedAddress;
								SELF.VerifiedDOB      := ri.VerifiedDOB;
								SELF.VerifiedPhone    := ri.VerifiedPhone;
								SELF.IdentityValid    := ri.IdentityValid;
								SELF.DuplicateEntry   := IF(ri.repeat_did_count > 1, '1', '0');
								SELF.InvalidSSN       := ri.InvalidSSN;
								SELF.SSNLowIssueDate  := ri.LowIssueDate;
								SELF.SSNHighIssueDate := ri.HighIssueDate;
								SELF.SSNIssueState    := ri.SSNIssueState;
								SELF.isIssuedPrior    := ri.SSNIssuedPrior;
								SELF.InputSSNpossrandomized :=
									MAP(
										le.ssn = '' => '-1',
										IF(Risk_Indicators.rcSet.isCodeRS(le.ssn, ri.socsvalflag, ri.LowIssueDate, ri.socsRCISflag),
											 '1',
											 '0'));
								SELF.InputSSNpossrandominvalid :=
									MAP(
										le.ssn = '' => '-1',
										IF(Risk_Indicators.rcSet.isCodeIS(le.ssn, ri.socsvalflag, ri.LowIssueDate, ri.socsRCISflag),
											 '1',
											 '0'));
								SELF.SSNDeceased         := ri.SSNDeceased;
								SELF.SSNDateDeceased     := ri.DateSSNDeceased;
								SELF.SharedAddress       := ri.SharedAddress;
								SELF.NumSharedAddr       := ri.NumAtSharedAddr;
								SELF.RelativesSharedAddr := ri.RelativesAtSharedAddr;
								SELF.NumRelativesAtAddr  := ri.NumRelativesAtAddrOnInputDate;
								SELF.AssociateSharedAddr := ri.AssociateAtSharedAddr;
								SELF.NumAssociatesAtAddr := ri.NumAssociatesAtAddrOnInputDate;
								SELF.NumofAdults         := ri.NumofAdultsNotReported;
								SELF.DLnumoutofState     := ri.DLNumberOutOfState;
								SELF.DLissuedState       := ri.DLStateIssued;
								SELF.RealProperty := 
									IF(options.INCLUDE_PROPERTY,
										IF(ri.total_owned_property > 0, '1', '0'),
										'');
								SELF.MultipleProperties :=
									MAP(
										~options.INCLUDE_PROPERTY => '',
										le.number_of_properties = 0 => '0',
										(options.Date_Cutoff BETWEEN 0 AND 255) AND ri.total_owned_property = 0 => '-1',
										ri.total_owned_property > le.number_of_properties => '1',
										'0');
								SELF.NumMultipleProperties := 
									IF(options.INCLUDE_PROPERTY,
										(STRING)capU(ri.total_owned_property, cap_min, cap_max),
										'');
								SELF.RealPropertyoutofState :=
									MAP(
										~options.INCLUDE_PROPERTY => '',
										(options.Date_Cutoff BETWEEN 0 AND 255) AND ri.total_owned_property_out_of_state = 0 => '-1',
										ri.total_owned_property_out_of_state > 0 => '1',
										'0');
								// The following MVR fields will be calculated in a later join. Assign default values now.
								SELF.MVRvaluegreaterthanthreshold := '0';
								SELF.MVRreglessthan20yrs          := '0';
								SELF.NumUnreportedMVR             := '0';
								SELF.MVRCommercial                := '0';
								SELF.NumMVRCommercial             := '';
								SELF.WatercraftCount := IF(options.INCLUDE_WATERCRAFT_AND_AIRCRAFT,
																					 (STRING)capU(ri.watercraft_count, cap_min, cap_max),
																					 '');
								SELF.AircraftCount := IF(options.INCLUDE_WATERCRAFT_AND_AIRCRAFT,
																				 (STRING)capU(ri.aircraft_count, cap_min, cap_max),
																				 '');
								SELF.ProfLicissued := IF(options.INCLUDE_PROFESSIONAL_LICENSE,
																				 IF(ri.prof_license_count > 0, '1', '0'),
																				 '');
								SELF.ProfLicCount := IF(options.INCLUDE_PROFESSIONAL_LICENSE,
																				(STRING)capU(ri.prof_license_count, cap_min, cap_max),
																				'');
								SELF.ProfLicTypeCategory := IF(options.INCLUDE_PROFESSIONAL_LICENSE,
																							 IF(license_category = '', '-1', license_category),
																							 '');
								SELF.BusinessAffiliations := IF(options.INCLUDE_BUSINESS_AFFILIATIONS,
																								IF(ri.affiliation_count > 0, '1', '0'),
																								'');
								SELF.PossibleWorkLocation := IF(options.INCLUDE_PEOPLE_AT_WORK,
																								IF(ri.paw_count > 0, '1', '0'),
																								'');
								SELF.BankruptcyCount := IF(options.INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
																					 (STRING)capU(ri.bankruptcy_count, cap_min, cap_max),
																					 '');
								SELF.LiensorJudgments := IF(options.INCLUDE_BANKRUPTCY_LIENS_JUDGEMENTS,
																						(STRING)capU(ri.liens_count, cap_min, cap_max),
																						'');
								SELF.PossibleIncarceration := IF(options.INCLUDE_CRIMINAL_SOFR,
																								 IF(ri.is_in_jail, '1', '0'),
																								 '');
								SELF.PossibleSOFR := IF(options.INCLUDE_CRIMINAL_SOFR,
																				IF(ri.has_sofr, '1', '0'),
																				'');
								SELF.UCCFiling := IF(options.INCLUDE_UCC_FILINGS,
																		 (STRING)capU(ri.UCC_count, cap_min, cap_max),
																		 '');
								SELF.CurrentBestAddressHighRisk := ri.address_high_risk;
								SELF.CurrentBestAddrHRRC1       := ri.CurrentBestAddrHRRC1;
								SELF.CurrentBestAddrHRDesc1     := ri.CurrentBestAddrHRDesc1;
								SELF.CurrentBestAddrHRRC2       := ri.CurrentBestAddrHRRC2;
								SELF.CurrentBestAddrHRDesc2     := ri.CurrentBestAddrHRDesc2;
								SELF.CurrentBestAddrHRRC3       := ri.CurrentBestAddrHRRC3;
								SELF.CurrentBestAddrHRDesc3     := ri.CurrentBestAddrHRDesc3;
								SELF.CurrentBestAddressBusiness := ri.address_business;
								SELF.CurrentBestAddressVacant   := ri.address_vacant;
								SELF.CurrAddrPrison             := ri.CurrAddrPrison;
								SELF.caaddress                  := ri.caaddress;
								SELF.cacity                     := ri.cacity;
								SELF.castate                    := ri.castate;
								SELF.cazip                      := ri.cazip;
								SELF.caphonenumber              := IF(ri.caphonenumber = '0', '', ri.caphonenumber);
								SELF.Link_ID                    := ri.did;
								SELF.input_state                := ri.input_state;
								SELF.matchcode                  := ri.matchcode;
								
								SELF := le;
							END;
					
				transformed_results :=
					JOIN(
						pbf_prep, results_PostBeneficiaryFraud,
						LEFT.seq = (UNSIGNED)RIGHT.seq,
						xfm_final_output(LEFT,RIGHT),
						LEFT OUTER
					);	
					
				RETURN transformed_results;
			END;
		
END;