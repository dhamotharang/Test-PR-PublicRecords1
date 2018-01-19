﻿IMPORT Suppress;

EXPORT Constants := MODULE

	EXPORT Platform := MODULE
		EXPORT FDN := 'FDN';
		EXPORT FraudGov	:= 'FraudGov';
	END;

  // Possible values for all the new fdn_***_ind fields being set in the 
  // 2 doxie.Header*SearchService and the 2 PersonSearch_Services.Person*Service queries
  // and in doxie.Comprehensive_Report_Service query.
  // NOTE: Do not change these values without consulting with the Accurint web development group.
  EXPORT unsigned2 FDN_DATA_FOUND     := 1;
  EXPORT unsigned2 FDN_DATA_NOT_FOUND := 0; 

  // FraudDefenseNetwork_Services.SearchService related
  EXPORT MAX_RECS_ON_JOIN    := 1000;
  EXPORT MAX_REQUIRED_INPUTS := 100;
  EXPORT PRODUCT_INCLUDE_CODE_ALL := 1; //There are many other codes in data_file

  // FDN id key classification_Permissible_use_access.file_type field possible data values
  EXPORT FileTypeCodes  := MODULE
    EXPORT CONTRIBUTORY  := 1; // 1 = Event Outcome or Contributory data
    // the 3 below are also known as Market Activity or Inquiry and Other In-house data
    EXPORT PUBLIC_RECORD := 2; // 2 = Applicable Public Records
    EXPORT TRANSACTION   := 3; // 3 = Transactions
    EXPORT RELATIONSHIP_ANALYTICS := 4; // 4 = Rel. Analytics
  END;
    
  // FDN id key classification_entity.entity_type field possible data values
  EXPORT Entity_Types := MODULE
    EXPORT string25 ADDRESS               := 'ADDRESS'; //CLEAN ADDRESS
    EXPORT string25 PERSON                := 'PERSON'; //DID
    EXPORT string25 PHONE                 := 'PHONE'; //CLEAN PHONES.PHONE NUMBER
    EXPORT string25 SSN                   := 'SSN';
    EXPORT string25 EMAIL_ADDRESS         := 'EMAIL ADDRESS';
    EXPORT string25 DEVICE_ID             := 'DEVICE ID';
    EXPORT string25 IP_ADDRESS            := 'IP ADDRESS';
    EXPORT string25 LICENSED_PROFESSIONAL := 'LICENSED PROFESSIONAL'; //PROFESSIONAL ID 
    EXPORT string25 APPENDED_PROVIDER     := 'APPENDED PROVIDER'; //APPENDED PROVIDER ID 
    EXPORT string25 BUSINESS              := 'BUSINESS'; //SELEID , ORGID , ULTID
    EXPORT string25 TIN                   := 'TIN';
  END;

  EXPORT EntityTypes_Enum := ENUM(unsigned2,
    IP_ADDRESS = 1,
    BUSINESS = 2,               //SELEID , ORGID , ULTID
    ADDRESS  = 3,
    SSN  = 4,
    PHONE = 5,                  //CLEAN PHONES.PHONE NUMBER
    DEVICE_ID = 6,
    CONTACT_NUMBER = 7,
    LICENSED_PROFESSIONAL = 8,  //PROFESSIONAL ID
    PERSON = 9,                 //DID
    TIN = 10,
    PROVIDER = 11,              //APPENDED PROVIDER ID 
    EMAIL_ADDRESS = 12);
                                
  EXPORT EntitySubTypes_Enum := ENUM(unsigned2,
    PROVIDER = 1,
    // UNKNOWN = 2, removed
    PERSON = 3,
    BUSINESS = 4);

  EXPORT SET OF STRING5 Disposition := ['OPEN','CLOSE']; 
    
  //=================================================================
  //  Delta base read & SOAPCALL related limits
  //=================================================================
  EXPORT limiter      := ' LIMIT 50 ; ';
  EXPORT read_retry   := 2;  
  EXPORT read_timeout := 75; 
  EXPORT maxRecs      := 100;

END;