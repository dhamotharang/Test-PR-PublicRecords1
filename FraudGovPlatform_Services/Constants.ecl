EXPORT Constants := MODULE

  EXPORT Defaults := MODULE
    EXPORT integer MaxResults := 2000;
    EXPORT integer MaxResultsPerAcctno := 20;
  end;
  
  EXPORT Limits := MODULE
    EXPORT integer MAX_JOIN_LIMIT := 10000;
  end;
    
  EXPORT unsigned2 FDN_DATA_FOUND     := 1;
  EXPORT unsigned2 FDN_DATA_NOT_FOUND := 0; 

  //FraudGovPlatform_Services.BatchService related
  EXPORT MAX_RECS_ON_JOIN    := 1000;
  EXPORT MAX_REQUIRED_INPUTS := 100;
		EXPORT PRODUCT_INCLUDE_CODE_ALL := 1; //There are many other codes in data_file
		EXPORT STRING FRAUD_PLATFORM := 'FraudGov';
		EXPORT INTEGER MAX_VELOCITIES := 3;		
		EXPORT INTEGER MAX_KNOWN_FRAUDS := 5;
    
  // GOV FDN id key classification_Permissible_use_access.file_type field possible data values
  EXPORT FileTypeCodes  := MODULE
    EXPORT CONTRIBUTORY  := 1; // 1 = Event Outcome or Contributory data
    // the 3 below are also known as Market Activity or Inquiry and Other In-house data
    EXPORT PUBLIC_RECORD := 2; // 2 = Applicable Public Records
    EXPORT TRANSACTION   := 3; // 3 = Transactions
    EXPORT RELATIONSHIP_ANALYTICS := 4; // 4 = Rel. Analytics
  END;

  // GOV FDN id key classification_entity.entity_type field possible data values
  EXPORT Entity_Types := MODULE
    EXPORT string25 ADDRESS := 'ADDRESS';
    EXPORT string25 PERSON  := 'PERSON';
    EXPORT string25 PHONE   := 'PHONE';
    EXPORT string25 SSN     := 'SSN';
  END;
    
  //=================================================================
  //  Delta base read & SOAPCALL related limits
  //=================================================================
  EXPORT limiter      := ' LIMIT 1000; ';
  EXPORT read_retry   := 2;  
  EXPORT read_timeout := 75; 
  EXPORT maxRecs      := 100;
	EXPORT FRAUDGOV_BUILD_ENV_VARIABLE := 'fraudgov_build_version';
  
  EXPORT Fragment_Types := MODULE
			EXPORT BANK_ACCOUNT_NUMBER_FRAGMENT := 'BANK_ACCOUNT';
			EXPORT DEVICE_ID_FRAGMENT := 'DEVICE_ID';
			EXPORT DRIVERS_LICENSE_NUMBER_FRAGMENT := 'DLN';
			EXPORT GEOLOCATION_FRAGMENT := 'GEO_LOCATION';
			EXPORT IP_ADDRESS_FRAGMENT := 'IP_ADDRESS';
			EXPORT MAILING_ADDRESS_FRAGMENT := 'MAILING_ADDRESS';
			EXPORT NAME_FRAGMENT := 'FULL_NAME';
			EXPORT PERSON_FRAGMENT := 'LEXID';
			EXPORT PHONE_FRAGMENT := 'PHONENO';
			EXPORT PHYSICAL_ADDRESS_FRAGMENT := 'PHYSICAL_ADDRESS';
			EXPORT SSN_FRAGMENT := 'FULL_SSN';
			EXPORT EMAIL_FRAGMENT := 'EMAIL';
  END;
	
	EXPORT RECORD_TYPE_ELEMENT_SET := [	Fragment_Types.SSN_FRAGMENT, 
																			Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT,
																			Fragment_Types.PHONE_FRAGMENT,
																			Fragment_Types.NAME_FRAGMENT,
																			Fragment_Types.MAILING_ADDRESS_FRAGMENT,
																			Fragment_Types.IP_ADDRESS_FRAGMENT,
																			Fragment_Types.DRIVERS_LICENSE_NUMBER_FRAGMENT,
																			Fragment_Types.BANK_ACCOUNT_NUMBER_FRAGMENT,
																			Fragment_Types.DEVICE_ID_FRAGMENT,
																			Fragment_Types.EMAIL_FRAGMENT,
																			Fragment_Types.GEOLOCATION_FRAGMENT
																		];
	
	EXPORT Contribution_Types := MODULE
			EXPORT ACTIVITY_REASON := 'ACTIVITY_REASON';
			EXPORT AGENCY_STATE := 'CUSTOMER_STATE';
			EXPORT CONTRIBUATION_ALL := 'ALL';
			EXPORT CUSTOMER := 'CUSTOMER';
			EXPORT CUSTOMER_PROGRAM := 'CUSTOMER_PROGRAM';
			EXPORT CUSTOMER_VERTICAL := 'CUSTOMER_VERTICAL';
	END;

  // Mapping the FDN file type field above to our usage of the field for FraudGov
	// file_type 2 is reserved for Applicable Public Records, not used for FraudGov.
	// file_type 4 is reserved for Relationship Analytics, not used for FraudGov.
  EXPORT PayloadFileTypeEnum := ENUM(unsigned1,KnownFraud=1,IdentityActivity=3,StatusUpdate=5);
  
	EXPORT Red_Flag_Alerts := MODULE
		EXPORT Codes := MODULE
			EXPORT Fraud_Alert := MODULE
				EXPORT IDENTITY_THEFT_ALERT := '93';
			END;
			EXPORT Credit_Freeze_Alert := MODULE
				EXPORT CREDIT_FREEZE_ALERT := '91';
			END;
				EXPORT Address_Discrepancy := MODULE
					EXPORT NAME_AND_SSN_VERIFIED := '04';
					EXPORT ADDRESS_INVALID := '11';
					EXPORT ADDRESS_UNVERIFIED:= '25';
					EXPORT ADDRESS_MISKEYED := '30';
					EXPORT ADDRESS_MISMATCH := 'CZ';
					EXPORT ADDRESS_DISCREPANCY := 'PA';
					EXPORT ADDRESS_MISMATCH_SECONDARY_RANGE := 'SR';
					EXPORT ZIP_CODE_UNVERIFIED := 'ZI';
				END;
				EXPORT Suspicious_Documents := MODULE
					EXPORT SSN_INVALID := '06';
					EXPORT DL_INVALID:= '41';
					EXPORT OTHER_DL_FOUND := 'DD';
					EXPORT DL_NOT_FOUND := 'DF';
					EXPORT DL_MISKEYED := 'DM';
					EXPORT DL_UNVERIFIED := 'DV';
				END;
				EXPORT Suspicious_Address := MODULE
					EXPORT NAME_SSN_VERIFIED := '04';
					EXPORT ADDRESS_INVALID := '19';
					EXPORT ADDRESS_UNVERIFIED:= '25';
					EXPORT ADDRESS_MISKEYED := '30';
					EXPORT ADDRESS_MISMATCH := 'CZ';
					EXPORT ADDRESS_DISCREPANCY := 'PA';
					EXPORT ADDRESS_MISMATCH_SECONDARY_RANGE := 'SR';
					EXPORT ZIP_CODE_UNVERIFIED := 'ZI'; 
				END;
				EXPORT Suspicious_SSN := MODULE
					EXPORT SSN_DECEASED := '02';
					EXPORT SSN_INVALID := '06';
					EXPORT SSN_MISKEYED := '29';
					EXPORT SSN_RECENT := '39';
					EXPORT SSN_NOT_FOUND := '71';
					EXPORT SSN_WITHIN_3_YEARS := '89';
					EXPORT SSN_AFTER_5 := '90';
					EXPORT SSN_IS_ITIN := 'IT';
					EXPORT MULTIPLE_SSNS := 'MS';
				END;
				EXPORT Suspicious_DOB := MODULE
					EXPORT SSN_PRIOR_TO_DECEASED := '03';
					EXPORT DOB_UNVERIFIED := '28';
					EXPORT DOB_MISKEYED := '83';
				END;
				EXPORT High_Risk_Address := MODULE
					EXPORT ADDRESS_INVALID := '11';
					EXPORT ZIP_IS_POB := '12';
					EXPORT ADDRESS_IS_TRANSIENT := '14';
					EXPORT ZIP_IS_CORP_MILITARY := '40';
					EXPORT ADDRESS_IS_PRISON := '50';
					EXPORT ZIP_IS_CORP := 'CO';
					EXPORT ZIP_IS_ARYMILIT := 'MO';
					EXPORT ADDRESS_IS_POB:= 'PO';
				END;
				EXPORT Suspicious_phone := MODULE
					EXPORT PHONE_DISCONNECTED := '07';
					EXPORT PHONE_INVALID := '08'; 
					EXPORT PHONE_IS_PAGER := '09';
					EXPORT PHONE_IS_MOBBILE := '10';
					EXPORT PHONE_IS_TRANSIENT := '15';
					EXPORT PHONE_ZIP_INVALID_COMBO := '16';
					EXPORT PHONE_UNVERIFIED := '27';
					EXPORT PHONE_MISKEYED:= '31';
					EXPORT PHONE_ADDR_DISTANT := '49';
					EXPORT PHONE_NOT_FOUND := '73';
					EXPORT PHONE_DIFFERENT := '74';
				END;
				EXPORT SSN_Multiple_Last := MODULE
					EXPORT SSN_DIFF_NAMES := '38';
					EXPORT SSN_SAME_FNAME:= '66';
					EXPORT SSN_DIFF_NAME_ADDR := '72';
					EXPORT SSN_MULT_IDENT := 'MI';
				END;
				EXPORT Missing_Input := MODULE
					EXPORT NAME_MISSING := '77';
					EXPORT ADDR_MISSING := '78';
					EXPORT SSN_MISSING := '79';
					EXPORT PHONE_MISSING := '80';
					EXPORT DOB_MISSING := '81';
				END;
		END;
		EXPORT Description := MODULE
				EXPORT IDENTITY_THEFT_ALERT := 'Identity Theft Alert (CRA Corrections Database)';
				EXPORT CREDIT_FREEZE_ALERT := 'Security Freeze (CRA Corrections Database)';
				EXPORT ADDRESS_DISCREPANCY := 'Address Discrepancy';
				EXPORT SUSPICIOUS_DOCUMENTS := 'Suspicious Documents';
				EXPORT SUSPICIOUS_ADDRESS := 'Suspicious Address';
				EXPORT SUSPICIOUS_SSN := 'Suspicious SSN';
				EXPORT SUSPICIOUS_DOB := 'Suspicious DOB';
				EXPORT HIGH_RISK_ADDRESS := 'High Risk Address';
				EXPORT SUSPICIOUS_PHONE := 'Suspicious Phone';
				EXPORT SSN_MULTIPLE_LAST := 'SSN Multiple Last';
				EXPORT MISSING_INPUT := 'Missing Input';
				EXPORT IDENTITY_THEFT := 'Identity Theft';
		END;
	END;
	
	EXPORT FDN := MODULE
		EXPORT gc_id := 0;
		EXPORT industry_type := 11;
		EXPORT product_code := 999;
	END;
	
	SHARED ClassificationActivity_Enum := ENUM(UNSIGNED2,
			PROBABLE = 1,
			POTENTIAL = 2,
			KNOWNGOOD = 3,
			NEUTRAL = 4,
			PROVEN = 5);
			
	EXPORT ClassificationActivitySet := [ClassificationActivity_Enum.PROBABLE, 
																			 ClassificationActivity_Enum.POTENTIAL, 
																			 ClassificationActivity_Enum.KNOWNGOOD, 
																			 ClassificationActivity_Enum.NEUTRAL, 
																			 ClassificationActivity_Enum.PROVEN];

	EXPORT ServiceType := MODULE
		EXPORT REPORT := 'FraudGovReport';
		EXPORT SEARCH := 'FraudGovSearch';
	END;

	EXPORT INQUIRY_SOURCE := 'RIN';
	
	EXPORT DELTABASE_ESP_GATEWAY_NAME := 'delta_db';

	EXPORT CIID_DESC := MODULE
			EXPORT NAS_0 := 'This identity could not be located in public records';
			EXPORT NAS_1 := 'The SSN is not associated with input name and address in public records';
			EXPORT NAP_0 := 'This name-address-phone combination could not be located in public records';
   EXPORT NAP_1 := 'The Phone is not associated with input name and address in public records';
			EXPORT CVI_00 := 'This identity could not be located in public records or may be associated with a different person';
			EXPORT CVI_10 := 'This identity could not be verified in public records or may be associated with a different person';
			EXPORT CVI_20 := 'This identity could not be verified in public records or may be associated with a different person';
	END;

	EXPORT IS_DEBUG := FALSE; 
	
	EXPORT ofac := TRUE;
	EXPORT lowestAllowedVersion := 1;	
	EXPORT	maxAllowedVersion := 1;	
	EXPORT IsInstantID := TRUE;
	
	EXPORT append_l  := 'BEST_ALL,VERIFY_ALL'; //Append_1 allows all Best Info to return
	EXPORT verify_l  := 'BEST_ALL,VERIFY_ALL';
	
	EXPORT RecordType := MODULE
		EXPORT ELEMENT := 'ELEMENT';
		EXPORT IDENTITY := 'IDENTITY';
		EXPORT CLUSTER := 'CLUSTER';
	END;
	
	EXPORT KEL_ENTITY_TYPE := MODULE
		EXPORT ENTITY_TYPE_LEXID := 1;
		EXPORT ENTITY_TYPE_PHYSICAL_ADDRESS := 9;
		EXPORT ENTITY_TYPE_SSN := 15;
		EXPORT ENTITY_TYPE_PHONENO := 16;
		EXPORT ENTITY_TYPE_EMAIL := 17;
		EXPORT ENTITY_TYPE_IPADDRESS := 18;
		EXPORT ENTITY_TYPE_BANKACCOUNT := 19;
		EXPORT ENTITY_TYPE_DLNUMBER := 20;
	END;
	
	EXPORT PHONE_TYPE := MODULE
		EXPORT PHONE_TYPE_HOME := 'HOME';
		EXPORT PHONE_TYPE_CELL := 'CELL';
		EXPORT PHONE_TYPE_WORK := 'WORK';
	END;	
	
	EXPORT KelEntityIdentifier := MODULE
		EXPORT STRING _LEXID := '_01';
		EXPORT STRING _PHYSICAL_ADDRESS := '_09';
		EXPORT STRING _SSN := '_15';
		EXPORT STRING _PHONENO := '_16';
		EXPORT STRING _EMAIL := '_17';
		EXPORT STRING _IPADDRESS := '_18';
		EXPORT STRING _BANKACCOUNT := '_19';
		EXPORT STRING _DLNUMBER := '_20';
	END;	
END;