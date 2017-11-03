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
  EXPORT limiter      := ' LIMIT 50 ; ';
  EXPORT read_retry   := 2;  
  EXPORT read_timeout := 75; 
  EXPORT maxRecs      := 100;
  
  EXPORT Fragment_Types := MODULE
    EXPORT PERSON_FRAGMENT := 'LEXID';
    EXPORT NAME_FRAGMENT := 'NAME';
    EXPORT SSN_FRAGMENT := 'SSN';
    EXPORT PHYSICAL_ADDRESS_FRAGMENT := 'PHYSICAL_ADDRESS';
    EXPORT MAILING_ADDRESS_FRAGMENT := 'MAILING_ADDRESS';
    EXPORT IP_ADDRESS_FRAGMENT := 'IP_ADDRESS';
    EXPORT PHONE_FRAGMENT := 'PHONE';
    EXPORT DEVICE_ID_FRAGMENT := 'DEVICE_ID';
    EXPORT DRIVERS_LICENSE_NUMBER_FRAGMENT := 'DRIVERS_LICENSE_NUMBER';
    EXPORT BANK_ACCOUNT_NUMBER_FRAGMENT := 'BANK_ACCOUNT_NUMBER';
    EXPORT GEOLOCATION_FRAGMENT := 'GEOLOCATION';
  END;

  //Mapping the FDN file type field above to our usage of the field for FraudGov
  EXPORT PayloadFileTypeEnum := ENUM(unsigned1,KnownFraud=1,IdentityActivity=3);
  
END;